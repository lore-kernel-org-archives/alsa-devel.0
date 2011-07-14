From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
Date: Fri, 15 Jul 2011 00:15:24 +0800
Message-ID: <CAA+hA=T7TDrUWnH1ami_1C2btzV_7GVbTU6D-ypSxjaSSFB_bw@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110714123106.GB1904@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F030103A05
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 18:15:25 +0200 (CEST)
Received: by ywa8 with SMTP id 8so170741ywa.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2011 09:15:25 -0700 (PDT)
In-Reply-To: <20110714123106.GB1904@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2011/7/14 Wolfram Sang <w.sang@pengutronix.de>:
>
>> +static struct snd_pcm_hardware snd_mxs_hardware =3D {
>> + =A0 =A0 .info =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D SNDRV_PCM_INFO_M=
MAP |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
INFO_MMAP_VALID |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
INFO_PAUSE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
INFO_RESUME |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
INFO_INTERLEAVED,
>> + =A0 =A0 .formats =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D SNDRV_PCM_FMTBIT_S=
16_LE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
FMTBIT_S20_3LE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
FMTBIT_S24_LE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_=
FMTBIT_S32_LE,
>> + =A0 =A0 .channels_min =A0 =A0 =A0 =A0 =A0 =3D 2,
>> + =A0 =A0 .channels_max =A0 =A0 =A0 =A0 =A0 =3D 2,
>> + =A0 =A0 .period_bytes_min =A0 =A0 =A0 =3D 32,
>> + =A0 =A0 .period_bytes_max =A0 =A0 =A0 =3D 8192,
>> + =A0 =A0 .periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>> + =A0 =A0 .periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 255,
>
> When using madplay (for MP3) instead of aplay, I get
>
> [ 3310.010000] mxs-dma mxs-dma-apbx: maximum number of sg exceeded: 128 >=
 53
> [ 3310.020000] dma dma1chan4: cannot prepare slave dma
>
> So, the mxs-dma limit should be taken into account here.
I also have tried a lot on mp3 playing with madplay, however still have not
met this issue.
Can you tell how can i get the same mp3 as you played?
Maybe it helps me to reproduce this issue.
I will check it tomorrow.
Thanks for the reminder.

>> + =A0 =A0 .buffer_bytes_max =A0 =A0 =A0 =3D 64 * 1024,
>> + =A0 =A0 .fifo_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 32,
>> +
>> +};
