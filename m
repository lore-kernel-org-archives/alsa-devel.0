From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] New snd-audigyls driver available.
Date: Thu, 02 Dec 2004 22:42:15 +0000
Message-ID: <41AF9A47.3060706@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A27F916D
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2004 23:42:16 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1CZzeS-0001jO-00
	for alsa-devel@alsa-project.org; Thu, 02 Dec 2004 22:42:16 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have updated the snd-audigyls driver.
It now consists of several .c files because the old audigyls.c was 
getting too big.

Please download from
http://www.alsa-project.org/~james/alsa-driver/audigyls.0.0.20.tar.bz2

untar that into ./alsa-driver/pci/emu10k1

This driver now supports some features of the SB Live 24bit.
It has Analog sound output working.
No mic/line has been tested.
spdif out has been tested, and it fails to work at the moment.

I would hope that this driver could be integrated into the alsa cvs, and 
the current audigyls.c file removed.

Signoff: James Courtier-Dutton <James@superbug.co.uk>
Reason: Adds support for SB Live 24bit.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
