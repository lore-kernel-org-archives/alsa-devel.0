From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000503]: No sound on SB extigy.
Date: Wed, 15 Sep 2004 07:38:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040915053813.7CD1248007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D4C702F0
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 07:38:13 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000503
======================================================================
Reported By:                kpaden
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     503
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               SUSE 9.1
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-15-2004 07:38 CEST
Last Modified:              09-15-2004 07:38 CEST
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

Sound Card https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000 = Audigy
Sound Card https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 = Logitech
Sound Card https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 = Extigy

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-15-04 07:38 kpaden         New Bug                                      
09-15-04 07:38 kpaden         Distribution              => SUSE 9.1        
09-15-04 07:38 kpaden         Kernel Version            => 2.6.8           
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
