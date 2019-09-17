Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682CCC4CECD
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:19:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7F221670
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="keVyWRHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7F221670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 255A61682;
	Tue, 17 Sep 2019 20:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 255A61682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568744366;
	bh=0K1/f7aiQhsjX9tBrytPsRCMq24ewxpRhKt/YusJWY0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keVyWRHeFue3lQsTRKPzRoFowEIJeJ3Csij+TDcD14lbufjElgGGK2rP7zjkj5w6j
	 YyYuh65v/0bUrauhBZKbGuoS3mdzfTF3cga5wWwLf6aFlVY0fcyzqCYe8x4ZlYJtKF
	 YD4Ye2SsfjhTd94PPgzZEOjtQ7QtFMEaXED4/FAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 910ADF80671;
	Tue, 17 Sep 2019 20:12:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BB5DF805F9; Tue, 17 Sep 2019 20:12:45 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF0D0F805A1
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 20:12:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF0D0F805A1
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iAHxq-0003oD-Ko; Tue, 17 Sep 2019 19:12:34 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
 (envelope-from <ben@rainbowdash.codethink.co.uk>)
 id 1iAHxq-0000BF-7H; Tue, 17 Sep 2019 19:12:34 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Date: Tue, 17 Sep 2019 19:12:26 +0100
Message-Id: <20190917181233.534-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917181233.534-1-ben.dooks@codethink.co.uk>
References: <20190917181233.534-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Cc: linux-kernel@lists.codethink.co.uk,
 Edward Cragg <edward.cragg@codethink.co.uk>
Subject: [alsa-devel] [PATCH 1/8] ASoC: tegra: Add a TDM configuration
	callback
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Edward Cragg <edward.cragg@codethink.co.uk>

Add a callback to configure TDM settings for the Tegra30 I2S ASoC 'platform'
driver.

Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
---
 sound/soc/tegra/tegra30_i2s.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index ac6983c6bd72..d36b4662b420 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -254,6 +254,39 @@ static int tegra30_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
+/*
+ * Set up TDM
+ */
+static int tegra30_i2s_set_tdm(struct snd_soc_dai *dai,
+			       unsigned int tx_mask, unsigned int rx_mask,
+			       int slots, int slot_width)
+{
+	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int mask = 0, val = 0;
+
+	dev_info(dai->dev, "%s: setting TDM: tx_mask: 0x%08x rx_mask: 0x%08x "
+		 "slots: 0x%08x " "width: %d\n",
+		 __func__, tx_mask, rx_mask, slots, slot_width);
+
+	/* Set up slots and tx/rx masks */
+	mask = TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK |
+	       TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_MASK |
+	       TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_MASK;
+
+	val = (tx_mask << TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_SHIFT) |
+	      (rx_mask << TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT) |
+	      ((slots - 1) << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT);
+
+	regmap_update_bits(i2s->regmap, TEGRA30_I2S_SLOT_CTRL, mask, val);
+
+	/* Set FSYNC width */
+	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CH_CTRL,
+		TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_MASK,
+		(slot_width - 1) << TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_SHIFT);
+
+	return 0;
+}
+
 static int tegra30_i2s_probe(struct snd_soc_dai *dai)
 {
 	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -268,6 +301,7 @@ static const struct snd_soc_dai_ops tegra30_i2s_dai_ops = {
 	.set_fmt	= tegra30_i2s_set_fmt,
 	.hw_params	= tegra30_i2s_hw_params,
 	.trigger	= tegra30_i2s_trigger,
+	.set_tdm_slot	= tegra30_i2s_set_tdm,
 };
 
 static const struct snd_soc_dai_driver tegra30_i2s_dai_template = {
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
