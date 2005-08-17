From: Thibaut VARENE <varenet@esiee.fr>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI Soundchip
Date: Wed, 17 Aug 2005 12:10:17 +0300
Message-ID: <20050817101017.008D03658E8@mail.esiee.fr>
References: <Pine.HPX.4.33n.0508111716090.21860-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508111716090.21860-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org
List-Id: alsa-devel@alsa-project.org

Hi

quick reply from vacation as there are a few things i'd like to
comment upon.

Clemens Ladisch wrote:

> > I don't actually have this hardware :-), but the docs don't
mention
> > any dependency between the count registers (BC, CC) and the
interrupt
> > count registers (IC, IB).
> >
> > So wouldn't it be possible to put the ALSA buffer size into the
count
> > registers and the ALSA period size into the interrupt count
registers?

yes it would be possible, i believe.

> > This would make the interrupt handler much simpler, as it wouldn't
> > have to reprogram any registers.  And it would solve the problem
that
> > the DMA accesses for one period go beyond the buffer when the
number
> > of periods per buffer is not an integer.

correct, this was something i was planning on trying at some point,
thanks for beating me to it ;)

> ... something like this (please test):

your suggestion is good, but your patch does more than just
implementing, and there are a few things I'm not quite comfortable
with.

> Index: alsa/alsa-driver/pci/ad1889.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- alsa.orig/alsa-driver/pci/ad1889.h	2005-08-04 17:56:50.000000000
+0200
> +++ alsa/alsa-driver/pci/ad1889.h	2005-08-11 11:54:38.000000000
+0200
> @@ -172,13 +172,6 @@
>  #define AD_ADC_STATE	1
>  #define AD_MAX_STATES	2
>=20
> -/* "<ggg> T-Bone: parisc IOMMU can start DMA at any address.
> -   But the IOMMU can only map at page size granularity."
> -   This affects in particular .period_bytes_min */
> -#define BUF_SIZE        PAGE_SIZE
> -#define MAX_BUFS        32
> -#define DMA_SIZE	(MAX_BUFS*BUF_SIZE)

don't remove these defines please, i'd rather have every constants
defined in the header file. Personal taste... Besides, the comment is
very relevant to PA-RISC architecture, where no matter what the value
is, the minimum allocated space will always be at page size
granularity.


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- alsa.orig/alsa-driver/pci/ad1889.c	2005-08-11 10:46:42.000000000
+0200
> +++ alsa/alsa-driver/pci/ad1889.c	2005-08-11 12:21:21.000000000
+0200
> @@ -87,15 +87,11 @@ MODULE_PARM_DESC(ac97_quirk, "AC'97 work
>  /* let's use the global sound debug interfaces */
>  #define ad1889_debug(fmt, arg...) snd_printd(KERN_DEBUG fmt, ##
arg)
>=20
> -/* keep track of each hw register */
> +/* keep track of some hw registers */
>  struct ad1889_register_state {
>  	u16 reg;	/* reg setup */
>  	u32 addr;	/* dma base address */
> -	u16 rate;	/* sample rate */
> -	unsigned long pos;	/* last recorded DMA buffer position */
> -	unsigned long buf;	/* period # */
>  	unsigned long size;	/* DMA buffer size */
> -	unsigned long count;	/* period size, aka nb bytes sent in the
current DMA transfer */
>  };
>=20
>  struct snd_ad1889 {
> @@ -118,13 +114,6 @@ struct snd_ad1889 {
>  	struct ad1889_register_state wave;
>  	struct ad1889_register_state ramc;
>=20
> -	struct {
> -		unsigned long wav_intr;
> -		unsigned long adc_intr;
> -		unsigned long syn_intr;
> -		unsigned long res_intr;
> -	} stats;
> -
>  	spinlock_t lock;
>  };

reading the patch through webmail doesn't help a lot getting a grasp
of its whole but i wonder if we could still find some debugging
purposes for these values. Remember this driver is work in progress ;)

> @@ -172,22 +161,46 @@ ad1889_mute(struct snd_ad1889 *chip)
>  }
>=20
>  static inline void
> -ad1889_load_adc_count(struct snd_ad1889 *chip, u32 count)
> +ad1889_load_adc_buffer_address(struct snd_ad1889 *chip, u32
address)
> +{
> +	ad1889_writel(chip, AD_DMA_ADCBA, address);
> +	ad1889_writel(chip, AD_DMA_ADCCA, address);
> +}
> +
> +static inline void
> +ad1889_load_adc_buffer_count(struct snd_ad1889 *chip, u32 count)
>  {
>  	ad1889_writel(chip, AD_DMA_ADCBC, count);
>  	ad1889_writel(chip, AD_DMA_ADCCC, count);
> +}
> +
> +static inline void
> +ad1889_load_adc_interrupt_count(struct snd_ad1889 *chip, u32 count)
> +{
>  	ad1889_writel(chip, AD_DMA_ADCIB, count);
>  	ad1889_writel(chip, AD_DMA_ADCIC, count);
> -}
> +}
> +
> +static inline void
> +ad1889_load_wave_buffer_address(struct snd_ad1889 *chip, u32
address)
> +{
> +	ad1889_writel(chip, AD_DMA_WAVBA, address);
> +	ad1889_writel(chip, AD_DMA_WAVCA, address);
> +}

ok i had removed these because i felt they were just bloating the file
and were sparsely used, but ok, it's nicer that way =3D)

>  		/* flush */
>  		ad1889_readw(chip, AD_DMA_ADC);
> @@ -290,11 +303,11 @@ static snd_pcm_hardware_t snd_ad1889_pla
>  	.rate_max =3D 48000,
>  	.channels_min =3D 1,
>  	.channels_max =3D 2,
> -	.buffer_bytes_max =3D DMA_SIZE,	/* max DMA buffer size in bytes */
> -	.period_bytes_min =3D BUF_SIZE,	/* min size of period in bytes */
> -	.period_bytes_max =3D DMA_SIZE,	/* max size of period in bytes */
> -	.periods_min =3D 1,		/* min nb of periods in buffer */
> -	.periods_max =3D MAX_BUFS,
> +	.buffer_bytes_max =3D 256 * 1024,
> +	.period_bytes_min =3D 32,
> +	.period_bytes_max =3D 128 * 1024,
> +	.periods_min =3D 2,
> +	.periods_max =3D 256,
>  	/*.fifo_size =3D 0,*/
>  };

see the first comment .

> @@ -741,7 +671,7 @@ snd_ad1889_pcm_init(struct snd_ad1889 *c
>=20
>  	err =3D snd_pcm_lib_preallocate_pages_for_all(pcm,
SNDRV_DMA_TYPE_DEV,
>  						snd_dma_pci_data(chip->pci),
> -						DMA_SIZE, DMA_SIZE);
> +						128 * 1024, 256 * 1024);

again :)


This looks mostly good to me though I lack time to test and review it
more thoroughly. Hopefully I should be back later this month to give a
better look at it. I'd like to hear from Kyle as well.

Thanks for submitting this anyway.

T-Bone

--=20
Thibaut VARENE
http://www.parisc-linux.org/~varenet/


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
