Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF898C4725D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jan 2024 11:28:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2746F823;
	Fri, 19 Jan 2024 12:28:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2746F823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705663729;
	bh=HuYa0Hs5Af/qVxD25qBo9TBTPaafJMPziE92BqysBBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hJXLD1jd4fiRQvMkLREt2jAQJCTalQ0ogyowbu2B9oujCJidgpaQtaTgkO3zj065U
	 rOZ037WkEkv+OM/BXHi3KOJtE07jwSI/Q+ixlVduENIJpN/aJk7vpgsBBOX04MXsh+
	 IX/pziP5NK2I75GdewQkHh7/9xXbcXm8ZQV7GoKk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 902FFF80637; Fri, 19 Jan 2024 12:27:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2D6DF80635;
	Fri, 19 Jan 2024 12:27:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A061F805CA; Fri, 19 Jan 2024 12:27:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5ECDF801F5
	for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2024 12:26:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5ECDF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O3nxEPkA
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BE1CD61902;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28949C433B2;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705663615;
	bh=HuYa0Hs5Af/qVxD25qBo9TBTPaafJMPziE92BqysBBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3nxEPkA96L2O/NWjrzucPoxwhvHKV8dJJ77SyUattgWnQJGmC0BZiknQDuLdin16
	 KzErDIsOJoMpmCI3lijwVL7Z5dHTJ0VfyjQjAtw43CX99KQYMvPUbEnSZQGJRiqMph
	 Jvi0C3orFIfEwnwF8lpyUVk6acPb5cgoqfA1vigp6dL8eyXLorQ07wpci4/DJqCG7w
	 vOZHcaKJqymR/pCEVqA5i6iancpP6k7+id8e+i4CkvbHFRgn/ltm9c3nIo8yuPZ3Rp
	 xfus0YgQjQfSKZ1KO5JP4S3hcUH7fAH4BtnfKjXc/jr8HrmJH17fAbRqjL7AQqUVg3
	 xxXOCKdrk3U7g==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQn1b-0001xL-2w;
	Fri, 19 Jan 2024 12:27:03 +0100
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Date: Fri, 19 Jan 2024 12:24:18 +0100
Message-ID: <20240119112420.7446-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119112420.7446-1-johan+linaro@kernel.org>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3HJOEHK36GZZLVTBAAG2ILB2XO7AGYYZ
X-Message-ID-Hash: 3HJOEHK36GZZLVTBAAG2ILB2XO7AGYYZ
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3HJOEHK36GZZLVTBAAG2ILB2XO7AGYYZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The UCM configuration for the Lenovo ThinkPad X13s has up until now
been setting the speaker PA volume to the minimum -3 dB when enabling
the speakers, but this does not prevent the user from increasing the
volume further.

Limit the digital gain and PA volumes to a combined -3 dB in the machine
driver to reduce the risk of speaker damage until we have active speaker
protection in place (or higher safe levels have been established).

Note that the PA volume limit cannot be set lower than 0 dB or
PulseAudio gets confused when the first 16 levels all map to -3 dB.

Also note that this will probably need to be generalised using
machine-specific limits, but a common limit should do for now.

Cc: stable@vger.kernel.org	# 6.5
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/sc8280xp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index ed4bb551bfbb..b7fd503a1666 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-		 * set limit of 0dB on Digital Volume for Speakers,
-		 * this can prevent damage of speakers to some extent without
-		 * active speaker protection
+		 * Set limit of -3 dB on Digital Volume and 0 dB on PA Volume
+		 * to reduce the risk of speaker damage until we have active
+		 * speaker protection in place.
 		 */
-		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
-		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 81);
+		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 81);
+		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 17);
+		snd_soc_limit_volume(card, "SpkrRight PA Volume", 17);
 		break;
 	default:
 		break;
-- 
2.41.0

