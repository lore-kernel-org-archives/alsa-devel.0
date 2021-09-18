Return-Path: <SRS0=DKfg=OI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C0C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Sep 2021 09:03:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E42A60FED
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Sep 2021 09:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E42A60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EF191755;
	Sat, 18 Sep 2021 11:03:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EF191755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631955831;
	bh=pjj1ypj+FrNnG/MjgiroKjU4ifzH3Tjae9nb7z/kwFU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VvwHa8IwYxfaoAxWPM7UG9pZu7d+bUvNy72FNC4lGpZFDsxeyDB/n35FCSZm90qly
	 esIKt6ajXbvz0sRCVbumRooAlqc4p3VMJheMbPETMoLcisUrpu+kUr0ae8vR+k/qmx
	 /Dy0M8nZZmYEeNn1HEkiI1fX8uc1UzE8MmhzCHrc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B63D1F8025A;
	Sat, 18 Sep 2021 11:03:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EC70F8025E; Sat, 18 Sep 2021 11:02:58 +0200 (CEST)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D772EF80218
 for <alsa-devel@alsa-project.org>; Sat, 18 Sep 2021 11:02:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D772EF80218
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UomJtwg_1631955766; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0UomJtwg_1631955766) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 18 Sep 2021 17:02:49 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: oder_chiou@realtek.com
Subject: [PATCH] ASoC: rt5682s: make rt5682s_aif2_dai_ops and
 rt5682s_soc_component_dev
Date: Sat, 18 Sep 2021 17:02:06 +0800
Message-Id: <1631955726-77693-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 tiwai@suse.com, broonie@kernel.org
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

This symbol is not used outside of rt5682s.c, so marks it static.

Fix the following sparse warning:

sound/soc/codecs/rt5682s.c:2848:39: warning: symbol
'rt5682s_soc_component_dev' was not declared. Should it be static?

sound/soc/codecs/rt5682s.c:2842:30: warning: symbol
'rt5682s_aif2_dai_ops' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/rt5682s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index d878a20..d3e965b 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2839,13 +2839,13 @@ static int rt5682s_resume(struct snd_soc_component *component)
 	.set_bclk_ratio = rt5682s_set_bclk1_ratio,
 };
 
-const struct snd_soc_dai_ops rt5682s_aif2_dai_ops = {
+static const struct snd_soc_dai_ops rt5682s_aif2_dai_ops = {
 	.hw_params = rt5682s_hw_params,
 	.set_fmt = rt5682s_set_dai_fmt,
 	.set_bclk_ratio = rt5682s_set_bclk2_ratio,
 };
 
-const struct snd_soc_component_driver rt5682s_soc_component_dev = {
+static const struct snd_soc_component_driver rt5682s_soc_component_dev = {
 	.probe = rt5682s_probe,
 	.remove = rt5682s_remove,
 	.suspend = rt5682s_suspend,
-- 
1.8.3.1

