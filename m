From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001923]: HDA Intel mixers can only switch IEC958 to capture
Date: Tue, 14 Mar 2006 16:49:41 +0100
Message-ID: <cb91b76d9a6072e4c9264942c88c3156@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F0EE1B9
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 16:49:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1923> 
======================================================================
Reported By:                fcartegnie
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1923
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-14-2006 11:36 CET
Last Modified:              03-14-2006 16:49 CET
======================================================================
Summary:                    HDA Intel mixers can only switch IEC958 to capture
Description: 
There's no Optical-out playback toggle switch on mixers.
(Even if it seems hooked in the HDA-Intel.conf)

Info:
amixer permits toggling the digital out (works).
alsamixer reads only and give only a capture switch too.
aumix switches on only. (can't switch off)
kmix doesn't find/show the playback IEC958 control.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-14-06 16:49 
----------------------------------------------------------------------
If it works with amixer/alsamixer then the problem is a bug in those other
mixers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-06 11:36 fcartegnie     New Issue                                    
03-14-06 16:49 rlrevell       Note Added: 0008487                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
