Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005FBC47082
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 22:20:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C32461405
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 22:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C32461405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jacquin.bzh
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 188DF171E;
	Fri,  4 Jun 2021 00:19:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 188DF171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622758833;
	bh=1Qs5tdTerDn5+gJQx/BN2G6rVjGWCHqZbZQL/O8xRsc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XjFvNNGgqVl915hHw65J8EhwoC1XW4yaJ3G5MQJESvvfxS5oIQSZR7VQkOke+e380
	 YHba7WhF8h2N7cfgAY/M203dsaazwN1RIMzIqxJpzdsKflA6fXCohrRkh8ovyHgRhp
	 sSe6uZn+c8p351cPBaI5apguHRek9HjPGcbzeODY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D368F802DB;
	Fri,  4 Jun 2021 00:18:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2289EF80254; Fri,  4 Jun 2021 00:18:41 +0200 (CEST)
Received: from toothrot.meleeweb.net (toothrot.meleeweb.net [62.210.131.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E1C0F80103
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 00:18:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E1C0F80103
Received: from [80.111.226.61] (port=10334 helo=lady-voodoo.local)
 by toothrot.meleeweb.net with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 id 1lovfR-0045z8-06; Fri, 04 Jun 2021 00:18:21 +0200
From: Bertrand Jacquin <bertrand@jacquin.bzh>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, srinivas.kandagatla@linaro.org,
 alexandre.belloni@bootlin.com
Subject: [PATCH] ASoC: snd-soc-lpass requires REGMAP_MMIO
Date: Thu,  3 Jun 2021 23:18:16 +0100
Message-Id: <20210603221816.2642402-1-bertrand@jacquin.bzh>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

With CONFIG_SND_SOC_LPASS_RX_MACRO=m and CONFIG_REGMAP_MMIO undefined,
build fails with the following error

  make -f /var/tmp/portage/sys-kernel/stable-sources-5.12.8/work/linux-5.12.8-stable/scripts/Makefile.modpost
    sed 's/\.ko$/\.o/' modules.order | scripts/mod/modpost   -E  -o modules-only.symvers -i vmlinux.symvers   -T -
  ERROR: modpost: "__devm_regmap_init_mmio_clk" [sound/soc/codecs/snd-soc-lpass-rx-macro.ko] undefined!

This does also apply to other Qualcomm Macro LPASS all making call to
devm_regmap_init_mmio()

Signed-off-by: Bertrand Jacquin <bertrand@jacquin.bzh>
---
 sound/soc/codecs/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1c87b42606c9..f5614f47f44d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1824,18 +1824,22 @@ config SND_SOC_TPA6130A2
 
 config SND_SOC_LPASS_WSA_MACRO
 	depends on COMMON_CLK
+	select REGMAP_MMIO
 	tristate "Qualcomm WSA Macro in LPASS(Low Power Audio SubSystem)"
 
 config SND_SOC_LPASS_VA_MACRO
 	depends on COMMON_CLK
+	select REGMAP_MMIO
 	tristate "Qualcomm VA Macro in LPASS(Low Power Audio SubSystem)"
 
 config SND_SOC_LPASS_RX_MACRO
 	depends on COMMON_CLK
+	select REGMAP_MMIO
 	tristate "Qualcomm RX Macro in LPASS(Low Power Audio SubSystem)"
 
 config SND_SOC_LPASS_TX_MACRO
 	depends on COMMON_CLK
+	select REGMAP_MMIO
 	tristate "Qualcomm TX Macro in LPASS(Low Power Audio SubSystem)"
 
 endmenu
