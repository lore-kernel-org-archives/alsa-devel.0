From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000503]: No sound on SB extigy.
Date: Thu, 16 Mar 2006 08:35:19 +0100
Message-ID: <4120ab7f31f08fa53668674e471f4759@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39AA8106
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:35:19 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=503> 
======================================================================
Reported By:                kpaden
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   503
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               SUSE 9.1
Kernel Version:             2.6.8
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-15-2004 07:38 CEST
Last Modified:              03-16-2006 08:35 CET
======================================================================
Summary:                    No sound on SB extigy.
Description: 
I have 3 sound devices. 1-SB Audigy-ZS-2, 1-Logitech Microphone, and 1-SB
Extigy. The Audigy, and Logitech work fine. I get no sound from the
Extigy. Yast2 see's all cards.
Alsamixer see's all cards. /proc/asound shows all cards. hwinfo shows all
cards. 

lsmod | grep snd
snd_seq                57536  0
snd_usb_audio          71200  1
snd_emu10k1            89320  0
snd_rawmidi            23332  2 snd_usb_audio,snd_emu10k1
snd_pcm                97480  2 snd_usb_audio,snd_emu10k1
snd_timer              23752  2 snd_seq,snd_pcm
snd_seq_device          7756  3 snd_seq,snd_emu10k1,snd_rawmidi
snd_ac97_codec         71684  1 snd_emu10k1
snd_util_mem            4416  1 snd_emu10k1
snd_hwdep               8840  1 snd_emu10k1
snd                    51528  11
snd_seq,snd_usb_audio,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep
snd_page_alloc         10768  2 snd_emu10k1,snd_pcm

=====================================================
All volumes are at 100%.

XMMS and other players play through Audigy. Will not play though Extigy.

Sound Card #0 = Audigy
Sound Card #1 = Logitech
Sound Card #2 = Extigy

======================================================================

----------------------------------------------------------------------
 jdthood - 08-30-05 12:13 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:35 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-04 07:38 kpaden         New Issue                                    
09-15-04 07:38 kpaden         Distribution              => SUSE 9.1        
09-15-04 07:38 kpaden         Kernel Version            => 2.6.8           
08-30-05 12:13 jdthood        Note Added: 0005966                          
03-16-06 08:35 rlrevell       Status                   assigned => closed  
03-16-06 08:35 rlrevell       Note Added: 0008593                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
