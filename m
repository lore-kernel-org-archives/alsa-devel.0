Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A3DC432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 07:15:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F9161008
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 07:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42F9161008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF4A8178D;
	Thu,  2 Sep 2021 09:15:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF4A8178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630566954;
	bh=NZZ0B/IRhtS7oKfWdapc8QnIa18r/p+1MGabcW4sAdw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=St9ST7Ahr2Cc/WX/l7nZpywWa4q36PPKRZy6IZNlbH6+fTv+20SnCoMzRWgJTIqBX
	 XVE9SC6h/oYJySRtbDiEdf26BPkCG2Rz37u9xpXkrSwbySVDXpRDT41hhtWW3xUkXZ
	 CVifuNVYQinrv4cXWiQmrxELjIASHdQuBHRb+3FA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 629B0F80125;
	Thu,  2 Sep 2021 09:15:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 774D4F80269; Thu,  2 Sep 2021 09:15:01 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7CF9F8020D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 09:14:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7CF9F8020D
X-UUID: 59fcbcd1a388466bab211785bc791fb5-20210902
X-UUID: 59fcbcd1a388466bab211785bc791fb5-20210902
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1633932517; Thu, 02 Sep 2021 15:14:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 15:14:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 2 Sep 2021 15:14:41 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
Subject: [PATCH] ASoC: mt8195: remove unnecessary CONFIG_PM
Date: Thu, 2 Sep 2021 15:14:40 +0800
Message-ID: <20210902071440.6087-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

The unnecessary conditional inclusion caused the following warning.

>> sound/soc/mediatek/mt8195/mt8195-afe-pcm.c:3260:32: warning: unused
>> variable 'mt8195_afe_pm_ops' [-Wunused-const-variable]
   static const struct dev_pm_ops mt8195_afe_pm_ops = {
                                  ^
   1 warning generated.

Because runtime_pm already handles the case without CONFIG_PM, we
can remove CONFIG_PM condition.

Fixes: 6746cc858259 ("ASoC: mediatek: mt8195: add platform driver")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 6635c3f72ecc..f8dd50c8a7da 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3266,9 +3266,7 @@ static struct platform_driver mt8195_afe_pcm_driver = {
 	.driver = {
 		   .name = "mt8195-audio",
 		   .of_match_table = mt8195_afe_pcm_dt_match,
-#ifdef CONFIG_PM
 		   .pm = &mt8195_afe_pm_ops,
-#endif
 	},
 	.probe = mt8195_afe_pcm_dev_probe,
 	.remove = mt8195_afe_pcm_dev_remove,
-- 
2.18.0

