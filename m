From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001516]: sound truncated unless I move mouse
Date: Wed, 1 Mar 2006 00:59:17 +0100
Message-ID: <2639d771a1f4fd972758ade38c74ccce@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2E3FD1C0
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:59:17 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1516> 
======================================================================
Reported By:                moobaxx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1516
Category:                   PCI - intel8x0
Reproducibility:            N/A
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               slackware
Kernel Version:             2.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-30-2005 20:14 CET
Last Modified:              03-01-2006 00:59 CET
======================================================================
Summary:                    sound truncated unless I move mouse
Description: 
there's something unusual, becouse when i reproduce a sound, it's sounds
cut off. Today i discovered that moving the mouse while playing, it's
sound perfect. When i stop moving it, the sound starts cut off again. 
As you notice, my english is very poor, so if you need aditional
information, just ask!
tnx.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:20 
----------------------------------------------------------------------
Sounds like an ACPI bug.  Any improvement with later kernel/ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-05 20:14 moobaxx        New Issue                                    
10-30-05 20:14 moobaxx        File Added: sonido.wav                       
10-30-05 20:14 moobaxx        Distribution              => slackware       
10-30-05 20:14 moobaxx        Kernel Version            => 2.4             
11-01-05 15:35 jdthood        Summary                  sounds cut off => sound
truncated unless I move mouse
12-31-05 00:20 rlrevell       Note Added: 0007316                          
03-01-06 00:59 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
