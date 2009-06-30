From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Tue, 30 Jun 2009 09:42:06 -0400
Message-ID: <9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 02A1124390
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 15:42:07 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so63553qwf.56
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 06:42:07 -0700 (PDT)
In-Reply-To: <20090630061847.GA24164@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 30, 2009 at 2:18 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:

Wolfram, do you have any way to test the on the Phytec hardware? The
WM9712 on the baseboard supports a touchscreen, is it brought out to a
header?


> Hi Grant,
>
> On Mon, Jun 29, 2009 at 05:42:21PM -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> AC97 bus register read/write hooks need to provide locking, but the
>> mpc5200-psc-ac97 driver does not. =A0This patch adds a mutex around
>> the register access routines.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 =A0| =A0 =A01 +
>> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 =A0| =A0 =A01 +
>> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0 17 ++++++++++++++++-
>> =A03 files changed, 18 insertions(+), 1 deletions(-)
>>
>>
>> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
>> index efec33a..f0a2d40 100644
>> --- a/sound/soc/fsl/mpc5200_dma.c
>> +++ b/sound/soc/fsl/mpc5200_dma.c
>> @@ -456,6 +456,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> =A0 =A0 =A0 spin_lock_init(&psc_dma->lock);
>> + =A0 =A0 mutex_init(&psc_dma->mutex);
>> =A0 =A0 =A0 psc_dma->id =3D be32_to_cpu(*prop);
>> =A0 =A0 =A0 psc_dma->irq =3D irq;
>> =A0 =A0 =A0 psc_dma->psc_regs =3D regs;
>> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
>> index 2000803..8d396bb 100644
>> --- a/sound/soc/fsl/mpc5200_dma.h
>> +++ b/sound/soc/fsl/mpc5200_dma.h
>> @@ -55,6 +55,7 @@ struct psc_dma {
>> =A0 =A0 =A0 unsigned int irq;
>> =A0 =A0 =A0 struct device *dev;
>> =A0 =A0 =A0 spinlock_t lock;
>> + =A0 =A0 struct mutex mutex;
>> =A0 =A0 =A0 u32 sicr;
>> =A0 =A0 =A0 uint sysclk;
>> =A0 =A0 =A0 int imr;
>> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_ps=
c_ac97.c
>> index 794a247..7eb5499 100644
>> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
>> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
>> @@ -34,13 +34,20 @@ static unsigned short psc_ac97_read(struct snd_ac97 =
*ac97, unsigned short reg)
>> =A0 =A0 =A0 int status;
>> =A0 =A0 =A0 unsigned int val;
>>
>> + =A0 =A0 mutex_lock(&psc_dma->mutex);
>> +
>> =A0 =A0 =A0 /* Wait for command send status zero =3D ready */
>> =A0 =A0 =A0 status =3D spin_event_timeout(!(in_be16(&psc_dma->psc_regs->=
sr_csr.status) &
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_PSC_=
SR_CMDSEND), 100, 0);
>> =A0 =A0 =A0 if (status =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("timeout on ac97 bus (rdy)\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 /* Force clear the data valid bit */
>> + =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
>> +
>
> No mutex involved here. I think this is either a seperate patch or it nee=
ds at
> least to be mentioned in the patch description.
>
>> =A0 =A0 =A0 /* Send the read */
>> =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7=
f) << 24));
>>
>> @@ -50,16 +57,19 @@ static unsigned short psc_ac97_read(struct snd_ac97 =
*ac97, unsigned short reg)
>> =A0 =A0 =A0 if (status =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("timeout on ac97 read (val) %x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc=
_dma->psc_regs->sr_csr.status));
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 /* Get the data */
>> =A0 =A0 =A0 val =3D in_be32(&psc_dma->psc_regs->ac97_data);
>> =A0 =A0 =A0 if (((val >> 24) & 0x7f) !=3D reg) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("reg echo error on ac97 read\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 val =3D (val >> 8) & 0xffff;
>>
>> + =A0 =A0 mutex_unlock(&psc_dma->mutex);
>> =A0 =A0 =A0 return (unsigned short) val;
>> =A0}
>>
>> @@ -68,16 +78,21 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
>> =A0{
>> =A0 =A0 =A0 int status;
>>
>> + =A0 =A0 mutex_lock(&psc_dma->mutex);
>> +
>> =A0 =A0 =A0 /* Wait for command status zero =3D ready */
>> =A0 =A0 =A0 status =3D spin_event_timeout(!(in_be16(&psc_dma->psc_regs->=
sr_csr.status) &
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_PSC_=
SR_CMDSEND), 100, 0);
>> =A0 =A0 =A0 if (status =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("timeout on ac97 bus (write)\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 /* Write data */
>> =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((reg & 0x7f) << 24) | (val =
<< 8));
>> +
>> + out:
>> + =A0 =A0 mutex_unlock(&psc_dma->mutex);
>> =A0}
>>
>> =A0static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkpJrkcACgkQD27XaX1/VRsY/QCgyx8IMANjokbNnrOQlXINRLeW
> lT4AnAy3ES9r3wriGkRN7ivnLA3zyRHb
> =3DRUPr
> -----END PGP SIGNATURE-----
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
