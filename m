From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Prolem with ALC260 soundcard
Date: Fri, 6 Oct 2006 09:23:31 +0930 (CST)
Message-ID: <200610052353.k95NrVaM001664@auster.physics.adelaide.edu.au>
References: <mailman.54439.1160057473.16222.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.54439.1160057473.16222.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Oct 05,
	2006 07:11:13 AM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

> and the cat /proc/asound/card0/codec#0
> :
> # cat /proc/asound/card0/codec#0
> Codec: Realtek ALC260
> Address: 0
> Vendor Id: 0x10ec0260
> Subsystem Id: 0x1025110d
> Revision Id: 0x100400

Thanks for that.  This suggests a PCI subvendor of 0x1025 and a pci_subdevice
ID of 0x110d I think.  If we need to add another model ID to patch_realtek.c
these are the values we would use.  Note that the current "acer" ALC260 model
has a pci_subdevice of 0x008f.

> I can rememebr that i have read in the alsa bugtrack that i am not the
> only one with an ALC260 chip who helped that alc883 patch. I olso remember
> that i have sound since the 1.0.13rc2 or rc3 release (i have installed
> extra the suse 10.2 alpha 4 to try the driver). In release 1.0.13rc1 came
> that ALC883 patch.

I can't comment since I missed that discussion.  I find it most odd that
patches to fix the ALC883 would affect people using ALC260.  While the two
chips share code, their setup is quite separate.  Anyway, if it's changed
things so be it - it's a good thing. <shrug>

> I do not know how i could add compile-options when i compile something. I
> use gentoo and work with portage. Could you put the different things into
> model=acer in the new RC releases?

This would delay the investigation of the problem.  If it comes to this
I'll try to work out a way around this.

> The Acer have an headphone and an mic jack. There is no otehr jack.

Ok, thanks for the confirmation.

> I have tested again the mic jack. The sound that comes out there is louder
> and have no bass.

The lack of bass could be due to how the ALC260 is electronically connected
to the chip.  Depending on the blocking capacitors in place and the nature
of what you're driving you could experience a lack of bass from this jack.

> I remember the sound that comes out of the speaker when i had windows
> installed (i have no windows on it now). It had olso no bass.

That's probably more because the speaker is so tiny that it can't physically
reproduce anything below 400 Hz (if that).

> The mic that is been build into the notebook is working. I can hear that,
> when i turn in alsamixer the mic to maximum and unmute it. When i go with
> my finger over the mic, i can hear that through the headphone and the mic
> jack. That mic only work when i set "mic jack" = "Mic 50pc" or "Mic 80pc".

That makes sense.  These two settings activate bias voltages which are needed
by certain types of microphone elements.  The internal mic is almost always
one which needs at least some bias voltage so that's why it only works
when one of these two settings are selected.

> Hey, in the time i write the text here i found out why i had sound out of
> the mic jack. The "Line Jac" was on "Line out". When i turn that into
> "Line in,Mic 50pc or Mic 80pc" i can not hear anything more coming out of
> the mic jack. When it is set to line out or headphone i can hear the music
> that i have started with amaroK(internet radio stream).

Excellent.  It therefore seems that your Acer is more or less working with
the exception of the internal speaker:

 - the "mic" control deals with the internal microphone.
 - the "Line in" control relates to the mic jack on the side of the laptop.
 - sound is heard from the headphone jack.
 - the internal speaker currently does not work.

Is this a fair summary of your situation?

Are you able to edit the ALSA driver source code on your system?  If not
email me privately and we'll work something out for you.  If so, go into
alsa-kernel/pci/hda/patch_realtek.c file and find the definition of
alc260_acer_init_verbs.  Ignoring comments the upper 3 lines are

  {0x01, AC_VERB_SET_GPIO_MASK, 0x01},
  {0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
  {0x01, AC_VERB_SET_GPIO_DATA, 0x01},

This is just a wild guess, but perhaps change these to instead read

  {0x01, AC_VERB_SET_GPIO_MASK, 0x0f},      
  {0x01, AC_VERB_SET_GPIO_DIRECTION, 0x0f},      
  {0x01, AC_VERB_SET_GPIO_DATA, 0x0f},      

Recompile, reinstall and test again with the model=acer setting.  If this
makes sound come from your internal speaker my suspicion about needing an
additional GPIO line enabled on your laptop is correct.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
