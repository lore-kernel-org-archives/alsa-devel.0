Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB8C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 11:11:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBC961414
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 11:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBC961414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29AAC169F;
	Fri,  7 May 2021 13:10:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29AAC169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620385892;
	bh=jnWkO5LxKxHHsvT0SDgmWvsJA28dSVSK3KwgviTRidM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dOwPwWAdK225jYFBmWHexaW6nqTLh9Qt0e3q41gsfLcW7WoQA6cm32bI6mwz9NWvy
	 wPd+9cR/4MXdgH+0U+b8JkzmXOL2XnbkN99iNWriYRsrBgpMJWYNWdmpwC4yzKPcTm
	 l0mIluE6taAp7ryjHmhgO7GMIoSiA5+xm/4Mo35I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE327F8026D;
	Fri,  7 May 2021 13:09:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 295A8F8021C; Thu,  6 May 2021 04:10:47 +0200 (CEST)
Received: from mail-m176218.qiye.163.com (mail-m176218.qiye.163.com
 [59.111.176.218])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4428BF8007E
 for <alsa-devel@alsa-project.org>; Thu,  6 May 2021 04:10:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4428BF8007E
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
 by mail-m176218.qiye.163.com (Hmail) with ESMTPA id 45F7A32009E;
 Thu,  6 May 2021 10:10:33 +0800 (CST)
From: Wan Jiabing <wanjiabing@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Colin Ian King <colin.king@canonical.com>,
 Wan Jiabing <wanjiabing@vivo.com>, Yang Li <yang.lee@linux.alibaba.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: lpass-rx-macro: Remove unneeded semicolon
Date: Thu,  6 May 2021 10:09:49 +0800
Message-Id: <20210506021005.4897-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGktKS1ZLSEJLHxpJH0hLHk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6PQw4GT8QQ0MfSjAhExI4
 FA4KCR5VSlVKTUlLSU1MS0hPS01LVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
 TVVKTklVSk9OVUpDSVlXWQgBWUFJS09KNwY+
X-HM-Tid: 0a793f70e415d978kuws45f7a32009e
X-Mailman-Approved-At: Fri, 07 May 2021 13:09:49 +0200
Cc: kael_w@yeah.net
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

Fix the following coccicheck warning:

./sound/soc/codecs/lpass-rx-macro.c:2631:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index b0ebfc8d180c..8dff72fc7bab 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2628,7 +2628,7 @@ static int rx_macro_enable_rx_path_clk(struct snd_soc_dapm_widget *w,
 		break;
 	default:
 		break;
-	};
+	}
 	return 0;
 }
 
-- 
2.25.1

