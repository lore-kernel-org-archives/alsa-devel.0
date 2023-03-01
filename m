Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C708C64ED6
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Mar 2023 11:40:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CEB582A;
	Wed,  1 Mar 2023 12:39:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CEB582A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677670830;
	bh=kN9zmelvhJBgNAO5EUo3ZIXHZ2yIk12eJ4vuPHyz4Js=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W7GTSkAX8b1+0fixtF6OGdxNaKydZdf4yN/DjoQtYZtnJOFrmKi4hQ+Pc0kZnHx+E
	 si/DWYRHHZ3WsT8+rC5/TGLB99+Bxs5MELc35cPrY5aVpf/QNY/rlYqP78IPCNF8W6
	 vZYvYJB10Q9IqKltMCrBbdLnY40ViBj/RUsh6bxs=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFC4CF80533;
	Wed,  1 Mar 2023 12:38:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1E3CF80534; Wed,  1 Mar 2023 12:38:48 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D222DF800BA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2023 12:38:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D222DF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=OWLmBR1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670726; x=1709206726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kN9zmelvhJBgNAO5EUo3ZIXHZ2yIk12eJ4vuPHyz4Js=;
  b=OWLmBR1jrfrTwrqtNJAsx/MzAr2wyGRl0+MD8ml7jtDwy5pxn486HHlD
   YGQtJ9bG+R1faMmGfz56u6ZywZ8pg8YFVqCzNHmydTVMYgZcVB5s3skAz
   6Bs/u9IT4+4ug7zZfxf/6Ga2clzazoqOs7tW2luVx9qFPhASEHmZdESgo
   Cyhko1F6LNrotVkY2AHO1x5KZNl12rj1dS5lwumdoMfFzI2n7QapSRS0K
   j6iQMa6pop/bLCC9hNdOPuvvOXTs+C3KZ6GTqCt8pGpLQ7e3/tKIxZWQ4
   8wor05TArXl9Ia40rmVewF2L1mAxCAiZKhHkmqp7oCwaxbkf9xa+cb/cx
   A==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800";
   d="scan'208";a="202995009"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 01 Mar 2023 04:38:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:27 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
Subject: [PATCH 1/8] ASoC: mchp-spdiftx: use FIELD_PREP() where possible
Date: Wed, 1 Mar 2023 13:38:00 +0200
Message-ID: <20230301113807.24036-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301113807.24036-1-claudiu.beznea@microchip.com>
References: <20230301113807.24036-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: MXL66HFJNQYL7CEG6BQOHEOSDN3EHAJS
X-Message-ID-Hash: MXL66HFJNQYL7CEG6BQOHEOSDN3EHAJS
X-MailFrom: Claudiu.Beznea@microchip.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MXL66HFJNQYL7CEG6BQOHEOSDN3EHAJS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use directly FIELD_PREP() marco where possible. There is no need for
the extra wrappers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 20d135c718b0..bf4252412f9f 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -72,11 +72,9 @@
 
 /* Valid Bits per Sample */
 #define SPDIFTX_MR_VBPS_MASK		GENMASK(13, 8)
-#define SPDIFTX_MR_VBPS(bps)		FIELD_PREP(SPDIFTX_MR_VBPS_MASK, bps)
 
 /* Chunk Size */
 #define SPDIFTX_MR_CHUNK_MASK		GENMASK(19, 16)
-#define SPDIFTX_MR_CHUNK(size)		FIELD_PREP(SPDIFTX_MR_CHUNK_MASK, size)
 
 /* Validity Bits for Channels 1 and 2 */
 #define SPDIFTX_MR_VALID1			BIT(24)
@@ -89,7 +87,6 @@
 
 /* Bytes per Sample */
 #define SPDIFTX_MR_BPS_MASK		GENMASK(29, 28)
-#define SPDIFTX_MR_BPS(bytes)		FIELD_PREP(SPDIFTX_MR_BPS_MASK, (bytes - 1))
 
 /*
  * ---- Interrupt Enable/Disable/Mask/Status Register (Write/Read-only) ----
@@ -402,47 +399,47 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 			params_channels(params));
 		return -EINVAL;
 	}
-	mr |= SPDIFTX_MR_CHUNK(dev->playback.maxburst);
+	mr |= FIELD_PREP(SPDIFTX_MR_CHUNK_MASK, dev->playback.maxburst);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		mr |= SPDIFTX_MR_VBPS(8);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 8);
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		mr |= SPDIFTX_MR_VBPS(16);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 16);
 		break;
 	case SNDRV_PCM_FORMAT_S18_3BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S18_3LE:
-		mr |= SPDIFTX_MR_VBPS(18);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 18);
 		break;
 	case SNDRV_PCM_FORMAT_S20_3BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S20_3LE:
-		mr |= SPDIFTX_MR_VBPS(20);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 20);
 		break;
 	case SNDRV_PCM_FORMAT_S24_3BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S24_3LE:
-		mr |= SPDIFTX_MR_VBPS(24);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 24);
 		break;
 	case SNDRV_PCM_FORMAT_S24_BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		mr |= SPDIFTX_MR_VBPS(24);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 24);
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		mr |= SPDIFTX_MR_VBPS(32);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 32);
 		break;
 	default:
 		dev_err(dev->dev, "unsupported PCM format: %d\n",
@@ -450,7 +447,7 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	mr |= SPDIFTX_MR_BPS(bps);
+	mr |= FIELD_PREP(SPDIFTX_MR_BPS_MASK, bps - 1);
 
 	switch (params_rate(params)) {
 	case 22050:
-- 
2.34.1

