From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001937]: rate plugin causes invalid free() at second open
Date: Fri, 17 Mar 2006 18:59:47 +0100
Message-ID: <c18da15842c85d03e3fa65dbc1e7fc8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D63A1AC
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 18:59:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1937> 
======================================================================
Reported By:                Cigaes
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1937
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-17-2006 18:59 CET
Last Modified:              03-17-2006 18:59 CET
======================================================================
Summary:                    rate plugin causes invalid free() at second open
Description: 
With the rate plugin, alsa programs (for example aplay) do an invalid
free() when they open the PCM for the second time.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 18:59 Cigaes         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
