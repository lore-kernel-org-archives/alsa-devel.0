Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1182FC47096
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 03:02:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461BA6140A
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 03:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461BA6140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D37AF170C;
	Fri,  4 Jun 2021 05:01:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D37AF170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622775761;
	bh=+sQsTOcD3ZOwgzhxTtWC8vqKG91LBMcZ2M0oDbimSG8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dTLwKTfsh/+LRR0C2vGFb04/pxL8nq2O0E/asNqODK2130wNtc+UG9EIkPDaBuzT7
	 WUslZSL7v4Sk6bQfFhF6XPPflDSfv0jTIzZKF6lUMPCfW5xT1ySM5aRecRwONEvXOb
	 0rY48zfT0OE+wNGLCWtAjkv+UiB/cyzq0NiyZlok=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30030F802A9;
	Fri,  4 Jun 2021 05:01:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D080F80103; Fri,  4 Jun 2021 05:01:31 +0200 (CEST)
Received: from mail-m121144.qiye.163.com (mail-m121144.qiye.163.com
 [115.236.121.144])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C2ECF800CC
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 05:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C2ECF800CC
Received: from Wanjb.localdomain (unknown [36.152.145.182])
 by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 010EFAC00E6;
 Fri,  4 Jun 2021 11:01:22 +0800 (CST)
From: Wan Jiabing <wanjiabing@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lee Jones <lee.jones@linaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Wan Jiabing <wanjiabing@vivo.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Remove unneeded semicolon in rk817_codec.c
Date: Fri,  4 Jun 2021 11:00:23 +0800
Message-Id: <20210604030045.7360-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGhhOSVZLSklNGh1CTkkfSRpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46Lzo5NT8cCQsBIzAjPT4q
 KwMwCw1VSlVKTUlJTExOTUNITUpPVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
 TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0tMNwY+
X-HM-Tid: 0a79d4f7d893b039kuuu010efac00e6
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

Fix following coccicheck warning:
./sound/soc/codecs/rk817_codec.c:49:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/codecs/rk817_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index fd3a5ba034a9..414d21f22a05 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -46,7 +46,7 @@ static int rk817_init(struct snd_soc_component *component)
 	if (rk817->mic_in_differential) {
 		snd_soc_component_update_bits(component, RK817_CODEC_AMIC_CFG0, MIC_DIFF_MASK,
 			MIC_DIFF_EN);
-	};
+	}
 	return 0;
 }
 
-- 
2.20.1

