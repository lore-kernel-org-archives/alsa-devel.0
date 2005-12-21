From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001666]: Mixer controls "Headphones" and "Master"  misassigned.
Date: Wed, 21 Dec 2005 20:07:27 +0100
Message-ID: <cfc53a69b90dcd84bec270f7fe7ea403@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC2C3179
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 20:07:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1666> 
======================================================================
Reported By:                atiounkine
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1666
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             12-21-2005 20:07 CET
Last Modified:              12-21-2005 20:07 CET
======================================================================
Summary:                    Mixer controls "Headphones" and "Master" 
misassigned.
Description: 
Mixer controls "Headphones" and "Master"  misassigned.

Master is not working and Headphones is working as Master.
I can control volume with Headphones, PCM and DXS1 .
We have tried a kernel options ac97_quirk  from 0 to 4 and  hp_only and
nothing change.

ALSA drivers version is  1.0.10 .
Kernel is 2.6.11 with some Colivas desktop patches.
Chips Via VT8235 and  VIA 1612A
lspci -n: 1106:3059 (rev. 50)

Motherboard Biostar U8668D ver. 7.0 with Pentium 4.

Thank you

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-05 20:07 atiounkine     New Issue                                    
12-21-05 20:07 atiounkine     Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
