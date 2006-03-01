From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001778]: Only sound on line-out jack
Date: Wed, 1 Mar 2006 01:24:40 +0100
Message-ID: <f590292bde6020944f5c45c7a74b9a9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 494ED156
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 01:24:40 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001517.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1778> 
======================================================================
Reported By:                pw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1778
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-24-2006 15:24 CET
Last Modified:              03-01-2006 01:24 CET
======================================================================
Summary:                    Only sound on line-out jack
Description: 
I'm using a Acer Extensa 6702-100 notebook (Intel ICH6 chipset / kernel
2.6.15 / alsa-driver 1.0.11-rc2). The notebook has internal stereo
speakers, a built-in microphone and three jacks (line-out, microphone and
headphones).

I've loaded the snd-hda-intel module with every model listed in the
documentation. When using the fujitsu model option I'm getting sound on
the line-out jack. The internal speakers, built-in microphone and
headphone jack don't work. I've not tested the mic jack yet.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
======================================================================

----------------------------------------------------------------------
 blackr2d - 01-25-06 11:51 
----------------------------------------------------------------------
Duplicate of 1572 - mixer controls not picked up correctly for ALC880

----------------------------------------------------------------------
 pw - 02-01-06 12:41 
----------------------------------------------------------------------
AFAIK mine is an ALC260 chipset... however, maybe it's the same issue

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-06 15:24 pw             New Issue                                    
01-24-06 15:26 pw             File Added: codec#0                          
01-24-06 15:27 pw             File Added: codec#1                          
01-25-06 11:51 blackr2d       Note Added: 0007777                          
02-01-06 12:41 pw             Note Added: 0007859                          
03-01-06 01:24 rlrevell       Relationship added       duplicate of 0001517
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
