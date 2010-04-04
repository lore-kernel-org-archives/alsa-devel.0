From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Sun, 4 Apr 2010 08:09:27 +0800
Message-ID: <i2x4f3252891004031709xf4cd516fz739bbe9f93496f3b@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id E1A7C243ED
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 02:09:29 +0200 (CEST)
Received: by pvg12 with SMTP id 12so1199569pvg.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Apr 2010 17:09:28 -0700 (PDT)
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
>  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>
>

if -48dB of alsa volume represent (100-14)% of the volume range of
pulseaudio control

i.e. the volume range of pulseaudio is only -63dB  , why do you use -200dB
?
