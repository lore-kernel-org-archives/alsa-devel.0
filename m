From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Wed, 7 Sep 2005 09:32:11 +0930 (CST)
Message-ID: <200509070002.j8702BRw013005@auster.physics.adelaide.edu.au>
References: <s5hd5nmv8m4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5nmv8m4.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 06, 2005 11:38:43 AM
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi Takashi 

> > > > I had the opportunity to sit down over the weekend and work through the
> > > > issues.  It turns out that this particular laptop has its sound hardware
> > > > wired up in an odd way.  I was able to get the external plugs working but
> > > > had to write my own custom ALC260 initialisation verb list to do so.
> > > > 
> > > > To cut a long story short, the audio inputs/outputs are connected to the
> > > > following ALC260 output pins.
> > > > 
> > > >  * Internal speaker: ALC260 "headphone" pin
> > > >  * "Stereo line in jack": ALC260 "mic 1" pin
> > > >  * "Stereo line out jack": ALC260 "line 1" pin (ie: NOT the "line out" pin)
> > > >  * CD audio: ALC260 "CD" pin
> > > > 
> > > > :
> > > Hmm, so you mean it has no unique PCI _subsystem_ ID, too?
> > > The model is detected with the PCI SSID, not the PCI ID.
> > 
> > The PCI SSID is just the thing listed under "subsystem" in lspci, right?
> > If so I guess it would be 10cf:1326.  How unique is this?
> 
> No guarantee, but it should be fairly unique if the manufacturor cares
> enough :)

No worries.  We'll assume it is and see what happens.

> > I'll do a patch up along these lines in the next day or so unless you advise
> > that there is a better way.
> Agreed.  You need just to put your ssid there.  Go ahead!

Not a problem; will do.  While I'm at it I'll probably also define a custom
mixer layout so it's clearer which controls are actually available on this
laptop and what they really do.  For example, "IntSpeaker" instead of
"Headphone", "Mic/LineIn" instead of "Mic", "LineOut" instead of "Line", and
remove some controls (like "mono") which don't seem to be connected to any
physical hardware.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
