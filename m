From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001919]: Make can't finished
Date: Mon, 13 Mar 2006 15:27:10 +0100
Message-ID: <45935eeab1435df88cdc9fd75df1ee6a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 20B5418C
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 15:27:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1919> 
======================================================================
Reported By:                jakub_saran
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1919
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.
======================================================================
Date Submitted:             03-13-2006 15:27 CET
Last Modified:              03-13-2006 15:27 CET
======================================================================
Summary:                    Make can't finished
Description: 
First after congigure command shows "Hacking autoconf.h...". Then I type
make and it shows: 
Makefile:25: /home/linux: There is no such file or folder
Makefile:25: drivers/AC: There is no such file or folder
Makefile:25: 97: There is no such file or folder
Makefile:25: Audio: There is no such file or folder
Makefile:25: Drivers/alsa-driver-1.0.10/Rules.make: There is no such file
or folder
make[2]: *** No rules to make object
`Drivers/alsa-driver-1.0.10/Rules.make'.
Stop.
make[2]: Leaving directory `/home/linux drivers/AC 97 Audio
Drivers/alsa-driver-1.0.10/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/linux drivers/AC 97 Audio
Drivers/alsa-driver-1.0.10'
make: *** [include/sndversions.h] Error 2

It is translated from Polish to English so it can be different from
orginal. What shoul I do? I've got ARSROC K7NF2-RAID motherboard with
CMI9761/A audio codec.

regard

Jakub

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-06 15:27 jakub_saran    New Issue                                    
03-13-06 15:27 jakub_saran    Kernel Version            => 2.6.            
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
