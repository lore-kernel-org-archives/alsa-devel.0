Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D314C2BB85
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:01:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213F920730
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WIzkdQhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213F920730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 689EC16AB;
	Thu,  9 Apr 2020 22:00:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 689EC16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586462504;
	bh=x4ZZpdDaRcOeQkyZ9+AB4P41obCTd+8dxapbT6cRtN4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIzkdQhmpTj8TCgHGx5sao7S9T5fQYcOtlesrFGmht9mgnbbMmPWIvhICT0DLYGCY
	 qsYnJQzyqau2AQqOUgvt5H5vViB6hnM11GMvPjxzb3dFkZ+uciDaLMjKFQ/3d9Qaaq
	 RhejLMKc6lcAjwYnEkM6WvJj/LVlGAS7n0hCvdw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85EB3F80278;
	Thu,  9 Apr 2020 21:59:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98E4EF80216; Thu,  9 Apr 2020 21:59:11 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97CC4F801DA
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 21:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97CC4F801DA
IronPort-SDR: lVccfWay23FgvVi9CjppaZK5iN5Y6mwBOXHW+Bql1EP0ybATyOYHKtxRbfmy3nVdI7GtVtf5JX
 dAbTJZDZo7rQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 12:59:07 -0700
IronPort-SDR: W+Q0KmlcAo+MokzG3Z67qeXNbJTY7EV16ikLqX0KcazAVyjUPGA26DGgo6Hb4TVKb6PFY84NbN
 E9+YYdPSP79A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="242745316"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2020 12:59:05 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 04/16] ASoC: Intel: sof-pcm512x: detect Hifiberry DAC+ PRO
Date: Thu,  9 Apr 2020 14:58:29 -0500
Message-Id: <20200409195841.18901-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, Matthias Reichl <hias@horus.com>,
 broonie@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
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

Try to detect HifiBerry 44.1 and 48kHz oscillators on codec init

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_pcm512x.c | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/sound/soc/intel/boards/sof_pcm512x.c b/sound/soc/intel/boards/sof_pcm512x.c
index dcd769b352fa..c1d2a53c1ec8 100644
--- a/sound/soc/intel/boards/sof_pcm512x.c
+++ b/sound/soc/intel/boards/sof_pcm512x.c
@@ -46,6 +46,8 @@ struct sof_card_private {
 	struct list_head hdmi_pcm_list;
 	bool idisp_codec;
 	struct gpio_desc *gpio_4;
+	struct clk *sclk;
+	bool is_dac_pro;
 };
 
 static int sof_pcm512x_quirk_cb(const struct dmi_system_id *id)
@@ -87,6 +89,59 @@ static int sof_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 
 static int sof_pcm512x_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct sof_card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct device *dev = rtd->card->dev;
+	unsigned int sck;
+	int ret;
+
+	ctx->sclk = devm_clk_get(rtd->card->dev, "sclk");
+	if (IS_ERR(ctx->sclk)) {
+		dev_info(dev, "Could not get SCLK, will operate in SOC master mode\n");
+		goto skip_dacpro;
+	}
+
+	/*
+	 * now we have a clk, see if it's really present or if we are on
+	 * plain vanilla DAC+
+	 */
+
+	/* Try 48 kHz */
+	clk_set_rate(ctx->sclk, 24576000UL);
+	ret = clk_prepare_enable(ctx->sclk);
+	if (ret) {
+		dev_info(dev, "Failed to enable SCLK for DAC+ PRO 48 kHz: %d\n", ret);
+		goto skip_dacpro;
+	}
+
+	snd_soc_component_read(rtd->codec_dai->component,
+			       PCM512x_RATE_DET_4, &sck);
+	clk_disable_unprepare(ctx->sclk);
+	if (sck & 0x40) {
+		dev_info(dev, "No SCLK detected for DAC+ PRO 48 kHz\n");
+		goto skip_dacpro;
+	}
+
+	/* Try 44.1 kHz */
+	clk_set_rate(ctx->sclk, 22579200UL);
+	ret = clk_prepare_enable(ctx->sclk);
+	if (ret) {
+		dev_info(dev, "Failed to enable SCLK for DAC+ PRO 44.1 kHz: %d\n", ret);
+		goto skip_dacpro;
+	}
+
+	snd_soc_component_read(rtd->codec_dai->component,
+			       PCM512x_RATE_DET_4, &sck);
+	clk_disable_unprepare(ctx->sclk);
+
+	if (sck & 0x40) {
+		dev_info(dev, "No SCLK detected for DAC+ PRO 44.1 kHz\n");
+		goto skip_dacpro;
+	}
+
+	dev_info(dev, "DAC+ PRO detected\n");
+	ctx->is_dac_pro = true;
+
+skip_dacpro:
 	return 0;
 }
 
-- 
2.20.1

