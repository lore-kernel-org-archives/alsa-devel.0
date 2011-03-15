From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Tue, 15 Mar 2011 13:19:50 +0800
Message-ID: <AANLkTi=pGuvyCRhpPX7xAWbLW62_GC8w71aEYi=8EYX-@mail.gmail.com>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
	<4D7E2BB0.7080108@colin.guthr.ie>
	<AANLkTimGLW1B=aKmw4Y1Znxee5u=F=P-hAWzr3L_OYN8@mail.gmail.com>
	<4D7EA24B.7080304@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B9931103821
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 06:19:53 +0100 (CET)
Received: by bwz10 with SMTP id 10so226680bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 22:19:52 -0700 (PDT)
In-Reply-To: <4D7EA24B.7080304@colin.guthr.ie>
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

2011/3/15 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Craig Bourne at 14/03/11 21:31 did gyre and gimble:
> > The conditions that occasioned my feeling that Pulse "hijacks" ALSA
> > resources  is, e.g., reflected in the error message displayed in this
> > exchange:
> >
> > [root@speedy ~]# amixer
> > ALSA lib pulse.c:229:(pulse_connect) PulseAudio: Unable to connect:
> > Connection refused
> >
> > amixer: Mixer attach default error: Connection refused
>
> This is simply because alsa's default audio device is routed via PA. You
> can use e.g. amixer -c0 to get direct access ot the hardware, or you can
> do PULSE_LOG=99 amixer to get a more detailed log output of why it's not
> working.
>

This is because pulseaudio overwrite

ctl.!default {
    type pulse
}


>
> > Please try to see this from my point of view. I am only trying to use an
> > ALSA utility to see what is wrong with my sound system (a diagnostic
> > procedure that has been recommended by ALSA for some time). I have no
> > business with pulseaudio. Yet the default case chooses a null card,
> > based on what pulseaudio will recognize, rather than my perfectly good
> > RME 9652 audio card which ALSA has recognized without help or
> > interference from pulseaudio.
>
> PulseAudio is built entirely on top of ALSA (on Linux at least). It is
> one of the only ALSA clients to make use of recent features in ALSA such
> as timer-based scheduling. We do not attempt to replace it or fight it
> in any way. That said there may be times when we offer an overly
> simplistic interface for certain users needs. If this is the case then
> that user is perfectly free to not use PulseAudio. Most sensible distros
> provide a simply tick box to disable the use of PulseAudio. If this is
> not provided by your distro then please complain to them.
>
>
you have to ask Unbuntu or Fedora to add this switch since it is not easy
for ordinary use to disable the use of pulseaudio after using
libcanberra-gtk-play to play the system event sound


> I do not personally have such a card, so I cannot comment specifically
> on that particular card. I'd be surprised if PA does not detect it at
> all however. The dummy card is likely the result of not being able to
> open the device during login due to some other app "hogging" the sound
> device. This is purely guesswork on my part however.
>
> > A bit more tinkering and research jogs my memory and I recall that I can
> > give these ALSA utilities a card number argument, and when I do I see
> > the result that I expected to see as a default (not such a wild
> > assumption since I have exactly one audio card installed, and ALSA
> > recognizes that card, and this is after all an ALSA utility that I am
> > trying to use).  Had amixer, by the way, failed only with the last line
> > of the message, I would not have the impression that pulseaudio was
> > hijacking resources.
>
> It's simply how your system is configured. If you don't want the
> "default" card in alsa to be PulseAudio, don't configure it that way.
> It's not "PulseAudio" that is magically hijacking the resources here,
> but the way your distro has configured things. If it doesn't suit you,
> you should use the tools provided by your distro to change that.
>
> > I should perhaps point out that one of the adjustments that I have made
> > in the past to get ALSA and friends working was to remove all traces of
> > pulseaudio. Working largely on representations such as you quote in your
> > response, "/For the last couple years there has been an agreed protocol
> > for graceful handover of the audio device between PA and JACK./" , I am
> > accepting the developers' representations and trying to leave all their
> > good work in place.  Information that was "public and not hard to find",
> > and that I could "google",  suggested the radical excision of pulseaudio
> > to get things working smoothly in the past. Since I took this approach I
> > am not as well aware of how ALSA and pulseaudio have evolved together as
> > perhaps you think I ought to be. Mea culpa.
>
> I hope I wasn't too harsh in my first email. I didn't mean it that way -
> I guess you just get seasoned to be defensive at times.
>
> Anyway, the "device reservation protocol" is programmed into jack AFAIK.
> When running jack-dbus it should request that PA leaves the devices
> alone and PA will comply. There is even a module for PA called
> jack-dbus-detect which will detect jack running and automatically load
> module-jack-sink to ensure that any PA apps will continue to output but
> via JACK then to ALSA rather than directly to PA's own ALSA sink. This
> isn't in a public release yet (and there are still issues with how this
> works in practice) but the idea is to get a graceful handover. If you
> don't care about PA (or ALSA without specific configuration) apps
> working when JACK is running then this isn't even an issue anyway.
>

I have doubt about this since PA server cannot use RME9652 because the card
does not support 2 channel, so how can PA server release the device through
"device reservation protcol" when PA server cannot even reserve the sound
card
