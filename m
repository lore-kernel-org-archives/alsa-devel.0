Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC4C4BA09
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 02:29:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0CB24670
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 02:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NvSEhzN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0CB24670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B01C4168B;
	Wed, 26 Feb 2020 03:29:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B01C4168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582684191;
	bh=aHAW0itaNUxlO3+Snbow3qGfGlGS2Lx1x7bHPKuJuv0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NvSEhzN+MiSpcAp7+o2XPtal1k/YJlTMnor/6xTIsBBscV6LDU1rKh4Bn7tyaY3Ar
	 dzFpu7NLr/9SNbHH3BMAZ2rkg9Enb7c/9MbU4lT1mLaZvWeaLffiMiilnv/IMqKwwz
	 wsbIDNotJ23w585yniYjMdbzQE6LpMiRl8jYqVOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E3B5F80143;
	Wed, 26 Feb 2020 03:29:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6FCCF8025E; Wed, 26 Feb 2020 03:28:54 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1832F80143
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 03:28:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1832F80143
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01Q2SblI021086,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01Q2SblI021086
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 10:28:37 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Feb 2020 10:28:36 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 26 Feb
 2020 10:28:36 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt1015: modify some structure to be static and add
 operation callback function for rt1015_dai
Date: Wed, 26 Feb 2020 10:28:27 +0800
Message-ID: <20200226022827.3262-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, lars@metafoo.de, kent_chen@realtek.com,
 kenny_chen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 mingjane_hsieh@realtek.com, flove@realtek.com
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

From: Jack Yu <jack.yu@realtek.com>

1. Add "static" for rt1015_aif_dai_ops.
2. Add "static" for rt1015_dai[].
3. Add operation callback for rt1015_dai[].

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1015.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index d300b417dd50..bb310bc7febd 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -664,7 +664,7 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, RT1015_TDM_MASTER,
 		RT1015_I2S_DL_MASK, val_len);
 	snd_soc_component_update_bits(component, RT1015_CLK2,
-		RT1015_FS_PD_MASK, pre_div);
+		RT1015_FS_PD_MASK, pre_div << RT1015_FS_PD_SFT);
 
 	return 0;
 }
@@ -841,12 +841,12 @@ static void rt1015_remove(struct snd_soc_component *component)
 #define RT1015_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt1015_aif_dai_ops = {
+static struct snd_soc_dai_ops rt1015_aif_dai_ops = {
 	.hw_params = rt1015_hw_params,
 	.set_fmt = rt1015_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver rt1015_dai[] = {
+static struct snd_soc_dai_driver rt1015_dai[] = {
 	{
 		.name = "rt1015-aif",
 		.id = 0,
@@ -857,6 +857,7 @@ struct snd_soc_dai_driver rt1015_dai[] = {
 			.rates = RT1015_STEREO_RATES,
 			.formats = RT1015_FORMATS,
 		},
+		.ops = &rt1015_aif_dai_ops,
 	}
 };
 
-- 
2.25.1

