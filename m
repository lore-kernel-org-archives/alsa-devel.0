Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96213C432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 01:12:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1666A60E90
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 01:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1666A60E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A21C61703;
	Mon, 30 Aug 2021 03:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A21C61703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630285975;
	bh=/Df8B08Oz0yOder42TvZOtj276Gg/+w33BTlfEUnrXk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OUuFadoi/KSAaHldCW8k31TU9kO0MwvhWVoE9KtN0cfBO5yIL02WjHFhrvxNfDUj2
	 Rng9hAON0zb2uyyPyaKQSvKKqAHqNVaOZoWIz4BmJ2tT+bZO3umv3W/gXxUBTJJQDt
	 0+kdWsmqzzLAgbCc/Kf7aQzetoWc+147X4rQvzV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9FF0F804EB;
	Mon, 30 Aug 2021 03:11:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E079EF804E2; Mon, 30 Aug 2021 03:10:55 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.134])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AD7FF8028D
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 03:10:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AD7FF8028D
Received: from localhost (unknown [192.168.167.224])
 by lucky1.263xmail.com (Postfix) with ESMTP id 2F6A1CF753;
 Mon, 30 Aug 2021 09:10:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P22031T140205919041280S1630285834273010_; 
 Mon, 30 Aug 2021 09:10:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7e6c3a6b4507fc5077e838d9054b4e59>
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
Subject: [PATCH v2 5/7] ASoC: rockchip: pdm: Add support for path map
Date: Mon, 30 Aug 2021 09:10:30 +0800
Message-Id: <1630285832-28079-5-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630285788-28002-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1630285788-28002-1-git-send-email-sugar.zhang@rock-chips.com>
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

This patch adds property 'rockchip,path-map' for path mapping.

e.g.

"rockchip,path-map = <3 2 1 0>" means the mapping as follows:

  path0 <-- sdi3
  path1 <-- sdi2
  path2 <-- sdi1
  path3 <-- sdi0

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2: None

 sound/soc/rockchip/rockchip_pdm.c | 34 ++++++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_pdm.h |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index f2bf023..64d9891 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -20,6 +20,7 @@
 
 #define PDM_DMA_BURST_SIZE	(8) /* size * width: 8*4 = 32 bytes */
 #define PDM_SIGNOFF_CLK_RATE	(100000000)
+#define PDM_PATH_MAX		(4)
 
 enum rk_pdm_version {
 	RK_PDM_RK3229,
@@ -539,8 +540,36 @@ static const struct of_device_id rockchip_pdm_match[] __maybe_unused = {
 };
 MODULE_DEVICE_TABLE(of, rockchip_pdm_match);
 
+static int rockchip_pdm_path_parse(struct rk_pdm_dev *pdm, struct device_node *node)
+{
+	unsigned int path[PDM_PATH_MAX];
+	int cnt = 0, ret = 0, i = 0, val = 0, msk = 0;
+
+	cnt = of_count_phandle_with_args(node, "rockchip,path-map",
+					 NULL);
+	if (cnt != PDM_PATH_MAX)
+		return cnt;
+
+	ret = of_property_read_u32_array(node, "rockchip,path-map",
+					 path, cnt);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < cnt; i++) {
+		if (path[i] >= PDM_PATH_MAX)
+			return -EINVAL;
+		msk |= PDM_PATH_MASK(i);
+		val |= PDM_PATH(i, path[i]);
+	}
+
+	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, msk, val);
+
+	return 0;
+}
+
 static int rockchip_pdm_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct rk_pdm_dev *pdm;
 	struct resource *res;
@@ -606,6 +635,11 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 	}
 
 	rockchip_pdm_rxctrl(pdm, 0);
+
+	ret = rockchip_pdm_path_parse(pdm, node);
+	if (ret != 0 && ret != -ENOENT)
+		goto err_suspend;
+
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
diff --git a/sound/soc/rockchip/rockchip_pdm.h b/sound/soc/rockchip/rockchip_pdm.h
index 13bfbc2..cab9772 100644
--- a/sound/soc/rockchip/rockchip_pdm.h
+++ b/sound/soc/rockchip/rockchip_pdm.h
@@ -53,6 +53,9 @@
 #define PDM_FD_DENOMINATOR_MSK	GENMASK(15, 0)
 
 /* PDM CLK CTRL */
+#define PDM_PATH_SHIFT(x)	(8 + (x) * 2)
+#define PDM_PATH_MASK(x)	(0x3 << PDM_PATH_SHIFT(x))
+#define PDM_PATH(x, v)		((v) << PDM_PATH_SHIFT(x))
 #define PDM_CLK_FD_RATIO_MSK	BIT(6)
 #define PDM_CLK_FD_RATIO_40	(0X0 << 6)
 #define PDM_CLK_FD_RATIO_35	BIT(6)
-- 
2.7.4



