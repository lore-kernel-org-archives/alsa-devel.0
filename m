From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001817]: [alsaplayer || jackd] crashs every 5 or 10 minutes
Date: Sat, 4 Feb 2006 00:19:43 +0100
Message-ID: <4c70393b575c998ac822c45272477d8d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44098193
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2006 00:19:44 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1817> 
======================================================================
Reported By:                speedness
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   1817
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo ~x86 gcc 3.4.5
Kernel Version:             2.6.15.2-archck3 (which is ck3 plus reiser4, and
other patches)
======================================================================
Date Submitted:             02-03-2006 23:53 CET
Last Modified:              02-04-2006 00:19 CET
======================================================================
Summary:                    [alsaplayer || jackd] crashs every 5 or 10 minutes
Description: 
If I try alsaplayer -d hw:1 song.mp3 after a fresh reboot (and before
starting X) it will run for a while and then crash.
Feb  3 12:10:43 [kernel] ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc3/work/alsa-
driver-1.0.11rc3/usb/usx2y/usx2yhwdeppcm.c:87: activ frame status -70.
Most prop
ably some hardware problem.
Then I'ld restart it, and it would crash again:
Feb  3 12:20:10 [kernel] ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc3/work/alsa-
driver-1.0.11rc3/usb/usx2y/usbusx2yaudio.c:140: should not be here with
counts=0
And again:
Feb  3 12:30:45 [kernel] ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc3/work/alsa-
driver-1.0.11rc3/usb/usx2y/usbusx2yaudio.c:305: Sequence
Error!(hcd_frame=5770 e
p=8in;wait=5768,frame=5769).
Feb  3 12:30:45 [kernel] Most propably some urb of usb-frame 5768 is still
missi
ng.
Feb  3 12:30:45 [kernel] Cause could be too long delays in usb-hcd
interrupt han
dling.
As this was happening each time less then a minute after run-crons
executed, I stopped the vixie-cron service.  The crashes kept happening,
often at 5 minute intervals:
Feb  3 15:17:26 [kernel] ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc3/work/alsa-driver-1.0.11rc3/usb/usx2y/usx2yhwdeppcm.c:87:
activ frame status -70. Most propably some hardware problem.
Feb  3 15:22:28 [kernel] ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc3/work/alsa-driver-1.0.11rc3/usb/usx2y/usx2yhwdeppcm.c:87:
activ frame status -70. Most propably some hardware problem.
Feb  3 15:27:32 [kernel] ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc3/work/alsa-driver-1.0.11rc3/usb/usx2y/usx2yhwdeppcm.c:87:
activ frame status -70. Most propably some hardware problem.

occationally going 10 minutes.  This is irrespective of how long
alsaplayer or jackd had been running, whether I had restarted it
immediatly or waited 2 or 3 minutes.  
acpid is not running. (otherwise alsa crashes immediately).  
======================================================================

----------------------------------------------------------------------
 rlrevell - 02-04-06 00:09 
----------------------------------------------------------------------
Is your device connected through a hub?  If so does it help if you bypass
it?

----------------------------------------------------------------------
 speedness - 02-04-06 00:19 
----------------------------------------------------------------------
No, I have a Belkin "powered" four-port USB 2.0 hub that's always plugged
into the wall, but I've never been able to get the US428 to work unless
it's
connected directly to the laptop.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 23:53 speedness      New Issue                                    
02-03-06 23:53 speedness      Distribution              => Gentoo ~x86 gcc 3.4.5
02-03-06 23:53 speedness      Kernel Version            => 2.6.15.2-archck3
(which is ck3 plus reiser4, and other patches)
02-04-06 00:09 rlrevell       Note Added: 0007905                          
02-04-06 00:19 speedness      Note Added: 0007906                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
