From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 01:09:00 +0100
Message-ID: <20080412000859.GA15320@sirena.org.uk>
References: <20080411204610.GA32413@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A43A2245BA
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 02:09:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080411204610.GA32413@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 11, 2008 at 10:46:11PM +0200, Lennart Poettering wrote:

> Some distributions have started to ship special scripts that try to
> initialize the volumes properly. I know for the Fedora case that this
> tool is very very simple, and just initializes PCM and Master to 70%
> and that's basically it. It would be highly preferable if we had a
> sane tool like this from alsa upstream, which would set the default
> values to 0dB, possibly as an extension to "alsactl".

It's not the desktop case but for embedded systems there's a similar need
to manage what general applications see of the audio configuration.  The
plan there was to handle this via something like the scenario API[1].
Obviously, the use case is completely different - usually end users
won't be doing installations and the people doing the configuration will
have written an ASoC machine driver and have a very good idea how the
system is wired up.  You will also much more frequently get dynamic
changes in the set of active controls based on what the system is doing.

As an example of the sort of use case an embedded system might have
consider a smart phone.  When used as a media player the controls will
be configured for audio playback through, say, the headphone jack but if
the user decides to place a call software will need to reroute the audio
so that the telephony subsystem is connected to an appropriate
microphone and speaker.

> I started to hack something similar to this as part of PulseAudio: if
> PA finds that the PCM slider is not really useful for volume control
> (no attenuation to at least -60dB, too few steps, no seperate controls
> for all channels, ...) it falls back to software volume control,
> however tries to initialize the the slider to 0dB first.

The plan with the scenario API was to export a list of the controls that
most software should be looking at in the current scenario.  This sounds
very similar to what you're talking about here - providing a way for the
system management bits of the system to tell normal applications what to
work with.

[1] http://opensource.wolfsonmicro.com/node/14
