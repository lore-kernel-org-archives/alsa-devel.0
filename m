From: Daniel Pouzzner <douzzer@mega.nu>
Subject: 192khz working for anyone?  and  RME96 patch broke
Date: Tue, 28 Jan 2003 00:27:34 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301280527.h0S5RYn81413@mail.mega.nu>
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

First the RME thing: Torger's post-RC6 patch to rme96.c broke
double-speed capture, so that there is nasty clipping/Nyquist-type
garbage in it.  This is definitely in the patch itself - a CVS kernel
with an RC6 rme96.c works fine.

--

Now for the main attraction.

I'm looking for any way to get 192khz audio working.  If anyone's
gotten it working (under ALSA), I wanna hear how.

I tried Audigy 2 with no success.  opensource.creative.com now has an
Audigy 2 linux driver available, but I don't want to go back to that
card, and I don't want to use a non-ALSA driver.  Consumer cards are
just painful, and Audigy 2 has no 192khz capture hardware, in any
case.

My next try is the Envy24HT-based (ICE1724) ESI Waveterminal 192X.
This is a pro card, much more appropriate for my purposes.  It has
192khz capture and playback.  The CVS ALSA kernel purports to have
basic suppiort for ICE1724 now, but it's not working for me:


  Bus  0, device  14, function  0:
    Multimedia audio controller: PCI device 1412:1724 (IC Ensemble Inc) (rev 1).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0xef40 [0xef5f].
      I/O at 0xec00 [0xec7f].


but then


modprobe snd-ice1712
/lib/modules/2.4.18-xfs/kernel/sound/pci/ice1712/snd-ice1712.o: init_module: No such device


Any ideas?  The vendor and device IDs match the 1724 stuff in
ice1712.c, and not being an ALSA or Linux kernel savant, I don't have
an intuition where to go from here.


I'm perfectly willing to send this card back and try another, if
anyone has gotten 192khz ALSA working on it.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
