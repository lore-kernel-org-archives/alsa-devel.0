From: =?ISO-8859-15?Q?Christian_Sch=F6rkhuber?= <schoerkhuber@iem.at>
Subject: ASoC: special SPI format for that5173 driver in daisy
	chain mode
Date: Wed, 10 Oct 2012 17:36:30 +0200
Message-ID: <507595FE.8020204@iem.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.iem.at (inf185.kug.ac.at [193.170.191.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 3645B261710
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 17:36:57 +0200 (CEST)
Received: from asafirewall.kug.ac.at ([193.170.190.246]:21852
 helo=[192.168.171.193])
 by mail.iem.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.72) (envelope-from <schoerkhuber@iem.at>) id 1TLyKi-0000nW-4e
 for alsa-devel@alsa-project.org; Wed, 10 Oct 2012 17:36:28 +0200
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
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm working on an ASoC driver for the THAT5173 microphone preamplifier 
which is controlled via SPI. When operating in daisy chain mode (4 amps) 
the desired format is a bit odd: I need to write four 16 bit spi 
commands (one gain setting for each amp) in a row without raising the 
chipselect line between commands.
That is, I need to write one 64 bit SPI command that is composed of 4 
different values (and 4 register addresses which are all 0).

Usually I use regmap but I don't see how I can construct such a message 
with regmap. How can this be done (with or without regmap)?

Thanks,
Chris
