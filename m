From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: capturing data from the microphone
Date: Wed, 6 Jan 2010 16:46:11 +0800
Message-ID: <4f3252891001060046v798a4d42k5f3e1303323a64e2@mail.gmail.com>
References: <4B4227BC.70705@gmail.com> <4B4359A5.5060207@heig-vd.ch>
	<4f3252891001051707n7e740ea5gcc217595ee354278@mail.gmail.com>
	<4B444292.5070702@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D159244E7
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 09:46:12 +0100 (CET)
Received: by pxi3 with SMTP id 3so11729842pxi.16
	for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2010 00:46:11 -0800 (PST)
In-Reply-To: <4B444292.5070702@heig-vd.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

arecord: pcm_read:1629: read error: Input/output error

This usually mean hardware interrupt did not not occur ( driver bug )


2010/1/6 Marc Garnier <marc.garnier@heig-vd.ch>

> Ok, let me go into details. I work on a custom device platform based on
> an Atmel at91sam9261. I wrote an alsa driver composed of 2 files
> (sound/soc/atmel/myplateform_q2686.c and sound/soc/codecs/q2686.c) and I
> also add this line into arch/arm/mach-at91/board-myplateform.c :
>
> at91_add_device_ssc(AT91SAM9261_ID_SSC0, ATMEL_SSC_TX | ATMEL_SSC_RX);
>
> When I boot my device I can see that :
> Q2686 SoC Audio Codec 0.2
> asoc: Q2686 <-> atmel-ssc0 mapping ok
> ALSA device list:
>  #0: MYPLATFORM (Q2686)
>
> And everything ok with playback :
> # aplay -c 1 tone.wav
>
> But when I want to record a pcm stream I have this error:
> # arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
> arecord: pcm_read:1629: read error: Input/output error
>
> Any more idea?
>
> Raymond Yau wrote:
> > which device are you using ?  ( pulseaudio , dmix or default device
> defined
> > in /usr/share/alsa/cards/*.conf )
> >
> > post output of
> >
> > arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
> >
> > 2010/1/5 Marc Garnier <marc.garnier@heig-vd.ch>
> >
> >
>
