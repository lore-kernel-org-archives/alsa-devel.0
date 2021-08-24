Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49544C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 10:18:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08A760238
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 10:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C08A760238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E5DA1683;
	Tue, 24 Aug 2021 12:17:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E5DA1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629800321;
	bh=xT65ljrV5J8gKDbO5fJHGDmWk5Zam6bpGX3U5CYveAM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YWyQSLHHkzAERSHihdeDrHv0vuBDO6zqjpMFQ0ZZCmLN2TEtttTpkSvWMsxQbdP5Z
	 EY49J59a25n3Tba0TUkmbi4oxq35/DlHF3XMHOvh9vdK8rmekrAVEp0X9seX3SBdif
	 ksJehRsTJ5K/Vdji9ZAWhgkCdud3r+bR8QOxB+hQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 830EEF804E7;
	Tue, 24 Aug 2021 12:16:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70611F804EC; Tue, 24 Aug 2021 12:16:36 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.133])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5DA2F80431
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 12:16:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5DA2F80431
Received: from localhost (unknown [192.168.167.235])
 by lucky1.263xmail.com (Postfix) with ESMTP id 3D297D64C9;
 Tue, 24 Aug 2021 18:16:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P32763T139760989173504S1629800174340042_; 
 Tue, 24 Aug 2021 18:16:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <408f5e1bfbcbb377745547de1a3b4b51>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH v1 2/4] ASoC: rockchip: spdif: Fix some coding style
Date: Tue, 24 Aug 2021 18:16:00 +0800
Message-Id: <1629800162-12824-3-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

This patch fix some coding style.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 8baa473..92b27b6 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -103,8 +103,8 @@ static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 }
 
 static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params,
-				  struct snd_soc_dai *dai)
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
 {
 	struct rk_spdif_dev *spdif = snd_soc_dai_get_drvdata(dai);
 	unsigned int val = SPDIF_CFGR_HALFWORD_ENABLE;
@@ -137,15 +137,15 @@ static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_update_bits(spdif->regmap, SPDIF_CFGR,
-		SPDIF_CFGR_CLK_DIV_MASK | SPDIF_CFGR_HALFWORD_ENABLE |
-		SDPIF_CFGR_VDW_MASK,
-		val);
+				 SPDIF_CFGR_CLK_DIV_MASK |
+				 SPDIF_CFGR_HALFWORD_ENABLE |
+				 SDPIF_CFGR_VDW_MASK, val);
 
 	return ret;
 }
 
 static int rk_spdif_trigger(struct snd_pcm_substream *substream,
-				int cmd, struct snd_soc_dai *dai)
+			    int cmd, struct snd_soc_dai *dai)
 {
 	struct rk_spdif_dev *spdif = snd_soc_dai_get_drvdata(dai);
 	int ret;
@@ -155,31 +155,31 @@ static int rk_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
-				   SPDIF_DMACR_TDE_ENABLE |
-				   SPDIF_DMACR_TDL_MASK,
-				   SPDIF_DMACR_TDE_ENABLE |
-				   SPDIF_DMACR_TDL(16));
+					 SPDIF_DMACR_TDE_ENABLE |
+					 SPDIF_DMACR_TDL_MASK,
+					 SPDIF_DMACR_TDE_ENABLE |
+					 SPDIF_DMACR_TDL(16));
 
 		if (ret != 0)
 			return ret;
 
 		ret = regmap_update_bits(spdif->regmap, SPDIF_XFER,
-				   SPDIF_XFER_TXS_START,
-				   SPDIF_XFER_TXS_START);
+					 SPDIF_XFER_TXS_START,
+					 SPDIF_XFER_TXS_START);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
-				   SPDIF_DMACR_TDE_ENABLE,
-				   SPDIF_DMACR_TDE_DISABLE);
+					 SPDIF_DMACR_TDE_ENABLE,
+					 SPDIF_DMACR_TDE_DISABLE);
 
 		if (ret != 0)
 			return ret;
 
 		ret = regmap_update_bits(spdif->regmap, SPDIF_XFER,
-				   SPDIF_XFER_TXS_START,
-				   SPDIF_XFER_TXS_STOP);
+					 SPDIF_XFER_TXS_START,
+					 SPDIF_XFER_TXS_STOP);
 		break;
 	default:
 		ret = -EINVAL;
@@ -293,7 +293,7 @@ static int rk_spdif_probe(struct platform_device *pdev)
 		grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 		if (IS_ERR(grf)) {
 			dev_err(&pdev->dev,
-				"rockchip_spdif missing 'rockchip,grf' \n");
+				"rockchip_spdif missing 'rockchip,grf'\n");
 			return PTR_ERR(grf);
 		}
 
-- 
2.7.4



