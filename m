Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D05C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 16:51:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C35C81678;
	Wed, 23 Nov 2022 17:51:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C35C81678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669222311;
	bh=TznG3yQNcWAdYsK6VaOxn67Hmaf/u/jWHkNSShSXRQA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JUOyv7NekTaA03GFrRiByV7b9YZTGLfF669p+JlNGqnILdjW8E8vCmUMIMV2I7vFt
	 cgq7fUxoM6k4PbtzgVjJBHWSM58nZso+pn944386BfjlPLP4FlFkEE1dK5CZEGVRaS
	 Uz2LuFbd/5e5gGqs9KoMJY/KZWvYBR5AKrR90l9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0E92F80568;
	Wed, 23 Nov 2022 17:49:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7F26F8055C; Wed, 23 Nov 2022 17:49:55 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6FB1F80425
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 17:49:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6FB1F80425
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="NhWwbug2"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2ANFYpmS019647; Wed, 23 Nov 2022 10:49:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=8ZhFyUdVq6CeWWV6a/GOblIgj8JkdpoeczUgMzoz7fo=;
 b=NhWwbug2wRfGdvNNyM0yd2T/fmtfU0QgyV9zcbqdXymdbX/FSRuejxUyMMnxvJ3Ob1Th
 +fePocFkgEMoUfRTLTA3j9hcIzwkIRc77kX9WsmoNmOadtD4chgLgpm8c6pw6LuwPXo9
 xXXH4d4Ep0ztyJlLNGhHLAm/behvxvXhtfvnKIIJYYt8yKnloTSUhq+OnSCkr0n8H0P9
 tzEX4P2sdvVzOJQ7NVLyKBbRvce8oWT8505WPDZ2ycQqRaTpDzZQpW2mWGXyMWAaNOOG
 fKTO5srbinb5ZdwpaPZvDvOaPN2BRbkPxFCiPu07BxOiJvHx0SdV4VFk3/aTeeNr9tI/ kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet55fd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Nov 2022 10:49:40 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 10:49:38 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via
 Frontend Transport; Wed, 23 Nov 2022 10:49:38 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 32D9E477;
 Wed, 23 Nov 2022 16:49:38 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <tiwai@suse.com>, <broonie@kernel.org>
Subject: [PATCH v2 2/9] ASoC: max98373-sdw: Switch to new
 snd_sdw_params_to_config helper
Date: Wed, 23 Nov 2022 16:49:30 +0000
Message-ID: <20221123164937.594837-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123164937.594837-1-ckeepax@opensource.cirrus.com>
References: <20221123164937.594837-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B71c4za-JDwSyCmoPcsGINq24sfJARec
X-Proofpoint-GUID: B71c4za-JDwSyCmoPcsGINq24sfJARec
X-Proofpoint-Spam-Reason: safe
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com
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

The conversion from hw_params to SoundWire config is pretty
standard as such most of the conversation can be handled by the new
snd_sdw_params_to_config helper function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Correct spelling error in commit message

 sound/soc/codecs/max98373-sdw.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 899965b19d12d..3cd1be743d9ee 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/sdw.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/of.h>
@@ -533,10 +534,8 @@ static int max98373_sdw_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct max98373_priv *max98373 =
 		snd_soc_component_get_drvdata(component);
-
-	struct sdw_stream_config stream_config;
-	struct sdw_port_config port_config;
-	enum sdw_data_direction direction;
+	struct sdw_stream_config stream_config = {0};
+	struct sdw_port_config port_config = {0};
 	struct sdw_stream_data *stream;
 	int ret, chan_sz, sampling_rate;
 
@@ -548,28 +547,20 @@ static int max98373_sdw_dai_hw_params(struct snd_pcm_substream *substream,
 	if (!max98373->slave)
 		return -EINVAL;
 
+	snd_sdw_params_to_config(substream, params, &stream_config, &port_config);
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		direction = SDW_DATA_DIR_RX;
 		port_config.num = 1;
+
+		if (max98373->slot) {
+			stream_config.ch_count = max98373->slot;
+			port_config.ch_mask = max98373->rx_mask;
+		}
 	} else {
-		direction = SDW_DATA_DIR_TX;
 		port_config.num = 3;
-	}
 
-	stream_config.frame_rate = params_rate(params);
-	stream_config.bps = snd_pcm_format_width(params_format(params));
-	stream_config.direction = direction;
-
-	if (max98373->slot && direction == SDW_DATA_DIR_RX) {
-		stream_config.ch_count = max98373->slot;
-		port_config.ch_mask = max98373->rx_mask;
-	} else {
 		/* only IV are supported by capture */
-		if (direction == SDW_DATA_DIR_TX)
-			stream_config.ch_count = 2;
-		else
-			stream_config.ch_count = params_channels(params);
-
+		stream_config.ch_count = 2;
 		port_config.ch_mask = GENMASK((int)stream_config.ch_count - 1, 0);
 	}
 
-- 
2.30.2

