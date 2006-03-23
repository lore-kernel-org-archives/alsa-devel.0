From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001951]: Microphone doesnt work
Date: Thu, 23 Mar 2006 16:24:59 +0100
Message-ID: <ca8284d00e4f7778bdfd421aaa931a02@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 32C701BF
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 16:25:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1951> 
======================================================================
Reported By:                crissi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1951
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-22-2006 01:31 CET
Last Modified:              03-23-2006 16:24 CET
======================================================================
Summary:                    Microphone doesnt work
Description: 
I cant get any input from mic.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-23-06 16:10 
----------------------------------------------------------------------
Try the patch (second one) in bug #1953.

----------------------------------------------------------------------
 crissi - 03-23-06 16:24 
----------------------------------------------------------------------
root@develop:/usr/src/alsa/alsa-driver# patch -p1 <
/home/crissi/stac92xx-auto-vref2.diff
patching file pci/hda/patch_sigmatel.c
Hunk #1 FAILED at 534.
Hunk #2 FAILED at 587.
Hunk #3 FAILED at 970.
3 out of 3 hunks FAILED -- saving rejects to file
pci/hda/patch_sigmatel.c.rej

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-06 01:31 crissi         New Issue                                    
03-22-06 01:42 rlrevell       Note Added: 0008767                          
03-22-06 15:47 crissi         Note Added: 0008858                          
03-22-06 15:47 crissi         Issue Monitored: crissi                      
03-23-06 16:10 tiwai          Note Added: 0008885                          
03-23-06 16:24 crissi         Note Added: 0008887                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
