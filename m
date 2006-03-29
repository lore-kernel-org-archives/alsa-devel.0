From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001975]: Volume setting fix
Date: Wed, 29 Mar 2006 11:16:25 +0200
Message-ID: <2fbb5ccd7be72b6c4f67840376aac133@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1E9216B
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 11:16:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1975> 
======================================================================
Reported By:                ISBear
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1975
Category:                   PCI - cs4281
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               LFS 6.1 modified
Kernel Version:             2.6.16
======================================================================
Date Submitted:             03-29-2006 11:16 CEST
Last Modified:              03-29-2006 11:16 CEST
======================================================================
Summary:                    Volume setting fix
Description: 
alsa-kernel/pci/cs4281.c: 1044:
	if (ucontrol->value.integer.value[0] != volL) {
		volL = CS_VOL_MASK - (ucontrol->value.integer.value[0] & CS_VOL_MASK);
		snd_cs4281_pokeBA0(chip, regL, volL);
		change = 1;
	}
-	if (ucontrol->value.integer.value[0] != volL) {
+	if (ucontrol->value.integer.value[1] != volR) {
		volR = CS_VOL_MASK - (ucontrol->value.integer.value[1] & CS_VOL_MASK);
		snd_cs4281_pokeBA0(chip, regR, volR);
		change = 1;
	}

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 11:16 ISBear         New Issue                                    
03-29-06 11:16 ISBear         Distribution              => LFS 6.1 modified
03-29-06 11:16 ISBear         Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
