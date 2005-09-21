From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001438]: AC3 playback not working with Terratec Aureon 5.1 USB MK-II
Date: Wed, 21 Sep 2005 21:26:26 +0200
Message-ID: <d11a1090c18c228f236446ecc052110a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C4EF172
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2005 21:26:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1438> 
======================================================================
Reported By:                mitch_f
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1438
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.4.28-gentoo-r9
======================================================================
Date Submitted:             09-21-2005 21:26 CEST
Last Modified:              09-21-2005 21:26 CEST
======================================================================
Summary:                    AC3 playback not working with Terratec Aureon 5.1
USB MK-II
Description: 
If I try to playback a file containing AC3 audio data with mplayer, it
complains with:

alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82
AES2 0x00 AES3 0x02}
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM iec958:{CARD
0 AES0 0x02 AES1 0x82 AES2 0x00 AES3 0x02} definition (id: iec958, value:
cards.pcm.iec958)
alsa-init: playback open error: Invalid argument
Could not open/initialize audio device -> no sound.

2-channel audio works fine (analog and SPDIF) and AC3 playback also worked
on the cmipci-based card I used before.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-05 21:26 mitch_f        New Issue                                    
09-21-05 21:26 mitch_f        Distribution              => Gentoo          
09-21-05 21:26 mitch_f        Kernel Version            => 2.4.28-gentoo-r9
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
