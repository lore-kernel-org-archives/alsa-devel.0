From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001943]: No sound since ~2.6.3
Date: Tue, 20 Jun 2006 00:29:26 +0200
Message-ID: <78524052a897c4338b23ab4cf9114361@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00E83153
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 00:29:26 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1943> 
======================================================================
Reported By:                hazelsct
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1943
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian etch
Kernel Version:             2.6.8 through 2.6.15-rc5
======================================================================
Date Submitted:             03-19-2006 16:15 CET
Last Modified:              06-20-2006 00:29 CEST
======================================================================
Summary:                    No sound since ~2.6.3
Description: 
 Greetings,

Running Debian woody/sarge/etch, the last time sound worked on my Fujitsu
Lifebook P2120 was with 2.6.3 (or maybe 2.6.5, but not with 2.6.8 or
anything since).  Esd doesn't work, nor do system beeps, and GNOME volume
control says no volume control elements are found.  I can get ALSA working
with 2.6.8 on all of my other machines, and with 2.6.15 on all that I have
tried.  alsamixer runs and shows levels which I can change, but still no
sound.

An identical ALSA setup worked with sarge under 2.6.3 but not 2.6.8. Tried
running alsaconf again to no avail.  Under 2.6.3, at least when doing
hardware mute and then un-mute (Fn-F3), un-mute beeps; on newer kernels,
there's no beep.

Now under Debian etch (testing), even 2.6.3 no longer works properly:
sounds played through esd simply repeat the first second or so over and
over again. I keep upgrading the kernel (most recently to 2.6.16-rc5 in
experimental) hoping that this time it will finally work, but it hasn't in
that long...

Debian etch has alsa 1.0.10-3, and lsmod shows the following sound modules
installed:
snd_ali5451 20172 1
snd_ac97_codec 82784 1 snd_ali5451
snd_ac97_bus 2048 1 snd_ac97_codec
soundcore 8672 1 snd
snd_page_alloc 9800 1 snd_pcm

lspci shows:
0000:00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)

What other information would help to diagnose/fix this problem?

Thanks,
Adam
======================================================================

----------------------------------------------------------------------
 hazelsct - 06-20-06 00:29 
----------------------------------------------------------------------
Hmm...  Three months with no help on this bug.  Decided to try something.

I believe the sound card is somehow being disabled by the udev start
script.

To demonstrate this, I booted using init=/bin/bash, and tested the
mute/unmute function key on the laptop, which produces an audible beep on
unmute.  It worked just fine after running "/etc/rcS.d/S01glibc.sh start"
and S02mountkernfs.sh.  But when I run S03udev, at the end of the script
something shuts off sound so there's no more audible beep on mute/unmute.

Could it be a bad module interaction?  I listed the modules installed,
rebooted again with init=/bin/bash, and used modprobe to install all of
the modules.  The beep worked fine.  Then again ran "/etc/rcS.d/S03udev
start", and got the following output:

Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...cs: IO port probe 0x100-0x4ff:
excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x388-0x38f
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
done.

As it exited, again the beep on mute/unmute stopped working.

Please let me know what other information you need to help diagnose the
problem.

-Adam Powell

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-06 16:15 hazelsct       New Issue                                    
03-19-06 16:15 hazelsct       Distribution              => Debian etch     
03-19-06 16:15 hazelsct       Kernel Version            => 2.6.8 through
2.6.15-rc5
06-20-06 00:29 hazelsct       Note Added: 0010322                          
======================================================================
