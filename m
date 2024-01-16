Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE51C4706C
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jan 2024 09:41:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25AA6202;
	Tue, 16 Jan 2024 10:41:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25AA6202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705398093;
	bh=mnsvv8nLXcpID7aeu/iuGLMoF7xZR5DEBr8yX7bAx7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LqdBimi+sCfDvvDEGH7te0vVeEkBFT8eB71ROJuIBpZP2/0s5XJnXH1ndX5LdeqfL
	 aGNAJmJpoulCxZpJCkTqN5R2CQvaMfiSftw3KSokpdfYk+3C1rbbkg8VV5aRNHVekI
	 Oq18GvOtxLm8n0GhhgdblBOP9oAF7jLanzI+yVaQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B2C1F80635; Tue, 16 Jan 2024 10:40:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0961FF8062D;
	Tue, 16 Jan 2024 10:40:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 421C2F805E0; Tue, 16 Jan 2024 10:39:56 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6DCA9F802BE
	for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2024 10:39:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DCA9F802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=srMWK9ab
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B6C1761164;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E34AC43330;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=mnsvv8nLXcpID7aeu/iuGLMoF7xZR5DEBr8yX7bAx7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srMWK9ab1BIYiHFwgI2B2+w1VwIwAs5MRYycieUR/UqX2/NlVT1DqOvkuvQZFwuI2
	 1NZ2CkD1LX+bjLz1x75526r3oggFIXzPzVbwpcvY8bkZ0enYTmIiSJkDxokVwWjG96
	 U8HrIVW/M0I9DB0vq0SxvTqBaZlewFzpm4DPwn9aF4cZIbXdETXpbmRThEmHC30v9M
	 ShVnMrj0oKVqRsfmLodGn59RPmz1aySjA3HTv9m5vGaUYvA9juNQGy+SiIkvVfMiUn
	 kfR3DcAi1pqcnjGTyglSKBEL70kFgKP0vqpqlwVChEWtub2LLiFsNMzCWuTg8UmEEI
	 yt2hpY6514q5Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053V-18;
	Tue, 16 Jan 2024 10:39:44 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/7] ASoC: codecs: lpass-wsa-macro: drop dead mixer-path gain
 hack
Date: Tue, 16 Jan 2024 10:38:59 +0100
Message-ID: <20240116093903.19403-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240116093903.19403-1-johan+linaro@kernel.org>
References: <20240116093903.19403-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KNS2TT67ESLFRZOI5U4DRJWZQZTQQQRR
X-Message-ID-Hash: KNS2TT67ESLFRZOI5U4DRJWZQZTQQQRR
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The vendor driver modifies the gain settings behind the back of user
space but some of these hacks never made it upstream except for some
essentially dead code that reads out the (cached) gain setting and
writes it back again on DAPM events.

Drop the incomplete and pointless hack when enabling mixer paths.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 7de221464d47..36a8f1980c6e 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1220,27 +1220,20 @@ static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
 				     struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	u16 path_reg, gain_reg;
-	int val;
+	u16 path_reg;
 
 	switch (w->shift) {
 	case WSA_MACRO_RX_MIX0:
 		path_reg = CDC_WSA_RX0_RX_PATH_MIX_CTL;
-		gain_reg = CDC_WSA_RX0_RX_VOL_MIX_CTL;
 		break;
 	case WSA_MACRO_RX_MIX1:
 		path_reg = CDC_WSA_RX1_RX_PATH_MIX_CTL;
-		gain_reg = CDC_WSA_RX1_RX_VOL_MIX_CTL;
 		break;
 	default:
 		return 0;
 	}
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		val = snd_soc_component_read(component, gain_reg);
-		snd_soc_component_write(component, gain_reg, val);
-		break;
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_component_update_bits(component, path_reg,
 					      CDC_WSA_RX_PATH_MIX_CLK_EN_MASK,
-- 
2.41.0

