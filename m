From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001906]: 1-second overruns reported by arecord, complete system hang with jackd -d alsa
Date: Fri, 10 Mar 2006 20:27:31 +0100
Message-ID: <ffc8e6fa279e742cdcae8e7c7b82120c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF2E7198
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 20:27:31 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1906> 
======================================================================
Reported By:                lyakh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1906
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.15.4, 2.6.0, 2.4.32 (latter with external alsa
drivers)
======================================================================
Date Submitted:             03-10-2006 20:27 CET
Last Modified:              03-10-2006 20:27 CET
======================================================================
Summary:                    1-second overruns reported by arecord, complete
system hang with jackd -d alsa
Description: 
arecord -t wav -f cd -d 600 test.wav
run as root with background load (like "find / -name non_existing_name")
produces messages:
Overrun!!! (at least xxxms long)
where xxx can be hundreds or more than a thousand milliseconds!
jackd -v -d alsa
without clients produced a couple of xrun messages as my scsi driver was
loaded (aic7xxx, but I also had overruns without scsi). Twice it frose the
PC completely . interestingly, first jackd's output (from running in
verbous mode) stop, but I can still switch into another terminal / under
X, but within 1-2 seconds the machine is dead - no keyboard, no network.
arecord overruns reproducible under 2.6.15.4, 2.6.0 with in-kernel drivers
and alsa-1.0.8, 2.4.32 with alsa version 1.0.3 (drivers + libraries +
arecord) Here's my report on alsa-users with the following long thread:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg15111.html
Various scheduler-interactivity tests, suggested by Lee Revell proved that
the system itself is fine. As a last test I tried reproducing the problem
with OSS driver also under 2.6.15.4 kernel - started
jacked -v -d oss
put some load for several minutes, started ardour, tried some recording /
playing - no hang, no xruns.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-06 20:27 lyakh          New Issue                                    
03-10-06 20:27 lyakh          Distribution              => Debian Sarge    
03-10-06 20:27 lyakh          Kernel Version            => 2.6.15.4, 2.6.0,
2.4.32 (latter with external alsa drivers)
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
