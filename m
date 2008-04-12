From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 12:15:18 +0100
Message-ID: <480099C6.3040708@superbug.co.uk>
References: <20080411204610.GA32413@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EE6024433
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 13:15:20 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[127.0.0.1])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.67)
	id 1JkdhX-0002FK-7E
	for alsa-devel@alsa-project.org; Sat, 12 Apr 2008 11:15:19 +0000
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

Lennart Poettering wrote:
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
>
> Lennart
>
>   
The 0dB is a gain value.
So 0dB means that the input to the mixer element exactly equals the 
output from the mixer element.
So 0dB ensures no distortion will occur.
It is fine to set the 0dB for all output mixer controls except one.
The problem comes with the "Master" control, where 0dB generally means 
the maximum possible volume.
The correct setting of this is therefore very dependent on the type of 
amplification that is being done after the sound card master output.
Everyone's setup will vary. But, on my system a value between -40dB and 
-30dB seems about ok.
The user will hear sound, but it will not be too loud.

I suppose we will need to canvas people on the best value to use.

Your report about anything over -41dB is way too loud does present a 
problem. Obviously, the controls for some sound cards are still 
calibrated wrong. Unfortunately, the calibration of USB sound cards is 
not left to ALSA, but in fact the sound card manufacturer sets up the 
calibration tables for us, so for your Logitech speakers, ALSA would 
have to add a specific quirk.

Finally, does anyone else think -40dB for the Master, and 0dB for all 
other controls is too loud for the default or not?

James
