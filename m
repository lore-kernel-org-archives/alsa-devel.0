From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000503]: No sound on SB extigy.
Date: Tue, 30 Aug 2005 12:13:32 +0200
Message-ID: <d06a7ef6d5204bc399978b34dab6f7d5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9272B1DC
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:13:33 +0200 (MEST)
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
Status:                     assigned
Distribution:               SUSE 9.1
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-15-2004 07:38 CEST
Last Modified:              08-30-2005 12:13 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-04 07:38 kpaden         New Issue                                    
09-15-04 07:38 kpaden         Distribution              => SUSE 9.1        
09-15-04 07:38 kpaden         Kernel Version            => 2.6.8           
08-30-05 12:13 jdthood        Note Added: 0005966                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
