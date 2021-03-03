Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AA5C433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 11:35:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8E764EDE
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 11:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8E764EDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DA8F18C9;
	Wed,  3 Mar 2021 12:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DA8F18C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614771304;
	bh=5c/JMX0QSs67tZCeCfDHSiyNIO6jfH+Qfv/nVIyRMFE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L4G7jQUKpD4rSNfSece59mCdkNfPxOix/8K3JvjojuS5w4DtFJmzHxufzbVuMP8VY
	 9Etj/hv9IW6tcqR7oMTJT8xYce1MvvOWOT7oLmCMEIYsAnCeVCK6G07ofE/CYQyaDc
	 sOy+BykVFub6YT//XnivMANjKnPSwUFscHQr0gL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03E12F80257;
	Wed,  3 Mar 2021 12:34:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD937F8025E; Wed,  3 Mar 2021 12:34:12 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82500F80227
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 12:34:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82500F80227
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 800442004F6;
 Wed,  3 Mar 2021 12:34:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5829200507;
 Wed,  3 Mar 2021 12:34:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B94C402C1;
 Wed,  3 Mar 2021 12:33:53 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 shengjiu.wang@nxp.com, ckeepax@opensource.cirrus.com,
 kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com,
 gustavoars@kernel.org, pierre-louis.bossart@linux.intel.com,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Relax bit clock divider searching
Date: Wed,  3 Mar 2021 19:21:28 +0800
Message-Id: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

With S20_3LE format case, the sysclk = rate * 384,
the bclk = rate * 20 * 2, there is no proper bclk divider
for 384 / 40, because current condition needs exact match.
So driver fails to configure the clocking:

wm8962 3-001a: Unsupported BCLK ratio 9

Fix this by relaxing bitclk divider searching, so that when
no exact value can be derived from sysclk pick the closest
value greater than expected bitclk.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8962.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ce4666a74793..f5cd22450190 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2403,6 +2403,7 @@ static const int sysclk_rates[] = {
 static void wm8962_configure_bclk(struct snd_soc_component *component)
 {
 	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
+	int best, min_diff, diff;
 	int dspclk, i;
 	int clocking2 = 0;
 	int clocking4 = 0;
@@ -2473,23 +2474,23 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 
 	dev_dbg(component->dev, "DSPCLK is %dHz, BCLK %d\n", dspclk, wm8962->bclk);
 
-	/* We're expecting an exact match */
+	/* Search a proper bclk, not exact match. */
+	best = 0;
+	min_diff = INT_MAX;
 	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
 		if (bclk_divs[i] < 0)
 			continue;
 
-		if (dspclk / bclk_divs[i] == wm8962->bclk) {
-			dev_dbg(component->dev, "Selected BCLK_DIV %d for %dHz\n",
-				bclk_divs[i], wm8962->bclk);
-			clocking2 |= i;
+		diff = (dspclk / bclk_divs[i]) - wm8962->bclk;
+		if (diff < 0) /* Table is sorted */
 			break;
+		if (diff < min_diff) {
+			best = i;
+			min_diff = diff;
 		}
 	}
-	if (i == ARRAY_SIZE(bclk_divs)) {
-		dev_err(component->dev, "Unsupported BCLK ratio %d\n",
-			dspclk / wm8962->bclk);
-		return;
-	}
+	wm8962->bclk = dspclk / bclk_divs[best];
+	clocking2 |= best;
 
 	aif2 |= wm8962->bclk / wm8962->lrclk;
 	dev_dbg(component->dev, "Selected LRCLK divisor %d for %dHz\n",
-- 
2.27.0

