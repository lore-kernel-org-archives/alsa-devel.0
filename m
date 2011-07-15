From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
Date: Fri, 15 Jul 2011 06:30:51 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CF10E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110714123106.GB1904@pengutronix.de>
	<CAA+hA=T7TDrUWnH1ami_1C2btzV_7GVbTU6D-ypSxjaSSFB_bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 12CF0103A28
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 08:36:18 +0200 (CEST)
In-Reply-To: <CAA+hA=T7TDrUWnH1ami_1C2btzV_7GVbTU6D-ypSxjaSSFB_bw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <dongas86@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86@gmail.com]
> Sent: Friday, July 15, 2011 12:15 AM
> To: Wolfram Sang
> Cc: Dong Aisheng-B29396; alsa-devel@alsa-project.org;
> s.hauer@pengutronix.de; broonie@opensource.wolfsonmicro.com; u.kleine-
> koenig@pengutronix.de; lrg@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
> =

> 2011/7/14 Wolfram Sang <w.sang@pengutronix.de>:
> >
> >> +static struct snd_pcm_hardware snd_mxs_hardware =3D {
> >> + =A0 =A0 .info =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D SNDRV_PCM_INFO=
_MMAP |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_INFO_MMAP_VALID |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_INFO_PAUSE |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_INFO_RESUME |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_INFO_INTERLEAVED,
> >> + =A0 =A0 .formats =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D SNDRV_PCM_FMTBIT=
_S16_LE |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_FMTBIT_S20_3LE |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_FMTBIT_S24_LE |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PC=
M_FMTBIT_S32_LE,
> >> + =A0 =A0 .channels_min =A0 =A0 =A0 =A0 =A0 =3D 2,
> >> + =A0 =A0 .channels_max =A0 =A0 =A0 =A0 =A0 =3D 2,
> >> + =A0 =A0 .period_bytes_min =A0 =A0 =A0 =3D 32,
> >> + =A0 =A0 .period_bytes_max =A0 =A0 =A0 =3D 8192,
> >> + =A0 =A0 .periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> >> + =A0 =A0 .periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 255,
> >
> > When using madplay (for MP3) instead of aplay, I get
> >
> > [ 3310.010000] mxs-dma mxs-dma-apbx: maximum number of sg exceeded:
> > 128 > 53 [ 3310.020000] dma dma1chan4: cannot prepare slave dma
> >
> > So, the mxs-dma limit should be taken into account here.
> I also have tried a lot on mp3 playing with madplay, however still have
> not met this issue.
> Can you tell how can i get the same mp3 as you played?
> Maybe it helps me to reproduce this issue.
> I will check it tomorrow.
> Thanks for the reminder.
> =


Changed to 52 due for periods_max.
        .periods_min            =3D 1,
-       .periods_max            =3D 255,
+       .periods_max            =3D 52,

Thanks.

Regards
Dong Aisheng
