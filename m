Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C892CC4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:29:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5240A217D9
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dOxB8rRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5240A217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A1891663;
	Fri, 27 Sep 2019 11:29:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A1891663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569576590;
	bh=OtGlFeO6wFxD1PfNtdlNBJadASmXahlCDq9fz+HMMxs=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOxB8rRS7eLTh7wNhVevuMOLI0h3jePnDUOzbcLLKr9QGvhmSJfqKwyiuV4v8aXXL
	 HSX/znjCrToTWdzp/B8+d9SAdfAgqhSWeUrejAAA4Z3cWN/ng0ocVopo899m2yYy+O
	 lEZG6buGYt45GFnDmrgrHoNb78zRw/Nfuc4bjkAE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39A11F805FB;
	Fri, 27 Sep 2019 11:27:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18AD2F805A8; Fri, 27 Sep 2019 11:27:17 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id A457EF8044C
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 11:27:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A457EF8044C
X-UUID: 0984e73dc6bd49e181af658934f841f7-20190927
X-UUID: 0984e73dc6bd49e181af658934f841f7-20190927
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 585801765; Fri, 27 Sep 2019 17:27:07 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Sep 2019 17:27:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Sep 2019 17:27:03 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
 <linux@roeck-us.net>, <wim@linux-watchdog.org>
Date: Fri, 27 Sep 2019 17:26:57 +0800
Message-ID: <1569576417-20663-5-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1569576417-20663-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1569576417-20663-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0E7DD3929E57BA9D199786983E2A5AA297FE759E5F051ADD3EC10F5F87E8286A2000:8
X-MTK: N
Cc: alsa-devel@alsa-project.org, yong.liang@mediatek.com, lgirdwood@gmail.com,
 jiaxin.yu@mediatek.com, tzungbi@google.com, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 4/4] WIP: ASoC: mt8183: fix audio playback
	slowly after playback during bootup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Before regmap_reinit_cache we must reset audio regs as default values.
So we use reset controller unit(toprgu) to reset audio hw.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 4a31106d3471..721632386a50 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "mt8183-afe-common.h"
 #include "mt8183-afe-clk.h"
@@ -1089,6 +1090,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct mtk_base_afe *afe;
 	struct mt8183_afe_private *afe_priv;
 	struct device *dev;
+	struct reset_control *rstc;
 	int i, irq_id, ret;
 
 	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
@@ -1126,6 +1128,19 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	rstc = devm_reset_control_get(dev, "audiosys");
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		dev_err(dev, "could not get audiosys reset:%d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_reset(rstc);
+	if (ret) {
+		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
+		return ret;
+	}
+
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
 	pm_runtime_get_sync(&pdev->dev);
-- 
2.18.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
