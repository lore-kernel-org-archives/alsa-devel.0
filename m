Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E1BC54E49
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:46:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F065AB70;
	Thu,  7 Mar 2024 12:46:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F065AB70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709812014;
	bh=/pS8nnncjy2TDDWZ2CUchnxDIc/k7Kdx/uqwdwe7Xs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W2FZRCogFM7aXCK1oEobirkJcfbr9//U/UbUQGJ5jguBavBBd80ia7wyufh3y/0mI
	 nP2G4M5u5GeZ3SCY38tywMb3jUQzheAXdk3Jitm1F9TvaYp94KIjRZUZ+uLr/A4MSV
	 99tRkCQUGPetQ9OZJuV5BSh3uUfofD3PBZDvjTBY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28E3FF80654; Thu,  7 Mar 2024 12:45:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19963F80634;
	Thu,  7 Mar 2024 12:45:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3A5AF802E8; Thu,  7 Mar 2024 12:45:16 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3E27F802E8
	for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2024 12:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3E27F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=SFka2ONl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709811902;
	bh=/pS8nnncjy2TDDWZ2CUchnxDIc/k7Kdx/uqwdwe7Xs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFka2ONl+IW1KD+u2U5you9zacfumzJ0PTggp7r10/VXjdt/m6dS9N6ShYk6Nyh55
	 M1lQcQwPyAswbBsyhozWMpKjf0OQ+0F5YUR2TXgdJGkuqxgivzxXxN8rXojVhTV8Vc
	 bew0iaiL5+jBDdbDdNoXDVwkp08EQBSqmSC3VVQBN3dDpTFmopQtB0pKvC814O8pEr
	 1DtWA+9cdNU6B5wyEC8RT+tBlXXcHK1vB0qQ0G+OyCyJn9NCyNrwBaAFdI7Le5Bj//
	 9/MTe/uk1uYMSZ7BqyprEHrk2Lq7m0dggzVB/qd/2wZqzjUzn2uDjiNJN0kOWMlEsD
	 7ZJGp3+p6kosQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com
 [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7279C37820ED;
	Thu,  7 Mar 2024 11:45:00 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 04/22] ASoC: mediatek: Assign dummy when codec not
 specified for a DAI link
Date: Thu,  7 Mar 2024 12:44:27 +0100
Message-ID: <20240307114445.196981-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BJ4S4FJG7UNDJMEQAVBEOJK6GIFQLEPZ
X-Message-ID-Hash: BJ4S4FJG7UNDJMEQAVBEOJK6GIFQLEPZ
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BJ4S4FJG7UNDJMEQAVBEOJK6GIFQLEPZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

MediaTek sound card drivers are checking whether a DAI link is present
and used on a board to assign the correct parameters and this is done
by checking the codec DAI names at probe time.

If no real codec is present, assign the dummy codec to the DAI link
to avoid NULL pointer during string comparison.

Fixes: 4302187d955f ("ASoC: mediatek: common: add soundcard driver common code")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/common/mtk-soundcard-driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index a58e1e3674de..000a086a8cf4 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -22,7 +22,11 @@ static int set_card_codec_info(struct snd_soc_card *card,
 
 	codec_node = of_get_child_by_name(sub_node, "codec");
 	if (!codec_node) {
-		dev_dbg(dev, "%s no specified codec\n", dai_link->name);
+		dev_dbg(dev, "%s no specified codec: setting dummy.\n", dai_link->name);
+
+		dai_link->codecs = &snd_soc_dummy_dlc;
+		dai_link->num_codecs = 1;
+		dai_link->dynamic = 1;
 		return 0;
 	}
 
-- 
2.44.0

