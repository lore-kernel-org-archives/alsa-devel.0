From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Wed, 21 Apr 2010 10:32:24 +0800
Message-ID: <g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
	<hqbv5m$cmf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 96692103811
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 04:32:26 +0200 (CEST)
Received: by pzk40 with SMTP id 40so4656453pzk.23
	for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2010 19:32:24 -0700 (PDT)
In-Reply-To: <hqbv5m$cmf$1@dough.gmane.org>
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

2010/4/17 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 16/04/10 14:48 did gyre and gimble:
> > 2010/4/3 Colin Guthrie <gmane@colin.guthr.ie>
>
> Sorry for the top post but....
>
> Raymond. Your replies are often very disjoint. I see no relevance to my
> message here and why you're replying here is beyond me.
>
> It's totally unclear what point you are making and which parts of this
> message are your comments and which are Lennart's original comments
> that's you've just pasted in.
>
> What are you trying to say?
>
> Col
>

http://pulseaudio.org/ticket/580

>> Basically, if the signal is completely cut off, then the attenuation is
-inf dB.

you have to sum the dB gain of  the SPL of the speaker/headphone when you
want to calculate the dB ( sound pressure and the distance )


>> FWIW, I've got the same/similar h/w with a cutoff at 14% in PA as you
have. I've been meaning to get this fixed for a while, but I'm
incredibly lazy with certain things that don't bother me practically, so
haven't followed it up yet.

>> If any specific debug is needed here, feel free to ask.

Just reply since you still have similar problem , but it seem that you are
unwilling to provide info to debug your case , at least you have to provide
output of alsa-info.sh even when you have the same/similar h/w  ,

do your laptop has the volume knob ?

https://tango.0pointer.de/pipermail/pulseaudio-discuss/2009-May/003898.html

If pulseaudio provide per-application volume control, why the PA community
propose to throw away the volume slider of the application. (i.e. why only
allow pavucontrol to change the per-application volume ?

http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/6521/focus=6524

>> Making the application volume sliders control the device volume isn't
good either, because if an application has a volume slider, the natural
assumption made by users is that the slider controls only that application's
volume.

>> Solution: throw away volume sliders in applications, and promote centralized volume management with volume applets and hardware controls.


I suggest PA should provide the pre-application volume control for the
application too since from the viewpoint of PA when PA have to control all
the volume , it is better not allow application to control alsa master
volume control. but there is no reason to remove the volume sliders in
application

http://git.alsa-project.org/?p=alsa-tools.git;a=blob_plain;f=*hwmixvolume*/README
<http://git.alsa-project.org/?p=alsa-tools.git;a=blob_plain;f=hwmixvolume/README>

The per-application volume control is quite similar to the per voice
volume control of those hardware mixing sound cards ,
although there are some differences

 the per voice volume control of hardware mixing sound card provide digital
gain/atten by the DSP ( not those gain/atten of  DAC )

http://thread.gmane.org/gmane.linux.alsa.devel/24638/focus=24707
