From: noreply@alsa-project.org
Subject: [ALSA - driver 0000188]: Silent in 2.6.5 (worked fine in 2.6.4).  Retested, verified, reproduced 100%.
Date: Fri, 16 Jul 2004 13:02:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110217.F22672600A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 50AAB255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:02:18 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000188
======================================================================
Reported By:                Ulmo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     188
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               I use pure Linux kernels only (patched with drivers for my system (patches unrelated to ALSA, and almost always device-specific); never those from distributions).  My underlying ALSA tools are Gentoo media-sound/alsa-tools-1.0.3, but I do NOT use Gentoo's
Kernel Version:             Linux 2.6.5
======================================================================
Date Submitted:             04-05-2004 20:17 CEST
Last Modified:              07-16-2004 13:02 CEST
======================================================================
Summary:                    Silent in 2.6.5 (worked fine in 2.6.4).  Retested, verified, reproduced 100%.
Description: 
Silent in Linux Kernel 2.6.5.  Worked fine in 2.6.4.

Note:  in both cases using media-sound/alsa-tools-1.0.3 tools.

email also sent to alsa-user:


Return-path: <Ulmo-Usenet@Usenet.Q.Net>
Envelope-to: Ulmo-Usenet@Usenet.Q.Net
Delivery-date: Mon, 05 Apr 2004 11:01:44 -0700
RECEIVED:  FROM a.q.net ([2001:5a8:4:ed0:66::1] helo=localhost)
	BY O.Q.NET WITH esmtp (Exim 4.30 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 (Debian))
	ID 1BAYPo-00017H-D8; Mon, 05 Apr 2004 11:01:44 -0700
Date: Mon, 05 Apr 2004 11:01:44 -0700 (PDT)
Message-Id: <20040405.110144.730561908.ulmo@Q.Net>
To: alsa-user@LISTS.SOURCEFORGE.NET
Cc: Brad Allen <Ulmo-Usenet@Usenet.Q.Net>
Subject: intel8x0 stopped working in kernel 2.6.5
From: Brad Allen <Ulmo-Usenet@Usenet.Q.Net>
X-Mailer: Mew version 3.3 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

ALSA intel8x0 worked fine in kernel 2.6.4, but is always silent in
2.6.5.  After suspecting this, I confirmed by verifying ALSA works in
2.6.4 after another reboot into that, and does not work in 2.6.5 after
another reboot into that.  I discovered this problem with "mplayer",
and did the rest of my testing with "aplay".  I used "alsamixer" to
verify and touch Master and PCM controls; since boot scripts restore
controls automatically, alsamixer was not necessary to initially turn
anything on before tests.

The ALSA bug tracking system wouldn't email me my password, so I am
using user mailing list instead.

Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30
08:19:30 2004 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 49335 usecs
intel8x0: clocking to 48000
ALSA device list:
  https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000: Intel ICH5 at 0xfebff800, irq 17

So, where should I start?  So far:

* dmesg diff:
  -Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05
15:41:49 2004 UTC).
  +Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30
08:19:30 2004 UTC).
   PCI: Setting latency timer of device 0000:00:1f.5 to 64
   AC'97 0 analog subsections not ready
  -intel8x0_measure_ac97_clock: measured 49339 usecs
  +intel8x0_measure_ac97_clock: measured 49333 usecs
   intel8x0: clocking to 48000
   ALSA device list:
     https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000: Intel ICH5 at 0xfebff800, irq 17

* ALSA controls get restored every boot just fine in 2.6.4, and look
  just fine in 2.6.5 from alsamixer; I'm only paying attention to
  Master and PCM.

* No kernel messages during failure.

* /proc/interrupts show IRQ 17 interrupt count (from above kernel
  output) increasing while aplay test running in 2.6.5.

* Bug tracking system doesn't work; I can't log into it to report
problem.

* I diff'd ALSA 1.0.4rc2 ... 1.0.4 alsa-kernel subdirectories, and
  didn't see enough to make me think that upgrade would fix it.  I
  tried applying that patch anyway, but a lot of it was already in
  2.6.5, so I decided it wasn't worth retrying, so I never recompiled
  that.  Why is the version in the kernel different from the version
  in FTP site?

* What debugging command do I give it to identify problem quickly?

I suspect a control difference.  What should I do to test it?  There's
too many controls on this thing to try every control combination.

I couldn't find any messages directly mentioning this problem on ALSA
user or announce mailing lists.

======================================================================

----------------------------------------------------------------------
 Ulmo - 04-05-2004 20:24 CEST 
----------------------------------------------------------------------
Strangely, bug form is different from bug display, so abbreviations
above are out of order from the way it was entered.  When I said
2.6.4 and 2.6.5 above, I was referring to Linux kernel version.

Also, it didn't take my version #.  Version # is, according
to kernel messages:

Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).

Also, it asked for platform, which I entered.  I don't see platform
mentioned in bug display.  Platform is ASUS P4P800 Deluxe.

----------------------------------------------------------------------
 Ulmo - 04-05-2004 20:37 CEST 
----------------------------------------------------------------------
Tried ALSA tools 1.0.4 (in Gentoo media-sound/alsa-tools-1.0.4):

/etc/init.d/alsasound stop then start (it restores controls);
aplay test:  did not work
alsamixer: mute & unmute, volume down & up, for both Master & PCM;
aplay test:  did not work.

----------------------------------------------------------------------
 pkar - 04-06-2004 23:41 CEST 
----------------------------------------------------------------------
I also have the same problem on my Dell 8500 Inspiron. Note that the OSS
module of the very same kernel works fine. I also noticed that the sound
from the headphones works fine, only the buildin speakers are muted.

----------------------------------------------------------------------
 perex - 04-07-2004 19:58 CEST 
----------------------------------------------------------------------
Could you try remove /etc/asound.state and restart the driver?
Turn on volume then.

If it does not work, we need compare contents of
/proc/asound/card0/codec97#0/ac97#0-0+regs file
from both kernel versions.

----------------------------------------------------------------------
 Ulmo - 04-08-2004 12:40 CEST 
----------------------------------------------------------------------
First, I renamed /etc/asound.state for the next reboot.

Then, I tried to cat /proc/asound/card0/codec97#0/ac97#0-0+regs but
that process hung, and every other terminal I tried to open or
use after that hung, and the keyboard stopped working (no LEDs, etc.),
so I had to reboot.  I was in Linux kernel 2.6.4, but upon reboot
automatically got 2.6.5 which is what I wanted.

I then went to alsamixer, turned up Master & PCM, unmuted them,
and then tested aplay with a test file.  For the first time in 2.6.5,
it worked.  Then, I tested mplayer with alsa driver output, and that also
worked.

Release notes should mention to upgrade (or remove) that file for
affected
drivers.  This definitely seemed to fix the problem for me.

edited on: 04-08-04 12:40

----------------------------------------------------------------------
 pkar - 04-08-2004 15:59 CEST 
----------------------------------------------------------------------
I removed asound.state without luck. I also tried 2.6.4 kernel and ooops
sound did'nt work also, but after a reboot worked again. In every case OSS
is working OK and also headphones are OK, only buildin speakers (witch
means MasterVolume) have the problem. The problem is that I cannot
consistently reproduse the bug and  I don't know if the problem has to do
with the alsamixer coming with Debian/Sarge. This time both speakers and
headphones are working OK but half an hour earlier speakers where not. In
any case I can live with this problem until next kernel release and then I
look at the problem again.
Thanks
P.S. I include two instances of the file (both from 2.6.5 kernel)
 
This one is now (Everything works)

----------------------------------------------------------------------
 pkar - 04-08-2004 16:05 CEST 
----------------------------------------------------------------------
Sorry I was not familiar with the file uploading mechanism. Anyway both
files ac97*working and ac97*speakers_muted are from the same karnel 2.6.5
but one time sound is OK and the other not. Hope this helps

----------------------------------------------------------------------
 tiwai - 04-13-2004 19:47 CEST 
----------------------------------------------------------------------
the problem of Dell laptop is irrelevant to this thread.
so i close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-05-04 20:17 Ulmo           New Bug                                      
04-05-04 20:17 Ulmo           Distribution              => I use pure Linux kernels only (patched with drivers for my system (patches unrelated to ALSA, and almost always device-specific)
04-05-04 20:17 Ulmo           Kernel Version            => Linux 2.6.5     
04-05-04 20:24 Ulmo           Bugnote Added: 0000754                       
04-05-04 20:28 Ulmo           Bug Monitored: Ulmo                          
04-05-04 20:37 Ulmo           Bugnote Added: 0000755                       
04-06-04 23:41 pkar           Bugnote Added: 0000759                       
04-07-04 19:58 perex          Bugnote Added: 0000764                       
04-08-04 12:38 Ulmo           Bugnote Added: 0000766                       
04-08-04 12:40 Ulmo           Bugnote Edited: 0000766                      
04-08-04 15:59 pkar           Bugnote Added: 0000768                       
04-08-04 16:00 pkar           File Added: ac97#0-0+regs_working                    
04-08-04 16:02 pkar           File Added: ac97#0-0+regs_speakers_muted                    
04-08-04 16:05 pkar           Bugnote Added: 0000769                       
04-13-04 19:47 tiwai          Bugnote Added: 0000798                       
04-13-04 19:47 tiwai          Assigned To               => tiwai           
04-13-04 19:47 tiwai          Resolution               open => fixed       
04-13-04 19:47 tiwai          Status                   new => resolved     
07-16-04 13:02 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
