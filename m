From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002033]: Capture volume ok with alsa-mixer not OK with aumix
Date: Tue, 18 Apr 2006 14:43:20 +0200
Message-ID: <4da5bde395222ed61100b7006b2dee35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5FE951A9
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 14:43:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2033> 
======================================================================
Reported By:                croiset
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2033
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             04-18-2006 14:43 CEST
Last Modified:              04-18-2006 14:43 CEST
======================================================================
Summary:                    Capture volume ok with alsa-mixer not OK with aumix
Description: 
It's impossible to change the volume with aumix of the line IN for
example.

Result of : cat /proc/asound/card0/oss_mixer
VOLUME "" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "" 0
SPEAKER "" 0
LINE "" 0
MIC "Mic" 0
CD "" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Phone" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 14:43 croiset        New Issue                                    
04-18-06 14:43 croiset        Distribution              => Redhat 7.2      
04-18-06 14:43 croiset        Kernel Version            => 2.4.7-10        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
