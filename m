From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000849]: aplay apparently plays mono wav files using OSS, but plays stereo wav files using ALSA
Date: Mon, 31 Jan 2005 19:01:57 +0100
Message-ID: <6bbca5f0f79ae93d156608cdd5ad6ce7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8FE17235
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 19:01:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=849> 
======================================================================
Reported By:                vapspwi
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   849
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-26-2005 20:15 CET
Last Modified:              01-31-2005 19:01 CET
======================================================================
Summary:                    aplay apparently plays mono wav files using OSS, but
plays stereo wav files using ALSA
Description: 
Anytime I play a mono wav file (11, 22, or 44 kHz, 8 or 16 bit) using
aplay, the output is routed to all 26 playback channels of my HDSP 9652
card (observed using hdspmixer).  Based on some web research, it appears
that this is because aplay is using OSS to play the mono wav file.  When I
play a stereo wav file (11, 22, or 44 kHz, 8 or 16 bit) using aplay, the
output is routed only to playback channels 1 and 2 of the HDSP 9652,
apparently because aplay is using ALSA to play the stereo wav file.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-31-05 19:01 
----------------------------------------------------------------------
I guess you meant aplay instead of alsamixer?

Anyway, aplay has nothing to do with OSS.  It can't.  Never ever.

What is the problem?  The behavior to routing the channels depends on the
configuration of "plug" layer.  As default, only first channels are copied
except for mono stream.  You can change this policy in your ~/.asoundrc. 
See the alsa-lib's reference.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-26-05 20:15 vapspwi        New Issue                                    
01-26-05 20:16 vapspwi        Issue Monitored: vapspwi                     
01-26-05 23:46 vapspwi        Issue End Monitor: vapspwi                    
01-31-05 19:01 tiwai          Note Added: 0003455                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
