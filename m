Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8239C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Mar 2022 12:04:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4290F1746;
	Sat, 19 Mar 2022 13:03:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4290F1746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647691481;
	bh=uRvIoIj5KN5LVg546OupwUnsbxH0qLm7sTT5ixpGEkk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xqucz4I/NnW3fGYO7Y8jHkFXStRPKCUtMUFlUqV9EyadxMZHqgqlAKX9yo7m2wLmU
	 QOUjpTiV0F/1tmqIRAbewceAEOFYBBFbbV5z/VeDvDBe77/e7X7EbryKZFtsfg9UIl
	 jtC2aCBpbGkQK9OEQAJ9wEWZeX/+xQOSp0i+mXso=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5F57F80054;
	Sat, 19 Mar 2022 13:03:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 402A3F80054; Sat, 19 Mar 2022 13:03:49 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E870F80054
 for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2022 13:03:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E870F80054
X-UUID: ebf6dc5df6f644b495dd8bbf58981c4a-20220319
X-UUID: ebf6dc5df6f644b495dd8bbf58981c4a-20220319
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1670526193; Sat, 19 Mar 2022 20:03:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 19 Mar 2022 20:03:27 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 19 Mar 2022 20:03:26 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs
Date: Sat, 19 Mar 2022 20:03:25 +0800
Message-ID: <20220319120325.11882-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

Fixes the following build errors when mt6358 is configured as module:

>> ERROR: modpost: "mt6358_set_mtkaif_protocol"
>> [sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.ko] undefined!
>> ERROR: modpost: "mt6358_set_mtkaif_protocol"
>> [sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.ko] undefined!

Fixes: 6a8d4198ca80 ("ASoC: mediatek: mt6358: add codec driver")
Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/codecs/mt6358.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 9b263a9a669d..4c7b5d940799 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -107,6 +107,7 @@ int mt6358_set_mtkaif_protocol(struct snd_soc_component *cmpnt,
 	priv->mtkaif_protocol = mtkaif_protocol;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt6358_set_mtkaif_protocol);
 
 static void playback_gpio_set(struct mt6358_priv *priv)
 {
@@ -273,6 +274,7 @@ int mt6358_mtkaif_calibration_enable(struct snd_soc_component *cmpnt)
 			   1 << RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_SFT);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt6358_mtkaif_calibration_enable);
 
 int mt6358_mtkaif_calibration_disable(struct snd_soc_component *cmpnt)
 {
@@ -296,6 +298,7 @@ int mt6358_mtkaif_calibration_disable(struct snd_soc_component *cmpnt)
 	capture_gpio_reset(priv);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt6358_mtkaif_calibration_disable);
 
 int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component *cmpnt,
 					int phase_1, int phase_2)
@@ -310,6 +313,7 @@ int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component *cmpnt,
 			   phase_2 << RG_AUD_PAD_TOP_PHASE_MODE2_SFT);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt6358_set_mtkaif_calibration_phase);
 
 /* dl pga gain */
 enum {
-- 
2.25.1

