Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC169C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 13:25:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B190610CC
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 13:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B190610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B65BA189D;
	Fri,  3 Sep 2021 15:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B65BA189D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630675510;
	bh=DaqCAiCq0Ltz1fR1/QlXGsRKI+xuvYNDm2ylptVkZS8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2O69vS4JiEpv8Y4Wk6zXSHkhsWoXIkYgTPj8Y8a5w20JIrlA9JwZ4nm1Mvrx5R5v
	 tXFWMpVBfjHoB7dF8VLEf2w11IQJ6irFpsPibj2MQ6c4/14CBdvQu9qR+GughdJDN2
	 eviRMB8W52/z3o6nVuiv+B01mrvvDqpn8GmluLsc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 737E7F800B5;
	Fri,  3 Sep 2021 15:23:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 693E6F804E4; Fri,  3 Sep 2021 15:23:46 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.134])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E45D2F800B5
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 15:23:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E45D2F800B5
Received: from localhost (unknown [192.168.167.235])
 by lucky1.263xmail.com (Postfix) with ESMTP id E8DE0CFCFE;
 Fri,  3 Sep 2021 21:23:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P32763T139760603449088S1630675411965630_; 
 Fri, 03 Sep 2021 21:23:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <711e667cc5680a56e871b1c39588b6b3>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH v4 1/7] ASoC: rockchip: Add support for rv1126 pdm
Date: Fri,  3 Sep 2021 21:23:24 +0800
Message-Id: <1630675410-3354-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630675357-3286-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1630675357-3286-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org
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

This patch adds support for rv1126 pdm controller which
redesign cic filiter for better performance.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/rockchip_pdm.c | 76 +++++++++++++++++++++++++++++++++++----
 sound/soc/rockchip/rockchip_pdm.h |  3 ++
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 38bd603..67634d1 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -24,6 +24,7 @@
 enum rk_pdm_version {
 	RK_PDM_RK3229,
 	RK_PDM_RK3308,
+	RK_PDM_RV1126,
 };
 
 struct rk_pdm_dev {
@@ -121,6 +122,55 @@ static unsigned int get_pdm_ds_ratio(unsigned int sr)
 	return ratio;
 }
 
+static unsigned int get_pdm_cic_ratio(unsigned int clk)
+{
+	switch (clk) {
+	case 4096000:
+	case 5644800:
+	case 6144000:
+		return 0;
+	case 2048000:
+	case 2822400:
+	case 3072000:
+		return 1;
+	case 1024000:
+	case 1411200:
+	case 1536000:
+		return 2;
+	default:
+		return 1;
+	}
+}
+
+static unsigned int samplerate_to_bit(unsigned int samplerate)
+{
+	switch (samplerate) {
+	case 8000:
+	case 11025:
+	case 12000:
+		return 0;
+	case 16000:
+	case 22050:
+	case 24000:
+		return 1;
+	case 32000:
+		return 2;
+	case 44100:
+	case 48000:
+		return 3;
+	case 64000:
+	case 88200:
+	case 96000:
+		return 4;
+	case 128000:
+	case 176400:
+	case 192000:
+		return 5;
+	default:
+		return 1;
+	}
+}
+
 static inline struct rk_pdm_dev *to_info(struct snd_soc_dai *dai)
 {
 	return snd_soc_dai_get_drvdata(dai);
@@ -166,7 +216,8 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return -EINVAL;
 
-	if (pdm->version == RK_PDM_RK3308) {
+	if (pdm->version == RK_PDM_RK3308 ||
+	    pdm->version == RK_PDM_RV1126) {
 		rational_best_approximation(clk_out, clk_src,
 					    GENMASK(16 - 1, 0),
 					    GENMASK(16 - 1, 0),
@@ -194,8 +245,18 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 				   PDM_CLK_FD_RATIO_MSK,
 				   val);
 	}
-	val = get_pdm_ds_ratio(samplerate);
-	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_DS_RATIO_MSK, val);
+
+	if (pdm->version == RK_PDM_RV1126) {
+		val = get_pdm_cic_ratio(clk_out);
+		regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_CIC_RATIO_MSK, val);
+		val = samplerate_to_bit(samplerate);
+		regmap_update_bits(pdm->regmap, PDM_CTRL0,
+				   PDM_SAMPLERATE_MSK, PDM_SAMPLERATE(val));
+	} else {
+		val = get_pdm_ds_ratio(samplerate);
+		regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_DS_RATIO_MSK, val);
+	}
+
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_CF_MSK, PDM_HPF_60HZ);
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
@@ -441,9 +502,10 @@ static bool rockchip_pdm_precious_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct reg_default rockchip_pdm_reg_defaults[] = {
-	{0x04, 0x78000017},
-	{0x08, 0x0bb8ea60},
-	{0x18, 0x0000001f},
+	{ PDM_CTRL0, 0x78000017 },
+	{ PDM_CTRL1, 0x0bb8ea60 },
+	{ PDM_CLK_CTRL, 0x0000e401 },
+	{ PDM_DMA_CTRL, 0x0000001f },
 };
 
 static const struct regmap_config rockchip_pdm_regmap_config = {
@@ -469,6 +531,8 @@ static const struct of_device_id rockchip_pdm_match[] __maybe_unused = {
 	  .data = (void *)RK_PDM_RK3308 },
 	{ .compatible = "rockchip,rk3308-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
+	{ .compatible = "rockchip,rv1126-pdm",
+	  .data = (void *)RK_PDM_RV1126 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rockchip_pdm_match);
diff --git a/sound/soc/rockchip/rockchip_pdm.h b/sound/soc/rockchip/rockchip_pdm.h
index 8e5bbaf..13bfbc2 100644
--- a/sound/soc/rockchip/rockchip_pdm.h
+++ b/sound/soc/rockchip/rockchip_pdm.h
@@ -41,6 +41,8 @@
 #define PDM_PATH1_EN		BIT(28)
 #define PDM_PATH0_EN		BIT(27)
 #define PDM_HWT_EN		BIT(26)
+#define PDM_SAMPLERATE_MSK	GENMASK(7, 5)
+#define PDM_SAMPLERATE(x)	((x) << 5)
 #define PDM_VDW_MSK		(0x1f << 0)
 #define PDM_VDW(X)		((X - 1) << 0)
 
@@ -66,6 +68,7 @@
 #define PDM_CLK_1280FS		(0x2 << 0)
 #define PDM_CLK_2560FS		(0x3 << 0)
 #define PDM_CLK_5120FS		(0x4 << 0)
+#define PDM_CIC_RATIO_MSK	(0x3 << 0)
 
 /* PDM HPF CTRL */
 #define PDM_HPF_LE		BIT(3)
-- 
2.7.4



