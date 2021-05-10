Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23247C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 08:38:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46E461430
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 08:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46E461430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2778716A2;
	Mon, 10 May 2021 10:37:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2778716A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620635887;
	bh=4RvwikoybotXXnb1ALHazgSqX4Iol7O1kaeMPpZQymY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h+WkZniTljhrRwV18KEje5QdxpKaVKoTk6IgJ2J+SAdnp59AWkUyUUSPY0RtDq3Re
	 d2TTkomF6is+TFZ1983L3mgsmchwbWYvLxdwgymgFHINs/GuEOglMOm5g/ReGaDohH
	 LE0cf0cRrRT3djsSe2U2NK4qY//Ixic8j7BkRuts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8508DF8020C;
	Mon, 10 May 2021 10:37:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB4FFF80240; Mon, 10 May 2021 10:37:14 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0913F800E9
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 10:37:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0913F800E9
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FdvVQ5ryjzCr7S;
 Mon, 10 May 2021 16:34:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 16:36:54 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] ASoC: mediatek: mt8192: Delete a redundant condition
 branch
Date: Mon, 10 May 2021 16:36:40 +0800
Message-ID: <20210510083640.3368-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Cc: Zhen Lei <thunder.leizhen@huawei.com>
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

The statement of the "if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)"
branch is the same as the "else" branch. Delete it to simplify code.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
index f040dce85da537b..f8c73e8624df20b 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
@@ -413,8 +413,6 @@ static int mtk_adda_pad_top_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
 			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x38);
-		else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
-			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x30);
 		else
 			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x30);
 		break;
-- 
2.26.0.106.g9fadedd


