From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Tue, 6 Sep 2005 09:54:01 +0930 (CST)
Message-ID: <200509060024.j860O1aa007329@auster.physics.adelaide.edu.au>
References: <s5h4q8zu7i8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q8zu7i8.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 05, 2005 12:35:43 PM
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
  
> > I had the opportunity to sit down over the weekend and work through the
> > issues.  It turns out that this particular laptop has its sound hardware
> > wired up in an odd way.  I was able to get the external plugs working but
> > had to write my own custom ALC260 initialisation verb list to do so.
> > 
> > To cut a long story short, the audio inputs/outputs are connected to the
> > following ALC260 output pins.
> > 
> >  * Internal speaker: ALC260 "headphone" pin
> >  * "Stereo line in jack": ALC260 "mic 1" pin
> >  * "Stereo line out jack": ALC260 "line 1" pin (ie: NOT the "line out" pin)
> >  * CD audio: ALC260 "CD" pin
> > 
> > The reason I got nothing out of the jack is clear: ALSA configures the
> > ALC260 "line out" pin as output and the ALC260 "line 1" as input.  However,
> > in the case of this laptop ALC260 "line 1" is actually the output, with line
> > level input appearing at the ALC260 "mic 1" pin.  I also found I had to
> > explicitly unmute selected input/output widgets since the mixer doesn't
> > control these.
> > 
> > Anyway, with this understanding I was able to get audio in and out of this
> > laptop.  The question now is: where to from here.  I'd like to get the
> > revised initialisation verb list into ALSA but it's not clear how this can
> > be done.  As far as I can tell the ALC260 in this laptop identifies itself
> > using a generic ID; unless there is some other unique ID we can find there
> > won't be any way for ALSA to deduce which initialisation verb list is
> > required.  Perhaps a new module parameter?  Let me know your thoughts.
> 
> Hmm, so you mean it has no unique PCI _subsystem_ ID, too?
> The model is detected with the PCI SSID, not the PCI ID.

The PCI SSID is just the thing listed under "subsystem" in lspci, right?
If so I guess it would be 10cf:1326.  How unique is this?

I guess the correct way of dealing with this is to define a new model in
patches_realtek.c in the same way that the HP variant is currently done, and
use the alternative initialisation verb list if this new model is detected? 
I'll do a patch up along these lines in the next day or so unless you advise
that there is a better way.

For completeness, here's the output of the relevant section of "lspci -v":

  00:1b.0 Class 0403: Intel Corp.: Unknown device 2668 (rev 04)
    Subsystem: Fujitsu Limited.: Unknown device 1326
    Flags: bus master, fast devsel, latency 0, IRQ 17
    Memory at b0000000 (64-bit, non-prefetchable) [size=16k]
    Capabilities: <available only to root>

The first two lines if "lspci -vn" is used are:
  00:1b.0 Class 0403: 8086:2668 (rev 04)
    Subsystem: 10cf:1326

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
