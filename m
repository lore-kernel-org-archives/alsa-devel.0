From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000812]: SNDRV_PCM_IOCTL_DELAY failed:
Date: Mon, 14 Feb 2005 19:32:19 +0100
Message-ID: <20050214183219.C474D11D@alsa.alsa-project.org>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C474D11D
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:32:19 +0100 (MET)
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
Message-ID: <cae13c33ad337ad64651f1ce9bf246d8@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


The following issue has been CLOSED
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
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-12-2005 19:06 CET
Last Modified:              02-14-2005 19:32 CET
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

----------------------------------------------------------------------
 jdthood - 01-12-05 19:09 
----------------------------------------------------------------------
See also Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=290034:

    http://bugs.debian.org/290034

----------------------------------------------------------------------
 tiwai - 01-12-05 20:42 
----------------------------------------------------------------------
This is partly a problem of xmms ALSA output plugin.

But, anyway, this messages no longer appears on alsa-lib 1.0.8.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 19:06 jdthood        New Issue                                    
01-12-05 19:09 jdthood        Note Added: 0003176                          
01-12-05 20:42 tiwai          Status                   new => resolved     
01-12-05 20:42 tiwai          Resolution               open => fixed       
01-12-05 20:42 tiwai          Assigned To               => tiwai           
01-12-05 20:42 tiwai          Note Added: 0003177                          
01-12-05 20:42 tiwai          Assigned To              tiwai =>            
02-14-05 19:32 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
