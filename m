From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000778]: xbox parameter sets AC97_SCAP_DETECT_BY_VENDOR wrongly
Date: Sun, 2 Jan 2005 18:53:08 +0100
Message-ID: <412433438ad7bd55a7c12260a0d8b0b4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3CCAA292
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2005 18:53:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=778> 
======================================================================
Reported By:                julian
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   778
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-02-2005 18:53 CET
Last Modified:              01-02-2005 18:53 CET
======================================================================
Summary:                    xbox parameter sets AC97_SCAP_DETECT_BY_VENDOR
wrongly
Description: 
the xbox parameter was designed to avoid failed detection of the AC97
codec.
according to the header file AC97_SCAP_DETECT_BY_VENDOR is a flag to ALLOW
detection. Therefore AC97_SCAP_DETECT_BY_VENDOR should be set in scaps if
the xbox 
parameter is false, not true.

The logic in ac97-codec is not consistent either.

To avoid bad AC97 probes, either AC97_SCAP_AUDIO or AC97_SCAP_SKIP_AUDIO
should be set if the xbox parameter is set.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 18:53 julian         New Issue                                    
01-02-05 18:53 julian         File Added: x                                
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
