Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E5C54EE9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 00:02:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02FF2857;
	Fri, 23 Sep 2022 02:01:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02FF2857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663891326;
	bh=/6IQ3lHwKEL60Rke+bM3N44arsfrjzRsLk9Ih45RYHU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bY7FUnz5nH58DrtlYo5LMQ47nqoKXy+GDn/Y8H6RLZsUBkz4+Iwa1Mv4U7ANMI9nY
	 RZvUEtmgG+wpWgvLjSTLpCOECFesfd+hCQ0KxiVliobK+rF82WyMGORTQ5EnXX9/OA
	 1Cum8rmOtc+zNVTZoS9s2POf2UTuRvRL5jFafqe4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F250EF80549;
	Fri, 23 Sep 2022 02:00:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DFBAF80543; Fri, 23 Sep 2022 02:00:12 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 797FBF804E7
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2022 02:00:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 797FBF804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="Z97+6eZU"
Received: from notapiano.myfiosgateway.com (unknown [71.190.76.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 183BE6602237;
 Fri, 23 Sep 2022 01:00:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1663891203;
 bh=/6IQ3lHwKEL60Rke+bM3N44arsfrjzRsLk9Ih45RYHU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z97+6eZUDhyTF8wOugnqu9/fwFiMAAjbjL1nrdS6wzEodSgubZyuwkD7ui4mSJQgu
 J2GN7Ww7qOAztzf1Zsk/RgYeI6rLvvwTC2MWJVD6RIKyjiXw6R0Oxva5S1CmBw62/u
 8uwt4znb2ftflJRn0zUYHjgLigjPlcDHtt4fwLQjpBfQ5+k6mZ6Lo02o/JS9zQPeCF
 w0nnrGBJ/xUGUr/OwLuyWLNFgk3WxNTu9G7vcSD85anyAnTX+Z+/BIxZkATVMgubaV
 rEXg61vZYCCpLJMOR113J7RrTeLMiiCuoZrkuKn46ABsnlviaXesAJcZHhSD9MCtY3
 LqXL0gbRoD8gg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/6] ASoC: mediatek: mt8186-da7219: Add headset widgets with
 switches
Date: Thu, 22 Sep 2022 19:59:48 -0400
Message-Id: <20220922235951.252532-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922235951.252532-1-nfraprado@collabora.com>
References: <20220922235951.252532-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, "chunxu.li" <chunxu.li@mediatek.com>,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Add DAPM widgets for headphones and headset microphone, with matching
switches, to allow toggling these paths based on the jack connection
status.

Note that differently from others (mt8192, mt8195 and mt8186-rt5682),
the widget here is named "Headphones" (with an 's'), since "Headphone
Switch" was already registered by da7219.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index 6f93f9dd4623..8d428bc4a3b2 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -950,6 +950,8 @@ static struct snd_soc_dai_link mt8186_mt6366_da7219_max98357_dai_links[] = {
 static const struct snd_soc_dapm_widget
 mt8186_mt6366_da7219_max98357_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_OUTPUT("HDMI1"),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL1, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -961,6 +963,10 @@ static const struct snd_soc_dapm_route
 mt8186_mt6366_da7219_max98357_routes[] = {
 	/* SPK */
 	{ "Speakers", NULL, "Speaker"},
+	/* Headset */
+	{ "Headphones", NULL, "HPL" },
+	{ "Headphones", NULL, "HPR" },
+	{ "MIC", NULL, "Headset Mic" },
 	/* HDMI */
 	{ "HDMI1", NULL, "TX"},
 	/* SOF Uplink */
@@ -976,6 +982,8 @@ mt8186_mt6366_da7219_max98357_routes[] = {
 static const struct snd_kcontrol_new
 mt8186_mt6366_da7219_max98357_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Headphones"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("HDMI1"),
 };
 
-- 
2.37.3

