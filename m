From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 15:35:36 +0200
Message-ID: <20080412133536.GC32491@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id D0D2624348
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 15:35:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <480099C6.3040708@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 12.04.08 12:15, James Courtier-Dutton (James@superbug.co.uk) wrote:

> > I somehow expected that the magic "0dB" setting in ALSA would refer to
> > some sane default, where the final output would have a sensible
> > volume. In this case this is not so. I am thus wondering how ALSA
> > actually defines 0dB? Is this a bug in the hardware that should be
> > worked around in ALSA? Is this an ALSA bug?

> The 0dB is a gain value.
> So 0dB means that the input to the mixer element exactly equals the 
> output from the mixer element.
> So 0dB ensures no distortion will occur.
> It is fine to set the 0dB for all output mixer controls except one.
> The problem comes with the "Master" control, where 0dB generally means 
> the maximum possible volume.

In the case of the USB speakers there is no Master, only PCM. And it
is that PCM volume that is the offender.

My I thus assume that we can say that for all but the last element in
the series 0db means avg input power equals avg output power, and for
the last one 0db means max? That would fit on what you are saying but
also match my usb speakers, not depending on the existance of a
"Master".

> The correct setting of this is therefore very dependent on the type of 
> amplification that is being done after the sound card master output.
> Everyone's setup will vary. But, on my system a value between -40dB and 
> -30dB seems about ok.
> The user will hear sound, but it will not be too loud.
> I suppose we will need to canvas people on the best value to use.

With all hw I tested this scheme actually seems to work fine. (-40dB,
Intel HDA, those Logitech speakers, Terratech Aureon 5.1.)

> Your report about anything over -41dB is way too loud does present a 
> problem. Obviously, the controls for some sound cards are still 
> calibrated wrong. Unfortunately, the calibration of USB sound cards is 
> not left to ALSA, but in fact the sound card manufacturer sets up the 
> calibration tables for us, so for your Logitech speakers, ALSA would 
> have to add a specific quirk.

Actually, it is fine with -40dB, not just -41dB. But then it gets
rapidly too loud.

> Finally, does anyone else think -40dB for the Master, and 0dB for all 
> other controls is too loud for the default or not?

Works fine with my hardware at least ;-)

My scheme in PA will thus now be:

1) Initialize Master to -40dB
2) If there is no master, initialize PCM to -40dB
3) If there is a master, initialize PCM to 0dB

Does that sound reasonable?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
