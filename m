Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A64C54E58
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:07:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05E2238A;
	Wed, 13 Mar 2024 12:07:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05E2238A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710328075;
	bh=8bxWkdHWjuivwKz8TBybuK02NLszyCe4cZF3c/Vh6Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lwNV5SX7ztA0VvLFAvE3fS080D8roYzrk+YbmT3Hm0WiO7nhVFNTXejenuOLKfoKj
	 itGPMJ8Xn9o9eV8eJp+wB4f7gTkInvt3WbnHTbdog1tFAFjjFsxXWFJwqY855G0rJV
	 s25jBMjbRH1Nv+7iASayaSdcQSMXn67k2A4yUGeo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 166EAF80C17; Wed, 13 Mar 2024 12:04:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84A9BF80C6E;
	Wed, 13 Mar 2024 12:04:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56EC6F80640; Wed, 13 Mar 2024 12:03:58 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 74640F80571
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2024 12:02:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74640F80571
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=kLXjuJS+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710327770;
	bh=8bxWkdHWjuivwKz8TBybuK02NLszyCe4cZF3c/Vh6Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLXjuJS+h4P48NJgsFH/aN0xzQA9soLMlzqYcbHcL1vT9XBh30RFh79Rr2TC3hedD
	 B7OI3kn/HhOTeCKT8NtAI9xFfwnRUc5JAoV8Rk3YXZ7JjxOKeCuiSeGtT1ybQncOuq
	 RVhJulrkCCGHSnDXBDR4U8zfJIvw5bs0nS07gwM6AWJ5sNu26tM2FmF6ryClKIbGuJ
	 CLmBl5kz/jLII3xqkt5KIJJua4UQk5aT/jWMtfpvwT0JGl2u632Jl9QAu35nriX/5J
	 Ch2XBe3OGtReRIe19CmDZtG1GURCFKGOhBsRvN59a4qdK+mAslzp3odKl6GVNLwqWQ
	 7teTUM4FYF2rg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com
 [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D37DB37820D0;
	Wed, 13 Mar 2024 11:02:47 +0000 (UTC)
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
Subject: [PATCH v3 22/22] arm64: dts: mediatek: mt8186-corsola: Specify sound
 DAI links and routing
Date: Wed, 13 Mar 2024 12:01:47 +0100
Message-ID: 
 <20240313110147.1267793-23-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: 
 <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: O32TL6BC2YAZIJFDTGRRDDOE5AA3WA7K
X-Message-ID-Hash: O32TL6BC2YAZIJFDTGRRDDOE5AA3WA7K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O32TL6BC2YAZIJFDTGRRDDOE5AA3WA7K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The drivers and bindings acquired support for specifying audio hardware
and links in device tree: describe and link the sound related HW of this
machine.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8186-corsola.dtsi     | 42 ++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 3dea28f1d806..0bdb83c3e560 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -42,7 +42,7 @@ backlight_lcd0: backlight-lcd0 {
 		default-brightness-level = <576>;
 	};
 
-	bt-sco-codec {
+	bt-sco {
 		compatible = "linux,bt-sco";
 		#sound-dai-cells = <0>;
 	};
@@ -223,12 +223,44 @@ sound: sound {
 		mediatek,adsp = <&adsp>;
 		mediatek,platform = <&afe>;
 
-		playback-codecs {
-			sound-dai = <&it6505dptx>, <&rt1019p>;
+		audio-routing =
+			"Headphone", "HPOL",
+			"Headphone", "HPOR",
+			"IN1P", "Headset Mic",
+			"Speakers", "Speaker",
+			"HDMI1", "TX";
+
+		hs-playback-dai-link {
+			link-name = "I2S0";
+			dai-format = "i2s";
+			mediatek,clk-provider = "cpu";
+			codec {
+				sound-dai = <&rt5682s 0>;
+			};
+		};
+
+		hs-capture-dai-link {
+			link-name = "I2S1";
+			dai-format = "i2s";
+			mediatek,clk-provider = "cpu";
+			codec {
+				sound-dai = <&rt5682s 0>;
+			};
 		};
 
-		headset-codec {
-			sound-dai = <&rt5682s 0>;
+		spk-share-dai-link {
+			link-name = "I2S2";
+			mediatek,clk-provider = "cpu";
+		};
+
+		spk-hdmi-playback-dai-link {
+			link-name = "I2S3";
+			dai-format = "i2s";
+			mediatek,clk-provider = "cpu";
+			/* RT1019P and IT6505 connected to the same I2S line */
+			codec {
+				sound-dai = <&it6505dptx>, <&rt1019p>;
+			};
 		};
 	};
 
-- 
2.44.0

