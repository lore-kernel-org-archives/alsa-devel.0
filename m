From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000801]: Persistent "max-amp" level on hdspmixer inputs
Date: Mon, 10 Jan 2005 09:20:17 +0100
Message-ID: <a62f599b82527cdc697c022ad1a533b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2F42B268
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 09:20:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=801> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   801
Category:                   hdsp progs
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             01-10-2005 09:20 CET
Last Modified:              01-10-2005 09:20 CET
======================================================================
Summary:                    Persistent "max-amp" level on hdspmixer inputs
Description: 
HDSPmixer shows constant "max-amp" (actually -6db or so) levels at all
times in the first 8 channels.  And when sound is played internally the
middle row meters (playback) show the left channel with maxed-out levels
while the right channel shows nothing.  Peak meters (yellow), however,
appear to work normally.

A screenshot of the mixer while playing a stereo soundfile routed to AN1+2
and Analog (headphones) only with NOTHING connected to the inputs can be
cound here:

http://www.esm.rochester.edu/kevine/hdsp_screenshot.jpg

Note that the outputs (bottom row) show proper levels as do the yellow
peak meters in playback (Out 1+2).  

Signal quality is unaffected.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 09:20 kme            New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
