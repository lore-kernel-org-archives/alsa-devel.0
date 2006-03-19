From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001527]: amixer fails to set right 'Capture Source' channel
Date: Sun, 19 Mar 2006 22:44:31 +0100
Message-ID: <11fd697b65b3c44b9c73aa4e02f4a023@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A0471DC
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 22:44:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1527> 
======================================================================
Reported By:                tartif
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1527
Category:                   amixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-04-2005 16:11 CET
Last Modified:              03-19-2006 22:44 CET
======================================================================
Summary:                    amixer fails to set right 'Capture Source' channel
Description: 
I use the ice1724 driver (Prodigy 7.1 card), ALSA 1.0.10_rc2 (also happens
with 1.0.9).

amixer fails to set the 'capture source' for the right channel (left is
OK). Left channel is set to that requested, right channel always set to
0.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001824 Always mixed into one channel when reco...
======================================================================

----------------------------------------------------------------------
 ungod - 03-19-06 22:44 
----------------------------------------------------------------------
I have just moved to x86-64 and found myself with the same problem. It is
the aureon driver which does the job wrong. Instead of setting
ucontrol->value.integer.value[0], it should be setting
ucontrol->value.enumerated.item[0]. The ucontrol->value structure is in
fact a union so the integer structure overlaps the enumerated structure,
but while the integer structure have "long" values, the enumerated
structure have "unsigned int". On a 32-bit machine, both "long" and
"unsigned int" is 32-bit, but on a 64-bit machine "long" is 32-bit while
"unsigned int" is 64-bit, hence the reason why only x86-64 is affected.

I'll attach a patch which corrects the flaw.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-04-05 16:11 tartif         New Issue                                    
02-11-06 03:49 ikari_01       Issue Monitored: ikari_01                    
02-18-06 01:32 rlrevell       Relationship added       has duplicate 0001824
03-19-06 22:44 ungod          Note Added: 0008698                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
