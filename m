From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pcm timer resolution out of range (rate = 0,
 period_size = 1), Division by zero in kernel
Date: Fri, 23 Dec 2011 10:06:05 +0800
Message-ID: <CAN8cciaqyw=OJ3+2GbM6rqaQ+VLDbfijqgMZTODnQ-PffzDyaQ@mail.gmail.com>
References: <CAODvfaGXziDeSAic-Rg_dBJYWeObgcQhmcy4=vNBL30Mc6GQQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 467BC103F44
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 03:06:06 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so3053291wib.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 18:06:06 -0800 (PST)
In-Reply-To: <CAODvfaGXziDeSAic-Rg_dBJYWeObgcQhmcy4=vNBL30Mc6GQQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/12/22, Appalayagari Sreedhar <sreecha01@gmail.com>:
> Hi,
>
> We are working with 2.6.32 kernel. we are working with ALSA model
> codec driver for conexant chipset. we are using OSS emulation for
> audio playback and recording.
>
> we are not setting the fragmenttaion block using OSS ioctl function
> (SNDCTL_DSP_SETFRAGMENT) , assuming that it will be taken care by the
> ALSA framework based on the sampling rate, bits per sample etc.
>
> we are facing the below issue randomly.
>
> ALSA sound/core/pcm_timer.c:71: -calling VIDIOC_pcm timer resolution
> out of range (rate = 0, period_size = 1)
> Division by zero in kernel.

Do your controller really support 1 frame per period (period_size = 1) ?

What is the value of .period_bytes_min and other parameters in
snd_pcm_hardware and format supported ?

>
> We tried to program the fragmentation block after the sampling rate,
> bits per sample etc are configured. it is working fine for 5 or 6
> iterations for recording and playback.
>
> after that the audio quality is gone bad. the audio is not smooth and
> it is sharp.
>
> could you please help to resolve this problem.
>
