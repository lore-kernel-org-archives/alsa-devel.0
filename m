From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000540]: alsa driver will no longer function
Date: Sat, 25 Sep 2004 15:03:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040925130336.2AE072014E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7AF912AB
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 15:03:36 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 39FE225ED0
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 15:03:36 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000540
======================================================================
Reported By:                wolftech
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     540
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core
Kernel Version:             2.6.5-1.3
======================================================================
Date Submitted:             09-25-2004 15:03 CEST
Last Modified:              09-25-2004 15:03 CEST
======================================================================
Summary:                    alsa driver will no longer function
Description: 
Alsa-1.2.10

lsmod 

snd_mixer_oss          13824  0
snd_intel8x0           26280  0
snd_ac97_codec         50436  1 snd_intel8x0
snd_pcm                68872  1 snd_intel8x0
snd_timer              17156  1 snd_pcm
snd_page_alloc          7940  2 snd_intel8x0,snd_pcm
gameport                3328  1 snd_intel8x0
snd_mpu401_uart         4864  1 snd_intel8x0
snd_rawmidi            17184  1 snd_mpu401_uart
snd_seq_device          6152  1 snd_rawmidi
snd                    38372  8
snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6112  1 snd



How reproducible:
in XMMS, select Alsa driver, attempt to play an mp3/cd, get:

Please check that the sound card is configured properly and You have the
correct output plugin selected and no other program is blocking the
soundcard.

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 15:03 wolftech       New Bug                                      
09-25-04 15:03 wolftech       Distribution              => Fedora Core     
09-25-04 15:03 wolftech       Kernel Version            => 2.6.5-1.3       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
