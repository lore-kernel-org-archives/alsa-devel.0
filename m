Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AF5C0015E
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Jul 2023 02:22:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CA2386E;
	Thu, 27 Jul 2023 04:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CA2386E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690424569;
	bh=Lv84FnroZFshQ7n0bx3t0QZRh/OSvM4PlRc0Q+Qx6Mg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XgQhkSkACxNyp04xZNncYFJcHLqM7tREIIOV5QbIJWXx+ebfAiRVhb6TeSaEBGZIy
	 XLuhXuxNiACsbBelyZ2vqPz0OAeg5NK6vslQFtYxuTQBfQLR/xw76kXLug0YtNEsc0
	 srUN73gKzrZ88B1AZde/ChRPtNK7TmPSSqbNwb5s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEBFAF80544; Thu, 27 Jul 2023 04:21:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A3E9F80544;
	Thu, 27 Jul 2023 04:21:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC2D2F8019B; Thu, 27 Jul 2023 04:17:20 +0200 (CEST)
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 951EBF800D2
	for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2023 04:16:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 951EBF800D2
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VoIcwVc_1690424194;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VoIcwVc_1690424194)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 10:16:46 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: oder_chiou@realtek.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: rt1017: Remove unused function
Date: Thu, 27 Jul 2023 10:16:32 +0800
Message-Id: <20230727021632.88912-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RA3EZM22LGFVD6MI4GA3BMEO77SP6YBU
X-Message-ID-Hash: RA3EZM22LGFVD6MI4GA3BMEO77SP6YBU
X-MailFrom: jiapeng.chong@linux.alibaba.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RA3EZM22LGFVD6MI4GA3BMEO77SP6YBU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The function are defined in the rt1017-sdca-sdw.h file, but not called
elsewhere, so delete the unused functions.

sound/soc/codecs/rt1017-sdca-sdw.h:183:33: warning: ‘rt1017_sdca_mbq_defaults’ defined but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5998
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/rt1017-sdca-sdw.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt1017-sdca-sdw.h b/sound/soc/codecs/rt1017-sdca-sdw.h
index 5968b9a7d124..4932b5dbe3c0 100644
--- a/sound/soc/codecs/rt1017-sdca-sdw.h
+++ b/sound/soc/codecs/rt1017-sdca-sdw.h
@@ -180,9 +180,4 @@ static const struct reg_default rt1017_sdca_reg_defaults[] = {
 			RT1017_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 };
 
-static const struct reg_default rt1017_sdca_mbq_defaults[] = {
-	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_FU,
-			RT1017_SDCA_CTL_FU_VOLUME, 0x01), 0x00 },
-};
-
 #endif /* __RT1017_SDW_H__ */
-- 
2.20.1.7.g153144c

