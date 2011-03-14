From: Craig Bourne <craigbourne@gmail.com>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Mon, 14 Mar 2011 17:31:23 -0400
Message-ID: <AANLkTimGLW1B=aKmw4Y1Znxee5u=F=P-hAWzr3L_OYN8@mail.gmail.com>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
	<4D7E2BB0.7080108@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A961103827
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 22:31:25 +0100 (CET)
Received: by iym7 with SMTP id 7so5667303iym.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 14:31:24 -0700 (PDT)
In-Reply-To: <4D7E2BB0.7080108@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

with respect to your analysis:

It's really not that complicated. You're making this out to be a big
deal, but really all you need to do is google a little and/or ask the PA
community via the mailing list or IRC. You make it sound like we're
trying to kidnap you in the middle of the night or something. Please
don't resort to unnecessary hyperbole.

Well, you did manage to parse my expression pretty well despite its being
too hyperbolic.

I should have been clearer that from my seat it looked like ALSA resources
were being hijacked by pulseaudio. It is that which I would have wished you
to understand rather than,  "we're trying to kidnap you in the middle of the
night or something."  The "middle of the night" thing, though unintended, is
near enough to the facts-- I started flailing about for a solution ca. 3:30
am of the same day.

The conditions that occasioned my feeling that Pulse "hijacks" ALSA
resources  is, e.g., reflected in the error message displayed in this
exchange:

[root@speedy ~]# amixer
ALSA lib pulse.c:229:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

amixer: Mixer attach default error: Connection refused

Please try to see this from my point of view. I am only trying to use an
ALSA utility to see what is wrong with my sound system (a diagnostic
procedure that has been recommended by ALSA for some time). I have no
business with pulseaudio. Yet the default case chooses a null card, based on
what pulseaudio will recognize, rather than my perfectly good RME 9652 audio
card which ALSA has recognized without help or interference from pulseaudio.

A bit more tinkering and research jogs my memory and I recall that I can
give these ALSA utilities a card number argument, and when I do I see the
result that I expected to see as a default (not such a wild assumption since
I have exactly one audio card installed, and ALSA recognizes that card, and
this is after all an ALSA utility that I am trying to use).  Had amixer, by
the way, failed only with the last line of the message, I would not have the
impression that pulseaudio was hijacking resources.

I should perhaps point out that one of the adjustments that I have made in
the past to get ALSA and friends working was to remove all traces of
pulseaudio. Working largely on representations such as you quote in your
response, "*For the last couple years there has been an agreed protocol for
graceful handover of the audio device between PA and JACK.*" , I am
accepting the developers' representations and trying to leave all their good
work in place.  Information that was "public and not hard to find", and that
I could "google",  suggested the radical excision of pulseaudio to get
things working smoothly in the past. Since I took this approach I am not as
well aware of how ALSA and pulseaudio have evolved together as perhaps you
think I ought to be. Mea culpa.

-- 
Comradely,

Craig Bourne

PS the pre and post scripts for jack closely follow advice from "other
people in the PA community ... familiar with jack"  who recently advised on
how to use jack. On your advise though, I have discontinued the use of these
scripts.



On Mon, Mar 14, 2011 at 10:52 AM, Colin Guthrie <gmane@colin.guthr.ie> wrote
(in part):


> > Symptoms alsactl fails carping about pulseaudio, audacity can be started
> on
> > its own but no longer wants to cooperate with JACK and ALSA resulting in
> > horribly distorted sound from something horked together in the background
> as
> > a "favor" to the user, QjackCtl runs, produces messages, and blinks its
> cute
> > little meter display but evidently does this off on the sidelines
> reporting
> > 0 XRUNS even as every little jot and tiddle of computation produces a
> > surprising audio result.
> >
> > Strategy Based on my observation that PULSEAUDIO is evidently being
> allowed
> > to interpose itself between the user (even the superuser) and ALSA, and
> > since this user has been kept largely ignorant of the workings of all
> this
> > and does not know the secret handshake, I will attempt to at least
> minimize
> > the damage to audio and regain some measure of control while not
> attempting
> > to disable the PULSEAUDIO/ALSA cabal.
>
>
> It's really not that complicated. You're making this out to be a big
> deal, but really all you need to do is google a little and/or ask the PA
> community via the mailing list or IRC. You make it sound like we're
> trying to kidnap you in the middle of the night or something. Please
> don't resort to unnecessary hyperbole.
> ...  ...
>
--
>
> Colin Guthrie
> gmane(at)colin.guthr.ie
> http://colin.guthr.ie/
>
> Day Job:
>  Tribalogic Limited [http://www.tribalogic.net/]
> Open Source:
>  Mageia Contributor [http://www.mageia.org/]
>  PulseAudio Hacker [http://www.pulseaudio.org/]
>  Trac Hacker [http://trac.edgewall.org/]
>
