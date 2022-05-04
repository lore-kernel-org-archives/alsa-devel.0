Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDB2C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  4 May 2022 17:18:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E436F171D;
	Wed,  4 May 2022 19:18:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E436F171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651684732;
	bh=JTuQ6V0NuE4XioWaNxVlaj4OqrvfH4fTOngIhnFoQZA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=avHVWbDs7TtRSKAk/Df6GajKoqfdFuhFcpNeQqOMaSA6UiNF16hv6ZlcSVj0T09hI
	 2x/8djo7x7Lf5e82gIpzeYhgghwvG6HzpmYIEyzVu5elP4XvxDd6jcVVBIGKiTrALc
	 l+29RI9B1FivhzDmH0WHY4flP/iz7Sjif14VyD/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB1BAF8060B;
	Wed,  4 May 2022 19:10:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CCFAF805FD; Wed,  4 May 2022 19:10:22 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FB8BF805EA
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2022 19:10:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FB8BF805EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="GRQzIO3F"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446CVqL001835;
 Wed, 4 May 2022 12:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=JqSf8VsPjntcp5+sVo9w9XAP7mcs6Ljk8Rzl1377l6Y=;
 b=GRQzIO3FQbqPnzi/Sl6F8ofmjSVwCQtzikrUVdE4BaAhXpZi6ktFjeO+CXXz8a55M8Tq
 a8YaPGXFkMh8ifa12sLEZ4GLPhvBkXbH4X4emCH3OuXSSqUtnG6d/Rpx/9YpuOOEHvKv
 sYVTkmUyVGyH0Es+JE6wW0vm9F4DU0pl9ovBIVCq7iwEbNvCw8zz1RcTji8BOTiL4ex2
 5YSJzypSGU4nwN+TTvfsZ2TX1/u0Wzh19QyfPRzgwFXjB3XNie/tB9BMYxuIsOZa13iT
 l3HZcmXO6NM/MPBpZXF6fbJovQOmg0iY0J+BTURf9ufA0brRVAxLUhjZTgv90Zyqu6vN Qw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fs2h2d8fp-19
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 04 May 2022 12:09:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 18:09:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Wed, 4 May 2022 18:09:07 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1E5E511D3;
 Wed,  4 May 2022 17:09:07 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 33/38] ASoC: rt715-sdca: Add endianness flag in
 snd_soc_component_driver
Date: Wed, 4 May 2022 18:09:00 +0100
Message-ID: <20220504170905.332415-34-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504170905.332415-1-ckeepax@opensource.cirrus.com>
References: <20220504170905.332415-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mznjTn6v-52Iw12vAStACPKiCs_uuPOz
X-Proofpoint-GUID: mznjTn6v-52Iw12vAStACPKiCs_uuPOz
X-Proofpoint-Spam-Reason: safe
Cc: oder_chiou@realtek.com, steven.eckhoff.opensource@gmail.com,
 alexandre.belloni@bootlin.com, lars@metafoo.de,
 kuninori.morimoto.gx@renesas.com, kmarinushkin@birdec.com,
 patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
 lgirdwood@gmail.com, jiaxin.yu@mediatek.com, tzungbi@google.com,
 srinivas.kandagatla@linaro.org, matthias.bgg@gmail.com,
 chrome-platform@lists.linux.dev, codrin.ciubotariu@microchip.com,
 alsa-devel@alsa-project.org, bleung@chromium.org, cychiang@chromium.org
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

The endianness flag is used on the CODEC side to specify an
ambivalence to endian, typically because it is lost over the hardware
link. This device receives audio over a SoundWire DAI and as such
should have endianness applied.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/rt715-sdca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index bfa536bd71960..5857d08663073 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -765,6 +765,7 @@ static const struct snd_soc_component_driver soc_codec_dev_rt715_sdca = {
 	.num_dapm_widgets = ARRAY_SIZE(rt715_sdca_dapm_widgets),
 	.dapm_routes = rt715_sdca_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(rt715_sdca_audio_map),
+	.endianness = 1,
 };
 
 static int rt715_sdca_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
-- 
2.30.2

