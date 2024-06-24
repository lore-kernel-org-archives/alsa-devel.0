Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FEAC2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:28:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F5352BA5;
	Mon,  1 Jul 2024 14:28:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F5352BA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719836929;
	bh=aKjfunUPatqAejqdZtGwl92h5nzm1QwzOHxT5bISx3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YlNeCXpl9OOlfgqNO3Oj0bDQ0izRoqpzIDrAW8yxPHKFD0ET9TYurOJNIMOVBsdi5
	 1OaJomr768rKNOGy0PDlrcX2OZlkkDtr/4lHcoiPakR9dAZJquTmFtlQ5uAcmPB1ve
	 Zok/xwlrSrwrp5h1whrS2r+dlu5H8rP3dfsP2er4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73BEEF8068D; Mon,  1 Jul 2024 14:21:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 33ED3F8980E;
	Mon,  1 Jul 2024 14:21:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74A82F80495; Mon, 24 Jun 2024 05:06:52 +0200 (CEST)
Received: from mail78-63.sinamail.sina.com.cn (mail78-63.sinamail.sina.com.cn
 [219.142.78.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0FC10F804D6
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 05:06:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FC10F804D6
Received: from unknown (HELO zy-virtual-machine.localdomain)([116.227.101.59])
	by sina.net (10.75.30.239) with ESMTP
	id 6678E2A10002B8DA; Mon, 24 Jun 2024 11:06:16 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: C96BF33DB7C74C91AC49603CE80D6180
X-SMAIL-UIID: C96BF33DB7C74C91AC49603CE80D6180-20240624-110616
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 4/4] ASoC: codecs: ES8326: regcache_sync error issue
Date: Mon, 24 Jun 2024 11:06:07 +0800
Message-Id: <20240624030607.4307-5-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240624030607.4307-1-zhangyi@everest-semi.com>
References: <20240624030607.4307-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: T7SY6WASGIZ4KT56ZG2BSQYOFT4SCU76
X-Message-ID-Hash: T7SY6WASGIZ4KT56ZG2BSQYOFT4SCU76
X-Mailman-Approved-At: Mon, 01 Jul 2024 12:21:21 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T7SY6WASGIZ4KT56ZG2BSQYOFT4SCU76/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We modified the regmap_config members to fix cach sync error.
There are several registers that should be read-only registers.
If these registers are written while synchronizing the register values,
the codec will enter an error state.So we create es8326_writeable_register,
and set these registers to false

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8326.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 4f10ab5394ec..d209865be9e1 100755
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -327,11 +327,29 @@ static bool es8326_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool es8326_writeable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ES8326_BIAS_SW1:
+	case ES8326_BIAS_SW2:
+	case ES8326_BIAS_SW3:
+	case ES8326_BIAS_SW4:
+	case ES8326_ADC_HPFS1:
+	case ES8326_ADC_HPFS2:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static const struct regmap_config es8326_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
+	.use_single_read = true,
+	.use_single_write = true,
 	.volatile_reg = es8326_volatile_register,
+	.writeable_reg = es8326_writeable_register,
 	.cache_type = REGCACHE_RBTREE,
 };
 
-- 
2.17.1

