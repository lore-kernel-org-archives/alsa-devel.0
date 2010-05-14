From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 14 May 2010 08:43:02 +0800
Message-ID: <AANLkTiktH0kLxDKL_zyOlxvsl5IaEQ9WP0Gr6LTO3Dye@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<AANLkTil2wLMXsRwNGpeCfduwK-hmtbYyN4tki51m-S0X@mail.gmail.com>
	<AANLkTimBQOoQGFoPZ8T7nRrDKhsylLNiqkeQ-HinIeyV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8102E1038B7
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 02:43:03 +0200 (CEST)
Received: by pxi13 with SMTP id 13so1066955pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 17:43:02 -0700 (PDT)
In-Reply-To: <AANLkTimBQOoQGFoPZ8T7nRrDKhsylLNiqkeQ-HinIeyV@mail.gmail.com>
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

2010/5/12 pl bossart <bossart.nospam@gmail.com>

> > Some care would need to be taken with regards to detecting xruns.
> > I think the alsa code currently uses the interrupt callback to detect
> this.
> > I have seen a Windows 7 machine happily loop the audio buffer
> > uncontrollably, so I assume it has problems detecting xruns as well.
>
> When the PulseAudio timer fires, the use of snd_pcm_avail() will force
> a call to .pointer and will detect underflows. PulseAudio modilfies
> its watermark when underflows occur so that more time is allocated to
> refilling the ring buffer.
> There are probably some cases I didn't plan for, but on paper I don't
> really see a show-stopper here.
>

Refer to your patch "add rewind-safeguard parameter"

http://git.0pointer.de/?p=pulseaudio.git;a=commit;h=4df443bbe682055a41e7c2248877dcc7682a69b8

you mention glitch occur because application cannot rewind appl pointer to
hardware ptr.

In another word, app ptr must be 128/256 bytes ahead of hardware ptr at any
time to prevent glitch occur. this mean that the glitch was due to DMA brust
size since "PulseAudio modilfies its watermark when underflows occur".
