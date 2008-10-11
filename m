From: Zhi Xiong <zx@nchost.net>
Subject: Creative Sound Blaster 5.1vx
Date: Sun, 12 Oct 2008 05:54:35 +0800
Message-ID: <48F1209B.4030808@nchost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from beyond.anonns.com (beyond.anonns.com [202.52.73.128])
	by alsa0.perex.cz (Postfix) with ESMTP id 8452324363
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Oct 2008 23:54:59 +0200 (CEST)
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

Hi,

I own a creative sound blaster 5.1vx card, its model is sb1070, and its
based on CA0106 and an ADC I believed to be a WM8772S(74AAWR2) chip, for
the rest, my weak eyes can't really see it.

I tested the driver on 2.6.20 and 2.6.26, both of them didn't work, so I
believed this model is not yet "supported" by the driver, I added the
lines below into ca0106_chip_details inside ca0106_main.c and the card
works.

     { .serial = 0x10041102,
       .name   = "Sound Blaster 5.1vx [SB1070]",
       .gpio_type = 1,
       .i2c_adc = 1,
       .spi_dac = 1
      } ,

But I don't really know what gpio_type, .i2c_adc, .spi_dac . I do
noticed that setting gpio_type to 1 or 2 will work and not setting it
will have some performance issue.

I wish can write the code more accurately to the specs and hopefully
this few lines of code will get added to the next alsa release for
others to use.

So, can anyone please explain to me what the 3 parameters do? Thanks in
advanced.

-- 
Cheers,
Zhi Xiong
