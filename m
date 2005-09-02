From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001333]: NO CARRIER
Date: Sat, 3 Sep 2005 00:05:57 +0200
Message-ID: <9cd86611fcb4f8ef1ba8ab132d5d95bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 12557171
	for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2005 00:05:58 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               
Kernel Version:             2.6.12.4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-13-2005 22:47 CEST
Last Modified:              09-03-2005 00:05 CEST
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

----------------------------------------------------------------------
 sashak - 09-03-05 00:05 
----------------------------------------------------------------------
Hope it is ok now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 22:47 Chermisi       New Issue                                    
08-13-05 22:47 Chermisi       Kernel Version            => 2.6.12.4        
08-14-05 01:14 sashak         Note Added: 0005814                          
09-03-05 00:05 sashak         Status                   assigned => resolved
09-03-05 00:05 sashak         Resolution               open => fixed       
09-03-05 00:05 sashak         Note Added: 0006026                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
