Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902DEC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  4 May 2022 17:13:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB7FB16BF;
	Wed,  4 May 2022 19:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB7FB16BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651684421;
	bh=uWgz+Nf4sT9bNwvyZbaSG92wt9k7LZRy+e75yhCczD8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mhtf3KxkXjBkEcokYS/i08Y0CPRrQl36CoKU5Kuzbrtd+uEN/jbhJXPB1eorU0rGQ
	 OwPgXRCdcGMJgxd6VB+LiFPkWUmsfKK9jLFO4f960JIAd9rmRBC5z7Qyxcxxsjtib6
	 QkhWjiRxYteKnNzPsScToSsHj48/9hh0oXYpBR3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A065CF80579;
	Wed,  4 May 2022 19:09:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F3AAF8055A; Wed,  4 May 2022 19:09:32 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B98EF80527
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2022 19:09:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B98EF80527
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Gs6ESePv"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446CVqA001835;
 Wed, 4 May 2022 12:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VFo8adY/EVpBB1c192su7l3O3wRUxdtXdARZJ7Jzf5M=;
 b=Gs6ESePvbKigjGYu1CEs2Y70PNeZ6jdAz3MAzP73FmKCjruf47CEGR8huvbnG+AKzCpU
 r8/9y0sjVskraEmWbQHzlsZUI4w97cDg0BChd8MsVIBcmdwLdSbLBurvLvF3DRyfum0n
 EuzbjsE8M7KTNjuXywiGkwmEm2EgfZLZ9qVj8O5mkW6hhidHBEXvL5Xg1rUFXGCckny6
 Uz2W4ol6DkBd0MBZirBY83bstG/PQ5ntRd4ibccasv/7ocbjvgEKAxCAJuDp+cw6+1su
 fqO+qzn/8IilRvrbdosLyaEHqCGD8p4qakOC07WDpoTRrp6ItYWR4Ifg9WqY2jQE3UB6 9g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fs2h2d8fp-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 04 May 2022 12:09:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 18:09:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Wed, 4 May 2022 18:09:06 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EA87BB10;
 Wed,  4 May 2022 17:09:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 13/38] ASoC: cs4234: Add endianness flag in
 snd_soc_component_driver
Date: Wed, 4 May 2022 18:08:40 +0100
Message-ID: <20220504170905.332415-14-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504170905.332415-1-ckeepax@opensource.cirrus.com>
References: <20220504170905.332415-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XiaiGSmHMQ3tJ9-n7cIi8vKiqTSjPJ8H
X-Proofpoint-GUID: XiaiGSmHMQ3tJ9-n7cIi8vKiqTSjPJ8H
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
link. This device receives audio over an I2S DAI and as such should
have endianness applied.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs4234.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4234.c b/sound/soc/codecs/cs4234.c
index b44939166e5d8..881c5ba70c0ed 100644
--- a/sound/soc/codecs/cs4234.c
+++ b/sound/soc/codecs/cs4234.c
@@ -663,6 +663,7 @@ static const struct snd_soc_component_driver soc_component_cs4234 = {
 	.non_legacy_dai_naming	= 1,
 	.idle_bias_on		= 1,
 	.suspend_bias_off	= 1,
+	.endianness		= 1,
 };
 
 static const struct regmap_config cs4234_regmap = {
-- 
2.30.2

