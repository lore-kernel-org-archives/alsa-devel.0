From: Andrew Kuksov <ak@niirt.ru>
Subject: Board with SGTL5000 + DM365. How to get it work?
Date: Tue, 9 Sep 2014 17:42:49 +0400
Message-ID: <CAN8RqkD86yc8cjsvmK=W=k01FVuxVsDmncHgGs85TZQd6AMHqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 3919126512B
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 15:42:54 +0200 (CEST)
Received: by mail-vc0-f182.google.com with SMTP id le20so2879810vcb.41
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 06:42:51 -0700 (PDT)
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

Hi. I have board with SGTl5000 codec connected to DM365 via McBSP
(FSR/CLKR/DX/DR), I2C and CLKOUT1.

DM365-EVM has TVL320AIC3101 connected to DM365 like SGTL5000 on my board.
I try to patch DM365-EVM code but something went wrong.

There is what I do:

1. arch/arm/mach-davinci/board-dm365-evm.c

static struct i2c_board_info i2c_info[] = {{ I2C_BOARD_INFO("sgtl5000",
0x0a), }, };
...
i2c_register_board_info(1, i2c_info, ARRAY_SIZE(i2c_info));
...
prepare_enable(clkout1_clk);
__raw_writel(__raw_readl(davinci_sysmod_base + 0x0d48) | 0x00000002,
davinci_sysmod_base + 0x0d48);
__raw_writel(0,  davinci_sysmod_base + 0x0d04);
__raw_writel(0x8000,  davinci_sysmod_base + 0x0d24); // 24/1=> 24Mhz


2. sound/soc/codecs/sgtl5000.c - removed mclk-related code

3. sound/soc/davinci/davinci-evm.c - all AIC3x data structures changed to
sgtl5000

I know that I need to copy davinci-evm to different file and that work with
it. I patch davinci-evm only for test purposes.

There is a questions:

1. I need a right way to describe clock source for sgtl5000.

2. During kernel initialization I see output:

Registering platform device 'davinci-mcbsp'. Parent at platform
Advanced Linux Sound Architecture Driver Initialized.
sgtl5000-codec 1-000a: sgtl5000 revision 0x11
Registering platform device 'soc-audio.0'. Parent at platform
soc-audio soc-audio.0: ASoC: machine DaVinci DM365 EVM should use
snd_soc_register_card()
soc-audio soc-audio.0: ASoC: CPU DAI davinci-mcbsp not registered
platform soc-audio.0: Driver soc-audio requests probe deferral
soc-audio: probe of soc-audio.0 failed with error -22
ALSA device list:
  No soundcards found.

I don't know what I need to do with "ASoC: machine DaVinci DM365 EVM should
use snd_soc_register_card()" (may be, just ignore?) and "ASoC: CPU DAI
davinci-mcbsp not registered" (looks like a problem).

May be anyone has step-by-step tutorial?

Thanks.
Andrew Kuksov
