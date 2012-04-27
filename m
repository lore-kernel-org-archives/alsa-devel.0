From: Jeremy Torres <jeremy.torres@gmail.com>
Subject: Re: ALSA: Updating Sample Rates in
	sound/core/pcm_native.c
Date: Fri, 27 Apr 2012 16:54:40 -0400
Message-ID: <CAEA5kntEX0-8ywo5SPJAO_WwXkf3Y0VMr1jCTG1nDhUAG4q+dw@mail.gmail.com>
References: <CAEA5kntdSeg+DVwLPtsDiM5Rr3e+AUqYug=S6MacobZSpjXJtQ@mail.gmail.com>
	<cad6079b-5d00-49f1-bdec-6e0be5ddce94@email.android.com>
	<843008328967385249@unknownmsgid> <4F902B74.7070603@ladisch.de>
	<CAEA5knsd3NtVCCdufvWm1C6rqLkB2vwarpQVu_TTUw7U5i_JGA@mail.gmail.com>
	<4F904611.4090308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 773C210403D
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 22:54:41 +0200 (CEST)
Received: by yenl1 with SMTP id l1so766905yen.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2012 13:54:40 -0700 (PDT)
In-Reply-To: <4F904611.4090308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Per your request, the following is the source code I've changed in an
attempt to get additional sample rates that my hardware CODEC can
natively support.

The intent is to use the "hardware" device only (no "plug") with NO
rate conversion for the new sample rates (e.g., 144Khz).  Currently,
if I attempt to use 144Khz, the hardware "slave" samples at 192K, and
ALSA rate converts to 144Khz.

>From linux-2.6.31/sound/soc/davinci/davinci-pcm.c:

static struct snd_pcm_hardware davinci_pcm_hardware =3D {
	.info =3D (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
		 SNDRV_PCM_INFO_PAUSE),
	.formats =3D (SNDRV_PCM_FMTBIT_S16_LE),
	.rates =3D (SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_KNOT),
	.rate_min =3D 7200,  // Changed to support new rate
	.rate_max =3D 192000,
	.channels_min =3D 1,//2,
	.channels_max =3D 2,
	.buffer_bytes_max =3D 256 * 1024,
	.period_bytes_min =3D 32,
	.period_bytes_max =3D 8 * 1024,
	.periods_min =3D 16,
	.periods_max =3D 255,
	.fifo_size =3D 0,
};

// ADDED: to support rates not defined in sound/pcm.h
static unsigned int rates[] =3D { 7200, 8000, 9600, 12000, 16000, 44100,
48000, 64000,
                                96000, 128000, 144000, 192000 };
static struct snd_pcm_hw_constraint_list constraints_rates =3D {
          .count =3D ARRAY_SIZE(rates),
          .list =3D rates,
          .mask =3D 0,
  };

static int davinci_pcm_open(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime =3D substream->runtime;
	struct davinci_runtime_data *prtd;
	int ret =3D 0;

	snd_soc_set_runtime_hwparams(substream, &davinci_pcm_hardware);

	// ADDED: to support rates not supported in sound/pcm.h

	ret =3D snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
					  &constraints_rates);
	if (ret < 0)
	  {
	    printk(KERN_ERR "ERROR: unable to set HW constraint list!\n");
	    return -1;
	  }

	prtd =3D kzalloc(sizeof(struct davinci_runtime_data), GFP_KERNEL);
	if (prtd =3D=3D NULL)
		return -ENOMEM;

	spin_lock_init(&prtd->lock);

	runtime->private_data =3D prtd;

	ret =3D davinci_pcm_dma_request(substream);
	if (ret) {
		printk(KERN_ERR "davinci_pcm: Failed to get dma channels\n");
		kfree(prtd);
	}
	=

	return ret;
}



Thanks,
Jeremy

On Thu, Apr 19, 2012 at 1:06 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Jeremy Torres wrote:
>> Thanks for the quick reply! =A0So, I followed Takashi's advice and added
>> the constraint list for the new sample rates and no longer changed
>> pcm.h/pcm_native.c. =A0I can record/play at the new sample rates;
>> however, ALSA is performing rate conversion. =A0For example, to run at
>> 144K, the slave is configured to run 192K, even though my hardware can
>> be configured to support 144K.
>
> This sounds like a bug in the driver.
>
> Unfortunately, my crystal ball is out of order, so you have to actually
> show the source code for me to be able to help you.
>
>
> Regards,
> Clemens
