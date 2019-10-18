Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517FCA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:55:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEA02082C
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k5n2h+NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEA02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FA611697;
	Fri, 18 Oct 2019 17:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FA611697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571414118;
	bh=BzwbkVK1JhflP3iZ3NjqBRVf9ygNDTEhBbytdhtkyAE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5n2h+NXQjXtR3SVu4a1lq4ptsT7rfYakO4mn+gAC+z1KZh9pISLoGaJlkxkqlvor
	 e4vCh0H6UMlHRaJCnjHU1lHKk4pUEqT1h9ueRuLu/nFwApg161egYk0BQyzGXk5es7
	 E0XFZDbDWc4B6LOPgi0RSAMG2C+rmAdjwVcOeHp4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF691F80611;
	Fri, 18 Oct 2019 17:48:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E925F805FE; Fri, 18 Oct 2019 17:48:44 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC7C0F80369
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 17:48:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC7C0F80369
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iLUUV-0006s4-Ji; Fri, 18 Oct 2019 16:48:35 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
 (envelope-from <ben@rainbowdash.codethink.co.uk>)
 id 1iLUUU-0001zA-PE; Fri, 18 Oct 2019 16:48:34 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Date: Fri, 18 Oct 2019 16:48:33 +0100
Message-Id: <20191018154833.7560-8-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
References: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Cc: linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [alsa-devel] [PATCH v5 7/7] ASoC: tegra: take packing settings from
	the audio cif_config
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

If the CIF is not configured as 16 or 8 bit, then the
packing for 8/16 bits should not be enabled as the
hardware only supports 8 or 16 bit packing.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 sound/soc/tegra/tegra30_ahub.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 24bc03428b45..0768c6b6dc25 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -96,10 +96,17 @@ int tegra30_ahub_setup_rx_fifo(enum tegra30_ahub_rxcif rxcif,
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
 	val &= ~(TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK |
-		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK);
-	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT) |
-	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN |
-	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16;
+		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK |
+		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN);
+	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT);
+	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_16 ||
+	    cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_8)
+		val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN;
+	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_16)
+		val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16;
+	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_8)
+		val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_8_4;
+
 	tegra30_apbif_write(reg, val);
 
 	cif_conf->direction = TEGRA30_AUDIOCIF_DIRECTION_RX;
@@ -203,10 +210,16 @@ int tegra30_ahub_setup_tx_fifo(enum tegra30_ahub_txcif txcif,
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
 	val &= ~(TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_MASK |
-		 TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_MASK);
-	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_SHIFT) |
-	       TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_EN |
-	       TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_16;
+		 TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_MASK |
+		 TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_EN);
+	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_SHIFT);
+	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_16 ||
+	    cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_8)
+		val |= TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_EN;
+	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_16)
+		val |= TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_16;
+	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_8)
+		val |= TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_8_4;
 	tegra30_apbif_write(reg, val);
 
 	cif_conf->direction = TEGRA30_AUDIOCIF_DIRECTION_TX;
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
