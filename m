From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 01/10] ASoc: mxs: add mxs-pcm driver
Date: Sun, 10 Jul 2011 14:28:26 +0800
Message-ID: <CAA+hA=ROnBkLFbZgvbP_XtmbqALKGBqLbZXquxe-HYOg-xhJqg@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-2-git-send-email-b29396@freescale.com>
	<20110709023358.GB26900@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110709023358.GB26900@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jul 08, 2011 at 11:59:41PM +0800, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>
> *Always* CC maintainers on patches.
Sorry for missed it.
Will add in patch v2.
Thanks a lot for the review.

>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + * Refer to sound/soc/imx/imx-pcm-dma-mx2.c
>
> Why?
Just with the reference of  imx-pcm-dma-mx2.c code.

>> + =A0 =A0 iprtd->buf =3D (unsigned int *)substream->dma_buffer.area;
>
> This cast looks incredibly suspicious...
Will remove the cast.

>> +static int snd_mxs_pcm_prepare(struct snd_pcm_substream *substream)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>
> Remove empty functions.
Will clean up it.

>> +static int snd_mxs_pcm_trigger(struct snd_pcm_substream *substream, int=
 cmd)
>> +{
>> + =A0 =A0 struct snd_pcm_runtime *runtime =3D substream->runtime;
>> + =A0 =A0 struct mxs_pcm_runtime_data *iprtd =3D runtime->private_data;
>> +
>> + =A0 =A0 switch (cmd) {
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_START:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_RESUME:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dmaengine_submit(iprtd->desc);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>
> Why the random blank line?
Sorry for the typo, WIll remove.

>> +static struct platform_driver mxs_pcm_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "mxs-pcm-audio",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>
> Indentation here is very odd...
Will fix in the next patch.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
