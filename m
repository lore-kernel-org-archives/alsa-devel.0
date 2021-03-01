Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A808FC433E6
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:12:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51AE651A4
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51AE651A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39F42169B;
	Mon,  1 Mar 2021 18:11:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39F42169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614618735;
	bh=GNe5qxOScaDRkau7kWsGzTtDQtpnbj9n+i9KnLZKnoc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+wXwMkUr64PZ8pp1XAIy4nCTt72JS8uORmRV+yZTDuLrHU6iu+37ZY4mcNsMiyx2
	 /wjeiyZTjcAG37MpOxqgE2nF5JLqtwF8S0jZzhwCREpxoK8IC8Ra/YOlI111yB1jNc
	 D9qonzBJVv9CtCDTLfwKQ+uTnO+1WsDu3gU1Yiag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B60AF80423;
	Mon,  1 Mar 2021 18:09:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 817E2F80431; Mon,  1 Mar 2021 18:09:53 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D28C2F802E0
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 18:09:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D28C2F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="gIGkrpEF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1614618588; x=1646154588;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GNe5qxOScaDRkau7kWsGzTtDQtpnbj9n+i9KnLZKnoc=;
 b=gIGkrpEFIuPL8IxM5SPTde6JdYnOZWSTRo3+Miq5gg/XarAgUVBMLXcI
 5bEtbJIoYsjBGF7pzWCQOdQEcfmfGbcrWHAmKv1qGeAKiW6PnLqSw+xOY
 FdzyF8GEiQj3/YbSEWVowdsytAa/swBgN7BRdgGIAdBO5OJYbo79DL5xt
 npmX9kkJI+HkmmGGZKzzF/KEh7E+r1+Qtx09yPrg4artLCWk6J2/Yiziz
 uPaCQzkLgHpQHERxtnCY7a6aEvFLVgbQC8chNv1yUu95ksQsjmCGmxwog
 J87JHLXhr8dgsPkRbxxUN49FgiE/pfaui4VO6bILZvS0RwbQAwnApMPvC A==;
IronPort-SDR: b1QKTRCL3OutM/khAUSHwQaIZo1GLML5eG0GIeYcLd6sZjl5QEn4lmJem+pA6p0jehOadPGDZD
 kJo832DwQhMdCQKpFfF8SAnscOqbhjFNxIovjQlYKDXaiyycRCP+T6RtpjhAprVp/0w9GrQCqe
 JOqX5DcXNDDeHWBw7VQq3RPirpORyhT67Xf6hM/RxsGLbaikatudmZ/gLiT+MXKzed0iQZrMsQ
 0OVoXF/CITxhBFcAA+PAq8jiEDWwvaFcMuNjqcG8Q841PCmo4J1X5TrEz3542EroMsv7qOoYUT
 VFo=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; d="scan'208";a="111511668"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 01 Mar 2021 10:09:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:09:41 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:38 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/7] ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
Date: Mon, 1 Mar 2021 19:09:00 +0200
Message-ID: <20210301170905.835091-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
 nicolas.ferre@microchip.com, robh+dt@kernel.org, tiwai@suse.com,
 ludovic.desroches@microchip.com, broonie@kernel.org, Codrin
 Ciubotariu <codrin.ciubotariu@microchip.com>
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

Microchip's new SAMA7G5 includes an updated I2S-MCC compatible with the
previous version found on SAM9X60. The new controller includes 8 (4 * 2)
input and output data pins for up to 8 channels for I2S and Left-Justified
formats.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
- none

 sound/soc/atmel/Kconfig        | 3 +++
 sound/soc/atmel/mchp-i2s-mcc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 9fe9471f4514..ec04e3386bc0 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -127,10 +127,13 @@ config SND_MCHP_SOC_I2S_MCC
 	  Say Y or M if you want to add support for I2S Multi-Channel ASoC
 	  driver on the following Microchip platforms:
 	  - sam9x60
+	  - sama7g5
 
 	  The I2SMCC complies with the Inter-IC Sound (I2S) bus specification
 	  and supports a Time Division Multiplexed (TDM) interface with
 	  external multi-channel audio codecs.
+	  Starting with sama7g5, I2S and Left-Justified multi-channel is
+	  supported by using multiple data pins, output and input, without TDM.
 
 config SND_MCHP_SOC_SPDIFTX
 	tristate "Microchip ASoC driver for boards using S/PDIF TX"
diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 6d5ae18f8b38..0ee01383e307 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -873,6 +873,9 @@ static const struct of_device_id mchp_i2s_mcc_dt_ids[] = {
 	{
 		.compatible = "microchip,sam9x60-i2smcc",
 	},
+	{
+		.compatible = "microchip,sama7g5-i2smcc",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mchp_i2s_mcc_dt_ids);
-- 
2.27.0

