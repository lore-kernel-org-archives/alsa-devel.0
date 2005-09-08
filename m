From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Thu, 8 Sep 2005 10:27:11 +0930 (CST)
Message-ID: <200509080057.j880vBqL029782@auster.physics.adelaide.edu.au>
References: <s5hbr358dy8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr358dy8.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 07, 2005 10:44:15 AM
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

> > > > I'll do a patch up along these lines in the next day or so unless you advise
> > > > that there is a better way.
> > > Agreed.  You need just to put your ssid there.  Go ahead!
> > 
> > Not a problem; will do.  While I'm at it I'll probably also define a custom
> > mixer layout so it's clearer which controls are actually available on this
> > laptop and what they really do.  For example, "IntSpeaker" instead of
> > "Headphone", "Mic/LineIn" instead of "Mic", "LineOut" instead of "Line", and
> > remove some controls (like "mono") which don't seem to be connected to any
> > physical hardware.
> 
> It's fine as long as you use ALSA native apps, but remember that some
> apps require certain known controls.  Also, OSS emulation wouldn't
> work properly.

Note that the above names were abbreviated for brevity: "IntSpeaker" is
really "IntSpeaker Playback Volume", etc.  I should have made that clear.

Are these "known special names" documented anywhere?

OSS emulation appears to be working fine with the names I'm currently using
(although admittedly I haven't tested an OSS mixer).

> BTW, "Line" and "Line Out" are different.  "Line Playback Volume" 
> is the volume of thruback signal from line-in jack to a certain
> output.

Yes, understood.  Sorry, the above paragraph was written from memory and I
probably confused a few things when typing.  The "Mic/LineIn Playback
Volume" corresponds to "Line" - I just figured that having the controls
labelled in a way which related to how the physical jacks were labelled was
a good thing.  Given the troubles you flagged due to the unusual names
I might use "Line" for "Mic/LineIn" and "Headphone" for "LineOut though.

> I guess "LineOut" corresponds to "Headphone", in your case.

"LineOut" is the overall volume of the signal sent to the "Line Out" jack on
the laptop.  Having said that the jack does have sufficient power to drive a
pair of headphones even without the internal amp enabled.  The "headphone"
pin on the ALC260 chip goes to the internal speaker; hense the "IntSpeaker
Playback Volume" designation.

It'd be nice if we could have a mixer control which allowed the user to
switch the LineOut socket between a true LineOut and a "Headphone" output
(that is, a pin with the internal headphone amp turned on).  I don't think
there's infrastructure to allow this, however.  That might have to become
a module parameter (lineout_is_headphone, enable_hp_amp or something).

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
