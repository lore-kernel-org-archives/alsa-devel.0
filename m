From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000627]: alsactl store doesn't work
Date: Wed, 3 Nov 2004 17:05:55 +0100
Message-ID: <2822058d529a30c512536ebbe63b4144@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B822B2DF
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2004 17:05:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=627> 
======================================================================
Reported By:                deglog
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   627
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-03-2004 17:05 CET
Last Modified:              11-03-2004 17:05 CET
======================================================================
Summary:                    alsactl store doesn't work
Description: 
"alsactl store" outputs "Terminated" after about 30 seconds.

The file asound.state is full of garbage.

Apart from that sounds work OK, although I do see

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

in .xsession_errors.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 17:05 deglog         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
