Return-Path: <SRS0=jAxA=GI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17074C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 14:04:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A249522AAB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 14:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A249522AAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D65E1687;
	Tue,  5 Jan 2021 15:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D65E1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609855484;
	bh=uvEVNbhNSyiStc03FfRWrcnIpu5l+t/J6ekgiQ3/xcQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tlRW8WAiV9LckyfvDCY/ORyuL55EWxiRyBJvkJJLzVHag1lcsH/KMwa3jUxoe6e4L
	 wkwQgmv/mziOjI10qPwHci/Slfx35jr2LjgHboVLzA2695K9oGGFfsGXOYK1XzuIXx
	 K+Vla5ldof+C/2UxspE408acwTnTbVP6oTMtU9pw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8288F804CA;
	Tue,  5 Jan 2021 15:03:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4E61F80258; Tue,  5 Jan 2021 15:03:40 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3878FF8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2021 15:03:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3878FF8015B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D2075AE61;
 Tue,  5 Jan 2021 14:03:33 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jakub Kicinski <kuba@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: [PATCH 00/10] Remove support for TX49xx
Date: Tue,  5 Jan 2021 15:02:45 +0100
Message-Id: <20210105140305.141401-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

I couldn't find any buyable product other than reference boards using
TX49xx CPUs. And since nobody showed interest in keeping support for
it, it's time to remove it.

I've split up the removal into seperate parts for different maintainers.
So if the patch fits your needs, please take it via your tree or
give me an ack so I can apply them  the mips-next tree.

Thomas Bogendoerfer (10):
  MIPS: TX49xx: Drop support
  net: tc35815: Drop support for TX49XX boards
  net: 8390: Drop support for TX49XX boards
  spi: txx9: Remove driver
  dma: tx49 removal
  mtd: Remove drivers used by TX49xx
  char: hw_random: Remove tx4939 driver
  rtc: tx4939: Remove driver
  ide: tx4938ide: Remove driver
  ASoC: txx9: Remove driver

 arch/mips/Kbuild.platforms                    |   1 -
 arch/mips/Kconfig                             |  23 -
 arch/mips/Makefile                            |   1 -
 arch/mips/configs/rbtx49xx_defconfig          |  98 ---
 arch/mips/include/asm/cpu-type.h              |   4 -
 arch/mips/include/asm/cpu.h                   |   2 +-
 .../asm/mach-tx49xx/cpu-feature-overrides.h   |  26 -
 arch/mips/include/asm/mach-tx49xx/ioremap.h   |  30 -
 arch/mips/include/asm/mach-tx49xx/kmalloc.h   |   7 -
 .../include/asm/mach-tx49xx/mangle-port.h     |  27 -
 arch/mips/include/asm/mach-tx49xx/spaces.h    |  17 -
 arch/mips/include/asm/mipsregs.h              |   6 -
 arch/mips/include/asm/txx9/boards.h           |  10 -
 arch/mips/include/asm/txx9/generic.h          |   9 -
 arch/mips/include/asm/txx9/rbtx4927.h         |  92 ---
 arch/mips/include/asm/txx9/rbtx4938.h         | 145 ----
 arch/mips/include/asm/txx9/rbtx4939.h         | 142 ----
 arch/mips/include/asm/txx9/tx4927.h           | 273 --------
 arch/mips/include/asm/txx9/tx4927pcic.h       | 203 ------
 arch/mips/include/asm/txx9/tx4938.h           | 312 ---------
 arch/mips/include/asm/txx9/tx4939.h           | 524 ---------------
 arch/mips/include/asm/vermagic.h              |   2 -
 arch/mips/kernel/cpu-probe.c                  |  10 -
 arch/mips/kernel/idle.c                       |   3 -
 arch/mips/mm/c-r4k.c                          |  77 ---
 arch/mips/mm/page.c                           |   1 -
 arch/mips/mm/tlbex.c                          |   1 -
 arch/mips/pci/Makefile                        |   6 -
 arch/mips/pci/fixup-rbtx4927.c                |  73 --
 arch/mips/pci/fixup-rbtx4938.c                |  53 --
 arch/mips/pci/ops-tx4927.c                    | 524 ---------------
 arch/mips/pci/pci-tx4927.c                    |  91 ---
 arch/mips/pci/pci-tx4938.c                    | 142 ----
 arch/mips/pci/pci-tx4939.c                    | 107 ---
 arch/mips/txx9/Kconfig                        |  89 ---
 arch/mips/txx9/Makefile                       |   8 -
 arch/mips/txx9/Platform                       |   3 -
 arch/mips/txx9/generic/7segled.c              | 123 ----
 arch/mips/txx9/generic/Makefile               |   4 -
 arch/mips/txx9/generic/irq_tx4927.c           |  49 --
 arch/mips/txx9/generic/irq_tx4938.c           |  37 --
 arch/mips/txx9/generic/irq_tx4939.c           | 216 ------
 arch/mips/txx9/generic/mem_tx4927.c           |  75 ---
 arch/mips/txx9/generic/setup.c                | 158 +----
 arch/mips/txx9/generic/setup_tx4927.c         | 337 ----------
 arch/mips/txx9/generic/setup_tx4938.c         | 485 --------------
 arch/mips/txx9/generic/setup_tx4939.c         | 568 ----------------
 arch/mips/txx9/rbtx4927/Makefile              |   2 -
 arch/mips/txx9/rbtx4927/irq.c                 | 198 ------
 arch/mips/txx9/rbtx4927/prom.c                |  42 --
 arch/mips/txx9/rbtx4927/setup.c               | 380 -----------
 arch/mips/txx9/rbtx4938/Makefile              |   2 -
 arch/mips/txx9/rbtx4938/irq.c                 | 157 -----
 arch/mips/txx9/rbtx4938/prom.c                |  22 -
 arch/mips/txx9/rbtx4938/setup.c               | 372 -----------
 arch/mips/txx9/rbtx4939/Makefile              |   2 -
 arch/mips/txx9/rbtx4939/irq.c                 |  95 ---
 arch/mips/txx9/rbtx4939/prom.c                |  29 -
 arch/mips/txx9/rbtx4939/setup.c               | 554 ---------------
 drivers/char/hw_random/Kconfig                |  13 -
 drivers/char/hw_random/Makefile               |   1 -
 drivers/char/hw_random/tx4939-rng.c           | 157 -----
 drivers/dma/Kconfig                           |   2 +-
 drivers/dma/txx9dmac.h                        |  10 -
 drivers/ide/Kconfig                           |  10 -
 drivers/ide/Makefile                          |   3 -
 drivers/ide/tx4938ide.c                       | 209 ------
 drivers/ide/tx4939ide.c                       | 628 ------------------
 drivers/mtd/maps/Kconfig                      |   6 -
 drivers/mtd/maps/Makefile                     |   1 -
 drivers/mtd/maps/rbtx4939-flash.c             | 133 ----
 drivers/mtd/nand/raw/Kconfig                  |   7 -
 drivers/mtd/nand/raw/Makefile                 |   1 -
 drivers/mtd/nand/raw/txx9ndfmc.c              | 423 ------------
 drivers/net/ethernet/8390/Kconfig             |   2 +-
 drivers/net/ethernet/8390/ne.c                |   7 +-
 drivers/net/ethernet/toshiba/tc35815.c        |  29 -
 drivers/rtc/Kconfig                           |   7 -
 drivers/rtc/Makefile                          |   1 -
 drivers/rtc/rtc-tx4939.c                      | 303 ---------
 drivers/spi/Kconfig                           |   6 -
 drivers/spi/Makefile                          |   1 -
 drivers/spi/spi-txx9.c                        | 477 -------------
 drivers/watchdog/Kconfig                      |   2 +-
 include/linux/platform_data/txx9/ndfmc.h      |  28 -
 sound/soc/Kconfig                             |   1 -
 sound/soc/Makefile                            |   1 -
 sound/soc/txx9/Kconfig                        |  30 -
 sound/soc/txx9/Makefile                       |  12 -
 sound/soc/txx9/txx9aclc-ac97.c                | 230 -------
 sound/soc/txx9/txx9aclc-generic.c             |  88 ---
 sound/soc/txx9/txx9aclc.c                     | 422 ------------
 sound/soc/txx9/txx9aclc.h                     |  71 --
 93 files changed, 6 insertions(+), 10365 deletions(-)
 delete mode 100644 arch/mips/configs/rbtx49xx_defconfig
 delete mode 100644 arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
 delete mode 100644 arch/mips/include/asm/mach-tx49xx/ioremap.h
 delete mode 100644 arch/mips/include/asm/mach-tx49xx/kmalloc.h
 delete mode 100644 arch/mips/include/asm/mach-tx49xx/mangle-port.h
 delete mode 100644 arch/mips/include/asm/mach-tx49xx/spaces.h
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4927.h
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4938.h
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4939.h
 delete mode 100644 arch/mips/include/asm/txx9/tx4927.h
 delete mode 100644 arch/mips/include/asm/txx9/tx4927pcic.h
 delete mode 100644 arch/mips/include/asm/txx9/tx4938.h
 delete mode 100644 arch/mips/include/asm/txx9/tx4939.h
 delete mode 100644 arch/mips/pci/fixup-rbtx4927.c
 delete mode 100644 arch/mips/pci/fixup-rbtx4938.c
 delete mode 100644 arch/mips/pci/ops-tx4927.c
 delete mode 100644 arch/mips/pci/pci-tx4927.c
 delete mode 100644 arch/mips/pci/pci-tx4938.c
 delete mode 100644 arch/mips/pci/pci-tx4939.c
 delete mode 100644 arch/mips/txx9/generic/7segled.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx4927.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx4938.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx4939.c
 delete mode 100644 arch/mips/txx9/generic/mem_tx4927.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx4927.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx4938.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx4939.c
 delete mode 100644 arch/mips/txx9/rbtx4927/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4927/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4927/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4927/setup.c
 delete mode 100644 arch/mips/txx9/rbtx4938/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4938/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4938/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4938/setup.c
 delete mode 100644 arch/mips/txx9/rbtx4939/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4939/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4939/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4939/setup.c
 delete mode 100644 drivers/char/hw_random/tx4939-rng.c
 delete mode 100644 drivers/ide/tx4938ide.c
 delete mode 100644 drivers/ide/tx4939ide.c
 delete mode 100644 drivers/mtd/maps/rbtx4939-flash.c
 delete mode 100644 drivers/mtd/nand/raw/txx9ndfmc.c
 delete mode 100644 drivers/rtc/rtc-tx4939.c
 delete mode 100644 drivers/spi/spi-txx9.c
 delete mode 100644 include/linux/platform_data/txx9/ndfmc.h
 delete mode 100644 sound/soc/txx9/Kconfig
 delete mode 100644 sound/soc/txx9/Makefile
 delete mode 100644 sound/soc/txx9/txx9aclc-ac97.c
 delete mode 100644 sound/soc/txx9/txx9aclc-generic.c
 delete mode 100644 sound/soc/txx9/txx9aclc.c
 delete mode 100644 sound/soc/txx9/txx9aclc.h

-- 
2.29.2

