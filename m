Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2596DC7EE23
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jun 2023 12:09:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B748A20C;
	Wed,  7 Jun 2023 14:08:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B748A20C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686139788;
	bh=ajWdmE+oEITOfGOM0DiF4YY95IS+tAiw8M8wSeFjfJc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qbGVik1eopy8V9biCqPd/KdG9nzOPAlySnHaSCPGXr+EaFIngHtJpY+uzZZQn+MFH
	 kxlmnm3Z8T5i1RyKOYb0rLOQb5LrV3ahFo74M2xc/6UVezw6oJn+VwNlnhyy8dodZl
	 dLylXZ572ID+rSOjpOK9RgPRUDh2BibEM39rDMFE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20F77F80520; Wed,  7 Jun 2023 14:08:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C396BF80199;
	Wed,  7 Jun 2023 14:08:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B691CF80199; Wed,  7 Jun 2023 14:08:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6EB9AF800C8
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 14:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EB9AF800C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Bi+Wp+C6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43E0763410;
	Wed,  7 Jun 2023 12:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF3DC433EF;
	Wed,  7 Jun 2023 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686139718;
	bh=ajWdmE+oEITOfGOM0DiF4YY95IS+tAiw8M8wSeFjfJc=;
	h=From:To:Cc:Subject:Date:From;
	b=Bi+Wp+C6tbHnzgHh1p+180dQ/zx9IUMtY1VfKbsF+Z6NcjawkF67gfhSgdhHTpAPy
	 K/+O9EkvHkxjVf8Va3NjQUEkwAfD3NKQkywYkVXXdHO3agZsQJ5ep0O3v82jqjxoMd
	 DgsOe7DtWJjJes8wCRxqJIZ5l+jLK4GIORNxAUWEv1Qgs/KuyMsy9Jp9PtghSfHphS
	 31S29SmnQ1uIFM1z4Uco4AzI8ppCeQ4yDaRZOkLlDVrVZBcN18fTfItUrJC82TpIHB
	 jRAqUAmruppRV96n5IsNE13ScmceWymV5DOSGPtUY/xUXiv/PEFdDANPLFLISbTtqN
	 Pb8HNcN+6mFjg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jiaxin Yu <jiaxin.yu@mediatek.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8188-mt6359: add i2c dependency
Date: Wed,  7 Jun 2023 14:08:15 +0200
Message-Id: <20230607120831.3587379-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4SIC5TC6CZHOVHRB6MB5XVSO6BLOMELR
X-Message-ID-Hash: 4SIC5TC6CZHOVHRB6MB5XVSO6BLOMELR
X-MailFrom: arnd@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4SIC5TC6CZHOVHRB6MB5XVSO6BLOMELR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver is missing this dependency, causing a possible
build failure:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98390
WARNING: unmet direct dependencies detected for SND_SOC_NAU8825
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=m]
  Selected by [y]:
  - SND_SOC_MT8188_MT6359 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_MT8188 [=y] && MTK_PMIC_WRAP [=y]
aarch64-linux-ld: sound/soc/codecs/max98390.o: in function `max98390_i2c_probe':
max98390.c:(.text+0x514): undefined reference to `__devm_regmap_init_i2c'

Fixes: 9f08dcbddeb30 ("ASoC: mediatek: mt8188-mt6359: support new board with nau88255")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 4ea012342b522..90db67e0ce4fb 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -223,6 +223,7 @@ config SND_SOC_MT8188
 config SND_SOC_MT8188_MT6359
 	tristate "ASoC Audio driver for MT8188 with MT6359 and I2S codecs"
 	depends on SND_SOC_MT8188 && MTK_PMIC_WRAP
+	depends on I2C
 	select SND_SOC_MT6359
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_DMIC
-- 
2.39.2

