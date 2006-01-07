From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001724]: simple PCM helper function
Date: Sat, 7 Jan 2006 05:10:56 +0100
Message-ID: <d7651333ef8ea233e99b1ae8d9ebc60e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C818013A
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 05:10:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1724
Category:                   0_general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              01-07-2006 05:10 CET
======================================================================
Summary:                    simple PCM helper function
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
