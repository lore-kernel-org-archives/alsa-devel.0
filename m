Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43DC433E9
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 11:04:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3C464F4D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 11:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3C464F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B198167B;
	Fri, 19 Mar 2021 12:03:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B198167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616151836;
	bh=3HSzzf53prmqPwyOp0zRmesaP40dboWYdXIHFBVtGwI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nHeXrdDfXubZAtlib089SGgppwQMP9FvZ+FrMsMdHjvZFCmintNH75mo8ojbo/0iN
	 vNEf6Z7oeiz9r9CfFAXWVXZ2H4Kp2xS+81BZnEEwqdKi7GmuH36rRCLcrXn0YqWt8U
	 Bq1SXF7ZUNW6MwTtfxM3KfQWmskxWhcs6i8Kgj00=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D38BF800BB;
	Fri, 19 Mar 2021 12:03:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86785F8021C; Fri, 19 Mar 2021 12:03:03 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58ED5F800BB
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 12:02:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58ED5F800BB
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92FD71A0F72;
 Fri, 19 Mar 2021 12:02:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A7E01A28BD;
 Fri, 19 Mar 2021 12:02:39 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B4F154029D;
 Fri, 19 Mar 2021 12:02:30 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 shengjiu.wang@nxp.com, ckeepax@opensource.cirrus.com,
 kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com,
 gustavoars@kernel.org, pierre-louis.bossart@linux.intel.com,
 daniel.baluta@nxp.com, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for
 some chips
Date: Fri, 19 Mar 2021 18:48:46 +0800
Message-Id: <1616150926-22892-1-git-send-email-shengjiu.wang@nxp.com>
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

The input MCLK is 12.288MHz, the desired output sysclk is 11.2896MHz
and sample rate is 44100Hz, with the configuration pllprescale=2,
postscale=sysclkdiv=1, some chip may have wrong bclk
and lrclk output with pll enabled in master mode, but with the
configuration pllprescale=1, postscale=2, the output clock is correct.

From Datasheet, the PLL performs best when f2 is between
90MHz and 100MHz when the desired sysclk output is 11.2896MHz
or 12.288MHz, so sysclkdiv = 2 (f2/8) is the best choice.

So search available sysclk_divs from 2 to 1 other than from 1 to 2.

Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8960.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index df351519a3a6..cda9cd935d4f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -707,7 +707,13 @@ int wm8960_configure_pll(struct snd_soc_component *component, int freq_in,
 	best_freq_out = -EINVAL;
 	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
-	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+	/*
+	 * From Datasheet, the PLL performs best when f2 is between
+	 * 90MHz and 100MHz, the desired sysclk output is 11.2896MHz
+	 * or 12.288MHz, then sysclkdiv = 2 is the best choice.
+	 * So search sysclk_divs from 2 to 1 other than from 1 to 2.
+	 */
+	for (i = ARRAY_SIZE(sysclk_divs) - 1; i >= 0; --i) {
 		if (sysclk_divs[i] == -1)
 			continue;
 		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
-- 
2.17.1

