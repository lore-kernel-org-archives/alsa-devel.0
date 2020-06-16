Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF5C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:06:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60B2207D3
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J6pqc7a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60B2207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CECA1674;
	Tue, 16 Jun 2020 05:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CECA1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592276759;
	bh=H2DYPtVk95Mvct2kvASXDRkfkniiNywomoPAippt+Dw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J6pqc7a7ynor9g7dpd1n2M1C31Ls22GBIq96No+iOXOF1Os4XaQ2CKqomyw0Nwzze
	 aVWAkU34KjtvS8ABbfKm5GmLWDZmlg+JPQ9lyFoLspiclTstS5UVfURZSV1GtTu6mB
	 NMHdPDgSmlhFYjXEnht9SMrFG6a1xI45KPyrNKc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC892F80217;
	Tue, 16 Jun 2020 05:05:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 136DFF8022B; Tue, 16 Jun 2020 05:05:04 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23C2AF80114
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 05:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23C2AF80114
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0AF81A0547;
 Tue, 16 Jun 2020 05:04:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B6E321A053B;
 Tue, 16 Jun 2020 05:04:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4B8E8402D0;
 Tue, 16 Jun 2020 11:04:44 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH v3] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Date: Tue, 16 Jun 2020 10:53:48 +0800
Message-Id: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

For mono channel, SSI will switch to Normal mode.

In Normal mode and Network mode, the Word Length Control bits
control the word length divider in clock generator, which is
different with I2S Master mode (the word length is fixed to
32bit), it should be the value of params_width(hw_params).

The condition "slots == 2" is not good for I2S Master mode,
because for Network mode and Normal mode, the slots can also
be 2. Then we need to use (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK)
to check if it is I2S Master mode.

So we refine the formula for mono channel, otherwise there
will be sound issue for S24_LE.

Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v3
- update according to Nicolin's comments

changes in v2
- refine patch for Network mode and Normal mode.

 sound/soc/fsl/fsl_ssi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index bad89b0d129e..1a2fa7f18142 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -678,8 +678,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	struct regmap *regs = ssi->regs;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long clkrate, baudrate, tmprate;
-	unsigned int slots = params_channels(hw_params);
-	unsigned int slot_width = 32;
+	unsigned int channels = params_channels(hw_params);
+	unsigned int slot_width = params_width(hw_params);
+	unsigned int slots = 2;
 	u64 sub, savesub = 100000;
 	unsigned int freq;
 	bool baudclk_is_used;
@@ -688,10 +689,14 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	/* Override slots and slot_width if being specifically set... */
 	if (ssi->slots)
 		slots = ssi->slots;
-	/* ...but keep 32 bits if slots is 2 -- I2S Master mode */
-	if (ssi->slot_width && slots != 2)
+	if (ssi->slot_width)
 		slot_width = ssi->slot_width;
 
+	/* ...but force 32 bits for stereo audio using I2S Master Mode */
+	if (channels == 2 &&
+	    (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK) == SSI_SCR_I2S_MODE_MASTER)
+		slot_width = 32;
+
 	/* Generate bit clock based on the slot number and slot width */
 	freq = slots * slot_width * params_rate(hw_params);
 
-- 
2.21.0

