From: ramkromberg@mail.com
Subject: Can someone verify support for "AzTech Sound Galaxy
 Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846" ?
Date: Mon, 07 May 2007 07:46:04 +0200
Message-ID: <20070507054604.75A781CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 9897C2439D
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2007 07:46:07 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	B5FDD1800200
	for <alsa-devel@alsa-project.org>; Mon,  7 May 2007 05:46:04 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello alsa devs,
I have an old "AzTech Sound Galaxy Nova 16 Extra II-3D - using AZT-2316/R
Chipset - FCC-ID:I38-MMSN846" which I know to work on windows 2000
natively and on other windows using drivers from
http://www.aztech.com/support_download_soundcard01.html, however, I was
unsuccessful in using it in linux ( I tried many dists, but my most
recent failure was with xubuntu 7.04 which have the most recent alsa).
I believe the card is unsupported in alsa and I was hoping someone might
be free to help me with this legacy card ?
Since the card is unsupported I figured this should go the devs.

* Their is this piece of code which might be relevant:
http://www.gelato.unsw.edu.au/lxr/source/sound/isa/azt2320.c

 21     This driver should provide support for most Aztech AZT2320 based
cards.
 22     Several AZT2316 chips are also supported/tested, but autoprobe
doesn't
 23     work: all module option have to be set.

* I'm unsure of what it means to configure manually or how to do so...
I do however have the card working currently with windows 2000 so if its
a question of IRQ and DMA, I can find those with relative ease.

* I obviously tried modprobeing the snd-sgalaxy driver/module, with no
success - possibly related ?

Thanks
Ram Kromberg
ramkromberg@mail.com
