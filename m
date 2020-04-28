Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92414C83004
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:29:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF2E20730
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cIz7bHb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF2E20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79A751685;
	Tue, 28 Apr 2020 23:28:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79A751685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588109380;
	bh=OOdlGVkjGIotzT1LbfhM1Pw1y+tYNLBIHg52ANnvReU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cIz7bHb81hJCJ+ITGHslJQ6tbxwQaq4SJrmvqsGUltLJy2dhuviDw5EyQTVXxHPu8
	 KSPnStNFZ85N8XxCMBaBPWZZLy0sWRQ/DHa4kKWIPzlXGfcHID3Aeoq/jPDYnSQwza
	 aqh1Q2tkTJuJ8L7aSMeUZykomClJBAG50cQcETqw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1414FF801DB;
	Tue, 28 Apr 2020 23:28:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EE72F801F7; Tue, 28 Apr 2020 23:28:44 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFB7BF80136;
 Tue, 28 Apr 2020 23:28:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFB7BF80136
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M3UhO-1jU5ja2dxi-000fbP; Tue, 28 Apr 2020 23:27:56 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: SOF: sort out Kconfig, again
Date: Tue, 28 Apr 2020 23:27:36 +0200
Message-Id: <20200428212752.2901778-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8d7WZ3UBhWpvVPatHjhGkfsTe799EeMmt2kakU1SILlE+Boi8JB
 2TfmLPolDBGYzmbr3Yno8gLoI+2IK035iR0LCwe1FAmFuobAdsepBIkcpYqlYgax5ACVuex
 BGiDnHlwlsqW7vSHLv20SbOdT6TEtexpnidSwU5d4AunnND0maUcQu6+BQ42oXEn9T/bWNe
 0JVj/r7tK7Ux78fglAMYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WvmTsyeNvCQ=:+pPOAQ1B7e8cgF5lZXL9vR
 AV22EdfqUTx2IPCOF5strs645hcHwIhAqY7J7wWwuobCW5hDdl0AngGnX7FJspnZnjegkrt2E
 RmD6/LNADCHxJSUPTqNAKmCZMRs5C5oEsGfLQ4S5+1i3B5jwR83pojGofRG2KonqBp+PQogZ/
 PJ76AC4wMLbAoudpCmN2AhZ56qTajfBaZKm0EPyPuF4BMapfAJ+3fpg+2ThssSqTdS6QhVH3X
 JXWKHebYIyuec84E+TkN/7zMCC4mzRp3S14HC9j/msgVL82IO6kBzDJBPqYcGQaktntpFs1E0
 UREoIKK4vZoyZbMjCuOY/XPm+BL2WakVX7I2vcuiV4zxVmVZWMx867aIodGfIfLUqOAIxl21d
 VzFTMP0BEeJtXhzaLFPYwgPl/PyoLYL7eCNieKKV9A38vtenhz8JzvwSuS2FVYacMXkNEVQEN
 Jdul6s9nst/hq8t7BtXJgFFaU3erH4AZbnj7ZqYckElD5nM4naktKQthw9CFOd2EdQoQP0ZC7
 hF6m/JE4PzxF3YX/pV8bsJrGNzoNSCJb4VUe9CAlPEiebv8tuUwPNrnrmHsw1f3amgWRHm7Y7
 fha9JwYcW2lOjlNSIalKXM1tYG2lpk04lmCKBnivI5JUzyBwXGcCkUl3U1h3WFDWiorQM7mgv
 j53SadC4DntEqIUENeoBK769K10vJLdDz8rtd9t5DXuxSJdx0Uto9LpFm/gKFohRqueOR654x
 tyByEJPuc+7C1bS9fDLIltl45IhTkIe6d+F4/srj7Px7uCwukODTvnxpR4c5bXI8DfbsJBhjC
 NJ8U4aGwH60t84BKXw5NKXImAnQcWYfTIA0izfoNj0lFbO8Ffw=
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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

The imx8 config keeps causing issues:

WARNING: unmet direct dependencies detected for SND_SOC_SOF_IMX8M
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && IMX_DSP [=n]
  Selected by [m]:
  - SND_SOC_SOF_IMX_OF [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && SND_SOC_SOF_IMX8M_SUPPORT [=y]

This is complicated by two drivers having dependencies on both
platform specific drivers and the SND_SOC_SOF_OF framework code,
and using an somewhat obscure method to build them the same way
as the SOC_SOF_OF symbol (built-in or modular).

My solution now ensures that the two drivers can only be enabled
when the dependencies are met:

- When the platform specific drivers are built-in, everything is
  fine, as SOC_SOF_OF is either =y or =m

- When both are loadable modules, it also works, both for Kconfig
  and at runtime

- When the hardware drivers are loadable modules or disabled, and
  SOC_SOF_OF=y, prevent the IMX_SOF_OF drivers from being turned on,
  as this would be broken.

It seems that this is just an elaborate way to describe two tristate
symbols that have straight dependencies, but maybe I'm missing some
subtle point. It seems to always build for me now.

Fixes: fe57a92c8858 ("ASoC: SOF: Add missing dependency on IMX_SCU")
Fixes: afb93d716533 ("ASoC: SOF: imx: Add i.MX8M HW support")
Fixes: cb0312f61c3e ("ASoC: SOF: imx: fix undefined reference issue")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/imx/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index f76660e91382..66684d7590f4 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -21,7 +21,8 @@ config SND_SOC_SOF_IMX_OF
 
 config SND_SOC_SOF_IMX8_SUPPORT
 	bool "SOF support for i.MX8"
-	depends on IMX_SCU
+	depends on IMX_SCU=y || IMX_SCU=SND_SOC_SOF_IMX_OF
+	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_IMX_OF
 	help
 	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
 	  Say Y if you have such a device.
@@ -29,14 +30,13 @@ config SND_SOC_SOF_IMX8_SUPPORT
 
 config SND_SOC_SOF_IMX8
 	tristate
-	depends on IMX_SCU
-	select IMX_DSP
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
 config SND_SOC_SOF_IMX8M_SUPPORT
 	bool "SOF support for i.MX8M"
+	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_OF
 	help
 	  This adds support for Sound Open Firmware for NXP i.MX8M platforms
 	  Say Y if you have such a device.
@@ -44,7 +44,6 @@ config SND_SOC_SOF_IMX8M_SUPPORT
 
 config SND_SOC_SOF_IMX8M
 	tristate
-	depends on IMX_DSP
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
-- 
2.26.0

