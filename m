From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001675]: Shuttle SD11G5 (pentium M) CA0106 sound card
Date: Fri, 23 Dec 2005 09:45:07 +0100
Message-ID: <822acf4868772090be1aacb8d5154838@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 01C4417B
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2005 09:45:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1675> 
======================================================================
Reported By:                vava
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1675
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             kernel 2.6.14.4
======================================================================
Date Submitted:             12-23-2005 09:45 CET
Last Modified:              12-23-2005 09:45 CET
======================================================================
Summary:                    Shuttle SD11G5 (pentium M) CA0106 sound card
Description: 
 Recently buy a Shuttle SD11G5 (pentium M)

Sound card reports as :
0000:02:09.0 Multimedia audio controller: Creative Labs SB Audigy LS

0000:02:09.0 0401: 1102:0007
        Subsystem: 1297:3041
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c000 [size=32]
        Capabilities: [dc] Power Management version 2

0 [CA0106 ]: CA0106 - CA0106
                     AudigyLS [Unknown] at 0xc000 irq 19

recompiling my kernel Linux 2.6.14.4

and I got the same behaviour discribe in this bug report.
sound card seem to works fine, xmms and others players looks like
playing sound.

but after moving every switch on alsamixer, still no sound.


************
Trying to find out a solution with Bug 1636
After checking out cvs tree and installing latest version
still no sound




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-23-05 09:45 vava           New Issue                                    
12-23-05 09:45 vava           Distribution              => Debian          
12-23-05 09:45 vava           Kernel Version            => kernel 2.6.14.4 
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
