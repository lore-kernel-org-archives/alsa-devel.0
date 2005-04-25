From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001062]: creative mp3+ doesnt work with external usb hub
Date: Mon, 25 Apr 2005 10:45:53 +0200
Message-ID: <a4e759558a45fed1726e34d2221c0bff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3D3901ED
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2005 10:45:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1062> 
======================================================================
Reported By:                TheCoop
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1062
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.12-rc2-mm3
======================================================================
Date Submitted:             04-18-2005 12:04 CEST
Last Modified:              04-25-2005 10:45 CEST
======================================================================
Summary:                    creative mp3+ doesnt work with external usb hub
Description: 
My usb creative mp3+ only works when it is plugged directly into the
computer. When it is plugged into an external usb hub, sound doesnt play
(the timer is stuck at 0:00), the following appears in the command line:
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

and the following appears in dmesg:
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38

Details at http://forums.gentoo.org/viewtopic-t-272854.html
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:45 
----------------------------------------------------------------------
Playing audio data for a USB 1.x device through a 2.0 hub needs special
support from the USB controller driver.  Error 38 means that your kernel
does not implement this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 12:04 TheCoop        New Issue                                    
04-18-05 12:04 TheCoop        Distribution              => Gentoo          
04-18-05 12:04 TheCoop        Kernel Version            => 2.6.12-rc2-mm3  
04-25-05 10:45 Clemens LadischNote Added: 0004570                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
