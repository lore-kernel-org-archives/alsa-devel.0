From: Petr Kulhavy <brain@jikos.cz>
Subject: iMX6UL EVK with kernel 4.6
Date: Sat, 30 Apr 2016 13:18:55 +0200
Message-ID: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep27.mx.upcmail.net (fep27.mx.upcmail.net [62.179.121.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 498AA264ED5
 for <alsa-devel@alsa-project.org>; Sat, 30 Apr 2016 13:19:56 +0200 (CEST)
Received: from edge01.upcmail.net ([192.168.13.236]) by viefep27-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20160430111956.OAUZ20729.viefep27-int.chello.at@edge01.upcmail.net>
 for <alsa-devel@alsa-project.org>; Sat, 30 Apr 2016 13:19:56 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: nicoleotsuka@gmail.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to run the latest mainline kernel 4.6 on the iMX6UL EVK. The 
board mostly works and the only problem is audio.
Even though the sound card is detected and the ALSA mixer can be 
controlled there is no MCLK coming out of the SAI2 interface.
All the related peripherals in the DTS (pinmux, SAI2, sound card, codec) 
seem to be set-up correctly, I also tried out various things like 
disabling the ASRC, but without success and I'm slowly running out of ideas.

Could somebody give me a hint please, what is different to the Freescale 
kernel branch where the MCLK works?
By the way, why aren't the Freescale patches merged to the mainline kernel?

Thanks
Petr
