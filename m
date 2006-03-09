From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001902]: aplay: prints snd_timer_hw_open warning message
Date: Thu, 9 Mar 2006 19:22:21 +0100
Message-ID: <6a4a47be55fd336792c5cd46de15eb3a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 210E3142
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2006 19:22:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1902> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1902
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-09-2006 19:22 CET
Last Modified:              03-09-2006 19:22 CET
======================================================================
Summary:                    aplay: prints snd_timer_hw_open warning message
Description: 
Version: 1.0.10-1

$ aplay audio.wav
ALSA lib timer_hw.c:269:(snd_timer_hw_open) extended read is not
supported (SNDRV_TIMER_IOCTL_TREAD)
Playing WAVE 'audio.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

(It works despite the message.)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-06 19:22 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
