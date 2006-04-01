From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: amixer issues
Date: Sat, 01 Apr 2006 17:07:46 +0100
Message-ID: <1143907666.9228.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 80D53191
	for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2006 18:07:52 +0200 (MEST)
Received: from bossclass ([192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.4/Debian-3) with ESMTP id k31G7lUq022037
	for <alsa-devel@alsa-project.org>; Sat, 1 Apr 2006 17:07:49 +0100
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

I have a working sound card with a working (if basic) PCM mixer:

/proc/asound # cat cards
0 [AICA           ]: snd_card_aica - AICA
                     Yamaha AICA Super Intelligent Sound Processor for
SEGA Dreamcast


but when I try to use amixer nothing seems to work:

/ # amixer -c 0
Invalid card number.
Usage: amixer <options> command


any clues?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
