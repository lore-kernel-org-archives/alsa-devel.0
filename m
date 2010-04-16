From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 16 Apr 2010 21:48:35 +0800
Message-ID: <r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6850E24343
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 15:48:37 +0200 (CEST)
Received: by pwj8 with SMTP id 8so1719340pwj.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2010 06:48:36 -0700 (PDT)
In-Reply-To: <hp744t$5b5$1@dough.gmane.org>
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

2010/4/3 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Nicolo' Chieffo at 02/04/10 21:25 did gyre and gimble:
> > I just had a discussion with pulseaudio developers in which they told
> > me that if the speakers don't emit any audio when the ALSA volume is
> > 0%, then the correct gain value should be -inf dB (a value lower than
> > -200 for pulseaudio means mute). Unfortunately my card has -48 dB.
> >
> > They also said that if with -47.25 dB (which is what I get with ALSA
> > volume set to 2%) I can hear audio even if it's very very low, at -48
> > dB I should still be able to hear something (the scale is
> > logarithmic).
> >
> > Their request is to change to -200 the gain reported from my card
> > driver when the ALSA volume is set to 0%.
> > Thanks
>
> FWIW, I've got the same/similar h/w with a cutoff at 14% in PA as you
> have. I've been meaning to get this fixed for a while, but I'm
> incredibly lazy with certain things that don't bother me practically, so
> haven't followed it up yet.
>
> Thanks for getting the ball rolling :)
>
> If any specific debug is needed here, feel free to ask.
>
> Col
>
>
I don't agree *Lennart Poettering say *"ALSA does not define any reference
point for the dB scale it exports in its mixer controls "

For most of the driver with dB scale,  the 0dB point is the reference point
,  the reason is PA developer choose a cubic mapping  "It's now cubic, which
is supposed to be feel more 'natural'."


https://tango.0pointer.de/pipermail/pulseaudio-discuss/2009-May/003898.html

>> Because PA exposes the same volume scale mapping on all hardware.

>> In 0.9.15 we mapped 0% on the volume scale to -90dB and 100% to 0dB,
in between the mapping between those percentages and the dB scale was
linear (i.e. to the effect that we had an overall logarithmic
mapping).

>> This mapping is not particularly well chosen since it gives too much
control over the uninteresting parts below -20dB and too little
control over the 'interesting' parts above -20dB. That's why I modified
the mapping in PA git. It's now cubic, which is supposed to be feel
more 'natural'.

>> So, coming back to how PA maps those volumes to ALSA: alsamixer will expose
the exact discrete volume steps of the sound card and show dB
information just as little help at the side. PA however controls the
volume in dB and if the hw doesn't provide the requested volume step
we go to the next higher and then attenuate by the remaining factor in
software. That way we can provide the same volume range and granularity on all
hardware with the same mapping from the UI to the attenuation
factor. So basically, while tha mapping from those percentages to the
loudness is different in PA and alsamixer, the dB scaling is mostly
the same -- except when it is not...
