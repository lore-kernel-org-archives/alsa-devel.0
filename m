Return-Path: <SRS0=iGAb=EV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB5C63697
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 17:11:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FA82231B
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 17:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gNq8B5fM";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0IRlXBDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FA82231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0276517A4;
	Sun, 15 Nov 2020 18:11:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0276517A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605460311;
	bh=10UkZIU1eXfGlQQ7EpZi0NHGj/dLX4A8AuYloIYXAN4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gNq8B5fM4u/5N2h32K+DiTD+V7x1sEa5TOeAC98WVcxYKmtML95XGOpZRaSJzn4ta
	 LOPxOCDRJ3waDDfwsSMwlAmwwm8SxZ1d7jG/dv2P7RcuWyS9GAKDvStkYGW1lOoTez
	 bep2GLYeCxUrwwWC+ULxbUWTHieNS674mR+DIcZs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD5F7F80247;
	Sun, 15 Nov 2020 18:10:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC153F8029B; Sun, 15 Nov 2020 18:10:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3574AF8020B
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2020 18:10:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3574AF8020B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0IRlXBDG"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82B152419B;
 Sun, 15 Nov 2020 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605460205;
 bh=10UkZIU1eXfGlQQ7EpZi0NHGj/dLX4A8AuYloIYXAN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0IRlXBDG0xHkpXiOS2224BF2lLlgIVoxfYKt/M3XkMjasIQkT0eA4vNRSraIrWlvK
 zFNEo9s1kMOPs8G67u2ty4PKOgyVDrcUMp77G49yjwn4cRfkSs1uLnZYh4CrxIAegM
 FwVVXAqn+xbr2rRFHXsooXWynXNSKA8ynddQYaTw=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
 devel@driverdev.osuosl.org, alsa-devel@alsa-project.org
Subject: [RFC 2/3] ARM: sunxi: do not select COMMON_CLK to fix builds
Date: Sun, 15 Nov 2020 18:09:49 +0100
Message-Id: <20201115170950.304460-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201115170950.304460-1-krzk@kernel.org>
References: <20201115170950.304460-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

COMMON_CLK is a user-selectable option with its own dependencies.  The
most important dependency is !HAVE_LEGACY_CLK.  User-selectable drivers
should not select COMMON_CLK because they will create a dependency cycle
and build failures.  For example on MIPS a configuration with COMMON_CLK
(selected by SND_SUN8I_CODEC) and HAVE_LEGACY_CLK (selected by
SOC_RT305X) is possible:

  WARNING: unmet direct dependencies detected for COMMON_CLK
    Depends on [n]: !HAVE_LEGACY_CLK [=y]
    Selected by [y]:
    - SND_SUN8I_CODEC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
      (ARCH_SUNXI || COMPILE_TEST [=y]) && OF [=y] && (MACH_SUN8I || ARM64 && ARCH_SUNXI || COMPILE_TEST [=y])

    /usr/bin/mips-linux-gnu-ld: drivers/clk/clk.o: in function `clk_set_rate':
    (.text+0xaeb4): multiple definition of `clk_set_rate'; arch/mips/ralink/clk.o:(.text+0x88): first defined here

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 sound/soc/sunxi/Kconfig     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index eeadb1a4dcfe..4d9f9b6d329d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_SUNXI
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select PINCTRL
diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 69b9d8515335..ddcaaa98d3cb 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -14,7 +14,7 @@ config SND_SUN8I_CODEC
 	tristate "Allwinner SUN8I audio codec"
 	depends on OF
 	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
-	select COMMON_CLK
+	depends on COMMON_CLK
 	select REGMAP_MMIO
 	help
 	  This option enables the digital part of the internal audio codec for
-- 
2.25.1

