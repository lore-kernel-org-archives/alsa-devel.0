From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001862]: snd_pcm_hw_params_get_rate_max return -1 for "default" pcm
Date: Tue, 21 Feb 2006 07:00:31 +0100
Message-ID: <e32c0dd0a5a1215c66e7432384488b8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7863192
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 07:00:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1862> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1862
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-21-2006 07:00 CET
Last Modified:              02-21-2006 07:00 CET
======================================================================
Summary:                    snd_pcm_hw_params_get_rate_max return -1 for
"default" pcm
Description: 
For hw:0 playback and capture pcm

snd_pcm_hw_params_get_rate_min return 5000
snd_pcm_hw_params_get_rate_max return 48000

For "default" playback and capture pcm

snd_pcm_hw_params_get_rate_min return 4000
snd_pcm_hw_params_get_rate_max return -1


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 07:00 Raymond        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
