From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 08:27:53 +0100
Message-ID: <20080412072753.GA2370@localhost>
References: <20080411204610.GA32413@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 87B1E24632
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 09:18:31 +0200 (CEST)
Received: from localhost (78-32-150-178.no-dns-yet.enta.net [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id B30021F66EE
	for <alsa-devel@alsa-project.org>; Sat, 12 Apr 2008 08:18:30 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1Jka9R-0000gi-Qa
	for alsa-devel@alsa-project.org; Sat, 12 Apr 2008 08:27:53 +0100
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 11, 2008 at 10:46:11PM +0200, Lennart Poettering wrote:
> Heya!
> 
> I think I discussed this with both James and Takashi a while back: it
> would be great if we could initialize the sound card mixers in a
> better way by default and not everything set to 0. i.e. for output
> only PCM should be active, at a sensible volume, no bass/treble/3d
> enabled or whatever. All other sources should be muted. And that for
> input the mic jack should be active and nothing else, again. Right now
> people too often have to invest a lot of time to find the right
> controls to toggle/change in the mixer to get something sensible out
> of the speakers.
> 
> Some distributions have started to ship special scripts that try to
> initialize the volumes properly. I know for the Fedora case that this
> tool is very very simple, and just initializes PCM and Master to 70%
> and that's basically it. It would be highly preferable if we had a
> sane tool like this from alsa upstream, which would set the default
> values to 0dB, possibly as an extension to "alsactl".
> 

This would have to be on a case by case basis. On pro audio cards like
RME and some of the ice1712 cards the last thing you want is a mixer
starting with anything unmuted. Professional studio monitor speakers
tend to be very expensive.

> I started to hack something similar to this as part of PulseAudio: if
> PA finds that the PCM slider is not really useful for volume control
> (no attenuation to at least -60dB, too few steps, no seperate controls
> for all channels, ...) it falls back to software volume control,
> however tries to initialize the the slider to 0dB first.
> 
> Now the thing is, this mostly works fine, however on one of my
> devices, a pair of external Logitech USB speakers (ID 046d:0a04
> Logitech, Inc. V20 portable speakers), the dB scale seems to be
> totally bogus. According to ALSA volume ranges from -41 dB to
> +3dB. However, Every setting > -41 dB makes audio awfully
> loud. Really, really fucking loud that is. Disco loud. As loud that
> the speakers start jump around centimeters due to the massive
> vibrations. Setting the volume to 0dB with those speakers really makes
> you fear you are trashing them.
> 
> I somehow expected that the magic "0dB" setting in ALSA would refer to
> some sane default, where the final output would have a sensible
> volume. In this case this is not so. I am thus wondering how ALSA
> actually defines 0dB? Is this a bug in the hardware that should be
> worked around in ALSA? Is this an ALSA bug?

As an audio engineer I'd expect 0dB to mean "no attenuation".
On pro ADCs and DACs, 0dB is usually full scale, ie. clipping.
Not everyone is an audio engineer of course, so expectations
will vary.

John
