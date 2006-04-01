From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001990]: aplay/arecord cannot play/capture A_LAW
Date: Sat, 1 Apr 2006 04:26:38 +0200
Message-ID: <1b495c8bc9ac11b04d1a4bfbc1bb3775@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8B6B0172
	for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2006 04:26:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1990> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1990
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-01-2006 04:26 CEST
Last Modified:              04-01-2006 04:26 CEST
======================================================================
Summary:                    aplay/arecord cannot play/capture A_LAW
Description: 
aplay/arecord can play MU_LAW and the sound card support MU_LAW and A_LAW

arecord -D hw:0,0 -f MU_LAW -t au -c 1 -r 8000 test.au

aplay -D hw:0,0 test.au


Try to use -t raw but the quality of A_LAW is very bad when compare with
MU_LAW

arecord -D hw:0,0 -f A_LAW -t raw -c 1 -r 8000 test.raw

aplay -D hw:0,0 test.raw


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-06 04:26 Raymond        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
