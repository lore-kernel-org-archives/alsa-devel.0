From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000812]: SNDRV_PCM_IOCTL_DELAY failed:
Date: Wed, 12 Jan 2005 19:06:11 +0100
Message-ID: <20050112180611.F1CC8295@alsa.alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F1CC8295
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 19:06:11 +0100 (MET)
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

SNDRV_PCM_IOCTL_DELAY failed: File descriptor in bad state
Message-ID: <02d6466871732d2c2bbe846941b6e403@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=812> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   812
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-12-2005 19:06 CET
Last Modified:              01-12-2005 19:06 CET
======================================================================
Summary:                    SNDRV_PCM_IOCTL_DELAY failed: 
SNDRV_PCM_IOCTL_DELAY failed: File descriptor in bad state
Description: 
This is Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=287583: please see
http://bugs.debian.org/287583
for the full report.

Summary: The user runs xmms with the ALSA output plugin and gets huge
numbers of error messages:

..
ALSA lib pcm_hw.c:490:(snd_pcm_hw_delay) SNDRV_PCM_IOCTL_DELAY failed:
File descriptor in bad state
ALSA lib pcm_hw.c:490:(snd_pcm_hw_delay) SNDRV_PCM_IOCTL_DELAY failed:
File descriptor in bad state
ALSA lib pcm_hw.c:490:(snd_pcm_hw_delay) SNDRV_PCM_IOCTL_DELAY failed:
File descriptor in bad state
..


The problem disappeared when the user reverted to libasound2 1.0.6-5.
Indeed, it seems that the error message in question was only added to
libasound2 in 1.0.7.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 19:06 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
