Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6619EC001DE
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jul 2023 06:53:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6ED511E7;
	Thu, 13 Jul 2023 08:52:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6ED511E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689231178;
	bh=oXTQKrjnKyAiCiHKcZPUeCenPV+bHQ1qqv8IgFEF4jc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AhrcuU3L/HmamdyCOmGgg8/JA6/U2VXVu853maWQtmXAZTQ4qyld/c6AAr6Lw8McF
	 FaK6NThGrnzr5EbNV4mMtNQ4DixuRZZ8mW08Wb3b+Car85uKe9G1BRjte4G+nQYEpV
	 Xhzd2KqqI1wbBvICNW3N4RYquiqUFeCgcRBDkiAc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD15AF8047D; Thu, 13 Jul 2023 08:51:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 801A2F80249;
	Thu, 13 Jul 2023 08:51:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97BD0F80249; Thu, 13 Jul 2023 08:51:35 +0200 (CEST)
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D8C9F80093
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 08:51:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D8C9F80093
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VnG-eHR_1689231067;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VnG-eHR_1689231067)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 14:51:08 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: amd: acp: clean up some inconsistent indentings
Date: Thu, 13 Jul 2023 14:51:06 +0800
Message-Id: <20230713065106.21564-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4RROJMLTVO2BEEZCBD4AF6V6UWILS5KJ
X-Message-ID-Hash: 4RROJMLTVO2BEEZCBD4AF6V6UWILS5KJ
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RROJMLTVO2BEEZCBD4AF6V6UWILS5KJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

sound/soc/amd/acp/acp-rembrandt.c:283 rmb_pcm_resume() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5863
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/amd/acp/acp-rembrandt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 89314d95ec2b..21e67ed956d1 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -280,8 +280,8 @@ static int __maybe_unused rmb_pcm_resume(struct device *dev)
 			}
 		}
 	}
-		spin_unlock(&adata->acp_lock);
-		return 0;
+	spin_unlock(&adata->acp_lock);
+	return 0;
 }
 
 static const struct dev_pm_ops rmb_dma_pm_ops = {
-- 
2.20.1.7.g153144c

