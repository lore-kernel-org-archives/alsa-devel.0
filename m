From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: emufx.c bug/LiveDrive capture is finally working
Date: Mon, 1 Dec 2003 21:51:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S31578AbTLATvA/20031201195101Z+6734@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello. Good news: LiveDrive line-in2 capture is working!
Earlier I could record only via AC97 Capture which apparently
is the wrong way.

As instructed by Peter Zubaj I changed 
  alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
in the following way (with 1.0.0pre3 driver):

"Line LiveDrive Playback Volume" --> "Line2 LiveDrive Playback Volume"
"Line LiveDrive Capture Volume"  --> "Line2 LiveDrive Capture Volume"
"Line LiveDrive Capture Switch"  --> "Line2 LiveDrive Capture Switch"

The change was done in the place where EXTIN_LINE2_L and EXTIN_LINE2_R
are used.

Now the recording is possible with the settings:
  AC97 Capture: 0        // Note this!
  PCM: 100
  Capture: 0 <no rec>
  Mix: <rec>

However, there is now LiveDrive naming problem as the LiveDrive settings
are the following for recording the "line-in2/mic-in2" plug:
  Line LiveDrive: 100 <rec>
  Line LiveDrive Capture: 100
  Line2 LiveDrive: 0              // should be "Capture"
  Line2 LiveDrive 1: 0 <no rec>   // what is that "1"

As one can see "Line" is the "line-in2" plug, and "Line2" is the
"aux-in2" plug as revealed by a quick test.

The above list should look the following:
  Line2/Mic2 LiveDrive: 100 <rec>      // was Line LiveDrive
  Line2/Mic2 LiveDrive Capture: 100    // was Line LiveDrive Capture
  Aux2 LiveDrive: 0 <no rec>           // was Line2 LiveDrive 1
  Aux2 LiveDrive Capture: 0            // was Line2 LiveDrive

I would like to provide a patch, but I don't know why "Capture" was
dropped and "1" was added in above. In any case, one may fix the code
by noting that EXTIN_LINE1 is "Line2/Mic2" and EXTIN_LINE2 is "Aux2".

 -*-

Wow! It made sense to post about the problem until somebody noticed
what was wrong. I waited for this nearly 1.5 years!

Now we should look at why LiveDrive "midi-in" does not work.
It looks like there is no driver for it. There seem to be only
a driver for the midi at the rear panel.

Regards,
Juhana


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
