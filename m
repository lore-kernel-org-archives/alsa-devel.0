From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: unsupported variant of snd_hda_intel
Date: Sat, 2 Oct 2010 13:53:54 +0800
Message-ID: <AANLkTik3nGq22b0t+f3NMn23CK7x5b+hLJpaW9rjhr0Q@mail.gmail.com>
References: <AANLkTinDxaesb-=AZi8sALtw6MkERjMr3WK7Nixkv06P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 630952459E
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 07:53:59 +0200 (CEST)
Received: by eye27 with SMTP id 27so1503053eye.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 22:53:55 -0700 (PDT)
In-Reply-To: <AANLkTinDxaesb-=AZi8sALtw6MkERjMr3WK7Nixkv06P@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/2 Alexandre <alxgomz@gmail.com>

> Hello,
>
> I have an Acer Aspire 4736G laptop.
> The soundcard that is shipped in this laptop is intel-hda based as
> shown (actually it's a realtek):
>
> cat /proc/asound/cards
>  0 [Intel          ]: HDA-Intel - HDA Intel
>                      HDA Intel at 0x9b300000 irq 46
>
> Basic sound output is correct but few feature are missing:
> - internal mic seems to be found but do not works.
> - sound output stop working when trying to send it using HDMI output
> - heads do not work when plugged neither when forcing pulseaudio to use it.
>
> I have an ubuntu 10.10 which is shipped with alsa 1.0.23.
> I have googled around and tried loading the snd-hda-intel with several
> parameters () as found in HD-Audio-Models.txt to no avail.
>
> cat /proc/asound/pcm
> 00-00: ALC888 Analog : ALC888 Analog : playback 1 : capture 1
> 00-01: ALC888 Digital : ALC888 Digital : playback 1
> 00-03: NVIDIA HDMI : NVIDIA HDMI : playback 1
>
> Where can I begin to help implement the support for this sound card? I
> have very skills in developement in general but am ready to try if it
> is not to hard (I supose I can use previous code for similar models)..
> I just need a shepherd.
>
> Thanks
>

according to* *wheat0r in

http://forum.ubuntu.com.cn/viewtopic.php?f=74&t=216956&view=next

His 4736g work with model="acer-aspire-4930g"
