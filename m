From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA driver 1.0.2c: divide by zero oops
Date: Tue, 16 Mar 2004 08:45:00 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403152215.i2FMF0s16137@turbo.physics.adelaide.edu.au>
References: <s5hoeqyie3w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoeqyie3w.wl@alsa2.suse.de> from "Takashi Iwai" at Mar 15, 2004 11:44:35 AM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I have been trying cinelerra 1.1.9 in OSS mode against the OSS emulation
> > driver (snd-pcm-oss) from ALSA driver 1.0.2c. Whenever anything is done to
> > start audio playback (such as playing a video clip) the ALSA driver panics
> > with a divide by zero error.  The decoded oops is found below.
> > 
> > Under native OSS from 2.4.23 cinelerra works fine.  Furthermore, all other
> > OSS applications I've tried against ALSA driver 1.0.2c seem to be fine. 
> > Thus the problem seems to be associated with the way cinelerra does things -
> > something it does is upsetting ALSA but is fine under native OSS.  Of
> > course, even a misbehaving application not running as root should not be
> > able to panic the kernel.
> 
> sure.  what soundcard/soundchip are you using?

It's an Ensoniq AudioPCI card with the ES-1370 chipset.

> also, did you compile with the debug option?

No.  Should I?  I'm guessing you may be after further debugging output
here - if so, what would you like me to do (after compiling with the debug
option)?

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
