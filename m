Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD69C54EEB
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6A4208E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AzEy/Owe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6A4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87B6C950;
	Tue, 24 Mar 2020 10:10:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87B6C950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585041092;
	bh=Qn845Yl6tTZk1kz7s+fGTqMh6JS6MnZxcGBAy8fC3Yw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AzEy/Owe2qlbftknkwmkioEbk+tWW7MNrMrUsokbEduseK4Z+KlDnGgAh+DCxoP8H
	 KcEnYOQECWTSdMHQCS19EZLYtQo4AD7DlQE1QVi6rnsT4IBqdkgrYMhVWrxj2k0urx
	 cDo2VCKw0L0zXiH9NJPtePk8m8kTm8J4IYXY9QnU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2995F801F8;
	Tue, 24 Mar 2020 10:10:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44B0BF800B9; Tue, 24 Mar 2020 10:10:40 +0100 (CET)
Received: from pecan2.exetel.com.au (pecan2-mail.exetel.com.au [220.233.0.71])
 by alsa1.perex.cz (Postfix) with ESMTP id 6A062F800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 10:10:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A062F800B9
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41]
 helo=localhost.localdomain)
 by pecan2.exetel.com.au with esmtp (Exim 4.91)
 (envelope-from <flatmax@flatmax.org>)
 id 1jGfZc-0000Zd-ME; Tue, 24 Mar 2020 20:10:12 +1100
From: Matt Flax <flatmax@flatmax.org>
To: 
Subject: [PATCH] ASoC: bcm2835-i2s: substream alignment now independent in
 hwparams
Date: Tue, 24 Mar 2020 20:08:21 +1100
Message-Id: <20200324090823.20754-1-flatmax@flatmax.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
 Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
 Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
 YueHaibing <yuehaibing@huawei.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Allison Randal <allison@lohutok.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Matt Flax <flatmax@flatmax.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-rpi-kernel@lists.infradead.org
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

Substream sample alignment was being set in hwparams for both
substreams at the same time. This became a problem when	the Audio
Injector isolated sound card needed to offset sample alignment
for high sample	rates. The latency difference between playback
and capture occurs because of the digital isolation chip
propagation time, particularly when the codec is master and
the DAC return is twice delayed.

This patch sets sample alignment registers  based on the substream
direction in hwparams. This gives the machine driver more control
over sample alignment in the bcm2835 i2s driver.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index e6a12e271b07..9db542699a13 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -493,11 +493,6 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	bcm2835_i2s_calc_channel_pos(&rx_ch1_pos, &rx_ch2_pos,
-		rx_mask, slot_width, data_delay, odd_slot_offset);
-	bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
-		tx_mask, slot_width, data_delay, odd_slot_offset);
-
 	/*
 	 * Transmitting data immediately after frame start, eg
 	 * in left-justified or DSP mode A, only works stable
@@ -508,19 +503,26 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 			"Unstable slave config detected, L/R may be swapped");
 
 	/*
-	 * Set format for both streams.
-	 * We cannot set another frame length
-	 * (and therefore word length) anyway,
-	 * so the format will be the same.
+	 * Set format on a per stream basis.
+	 * The alignment format can be different depending on direction.
 	 */
-	regmap_write(dev->i2s_regmap, BCM2835_I2S_RXC_A_REG, 
-		  format
-		| BCM2835_I2S_CH1_POS(rx_ch1_pos)
-		| BCM2835_I2S_CH2_POS(rx_ch2_pos));
-	regmap_write(dev->i2s_regmap, BCM2835_I2S_TXC_A_REG, 
-		  format
-		| BCM2835_I2S_CH1_POS(tx_ch1_pos)
-		| BCM2835_I2S_CH2_POS(tx_ch2_pos));
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		bcm2835_i2s_calc_channel_pos(&rx_ch1_pos, &rx_ch2_pos,
+			rx_mask, slot_width, data_delay, odd_slot_offset);
+		regmap_write(dev->i2s_regmap, BCM2835_I2S_RXC_A_REG,
+			  format
+			| BCM2835_I2S_CH1_POS(rx_ch1_pos)
+			| BCM2835_I2S_CH2_POS(rx_ch2_pos));
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
+			tx_mask, slot_width, data_delay, odd_slot_offset);
+		regmap_write(dev->i2s_regmap, BCM2835_I2S_TXC_A_REG,
+			  format
+			| BCM2835_I2S_CH1_POS(tx_ch1_pos)
+			| BCM2835_I2S_CH2_POS(tx_ch2_pos));
+	}
 
 	/* Setup the I2S mode */
 
-- 
2.20.1

