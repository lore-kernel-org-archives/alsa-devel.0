From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001333]: NO CARRIER
Date: Sun, 14 Aug 2005 01:14:09 +0200
Message-ID: <c817f8425937ed3e3c422a4bd126bf1b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35EFC14B
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2005 01:14:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1333> 
======================================================================
Reported By:                Chermisi
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1333
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.12.4
======================================================================
Date Submitted:             08-13-2005 22:47 CEST
Last Modified:              08-14-2005 01:14 CEST
======================================================================
Summary:                    NO CARRIER
Description: 
I don't have carrier on modem after loading module snd-atiixp-modem and
after loading slmodemd script.
I have a ATI Modem (1002:4378) 
The output of 
/usr/sbin/slmodemd --alsa --country=ITALY hw:1
is
SmartLink Soft Modem: version 2.9.9 Aug  9 2005 04:23:29
symbolic link `/dev/ttySL0' -> `/dev/pts/2' created.
modem `hw:0,0' created. TTY is `/dev/pts/2'
Use `/dev/ttySL0' as modem device, Ctrl+C for termination.
error: cannot set channels for playback: Invalid argument

======================================================================

----------------------------------------------------------------------
 sashak - 08-14-05 01:14 
----------------------------------------------------------------------
You are with buggy slmodem version. Use recent one (probably with '-alsa'
suffix) from http://linmodems.technion.ac.il/packages/smartlink .

Warning about MC'97 converters should not be fatal if you don't have
unsupported Conexant modem codec and is be fixed in recent alsa-driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 22:47 Chermisi       New Issue                                    
08-13-05 22:47 Chermisi       Kernel Version            => 2.6.12.4        
08-14-05 01:14 sashak         Note Added: 0005814                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
