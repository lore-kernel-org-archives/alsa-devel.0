From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001902]: aplay: prints snd_timer_hw_open warning message
Date: Mon, 13 Mar 2006 20:48:14 +0100
Message-ID: <d0496c1ce7fc56868131f38e3d96cae6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2516E1D7
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 20:48:15 +0100 (MET)
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
Last Modified:              03-13-2006 20:48 CET
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

----------------------------------------------------------------------
 tiwai - 03-13-06 20:48 
----------------------------------------------------------------------
It's harmless, just warning that you're using a newer alsa-lib with older
kernel.
Will fix later.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-06 19:22 jdthood        New Issue                                    
03-13-06 20:48 tiwai          Note Added: 0008461                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
