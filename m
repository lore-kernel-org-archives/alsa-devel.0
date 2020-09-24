Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FF6C4346E
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:45:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615F320708
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sFYbzOOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615F320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E13A179E;
	Thu, 24 Sep 2020 08:44:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E13A179E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600929944;
	bh=LJLWVld4Q7N/60dvb3ox0/TaLLpD5t6T4NkSro9v7FE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sFYbzOOFUWnBZLstbdvJ2+aYEBXwEiQuY3/WvCrfZ2b1M0LQjpOt8a6Ob6DHZEo7s
	 2uQvlH4kz+kjCRWCvaFQg5Rc9sikxOk9QQslLKhKnQ+Z65UCbZdmOFs6XQS/yyIrt7
	 vjyohJsEx7JX/LLwjASQQuAZDIVb7FqDIgrfa51A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA520F80229;
	Thu, 24 Sep 2020 08:44:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 798EEF80232; Thu, 24 Sep 2020 08:44:51 +0200 (CEST)
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38A07F800DA
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 08:44:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38A07F800DA
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 9E06D4E17A5;
 Thu, 24 Sep 2020 14:44:28 +0800 (CST)
From: Wang Qing <wangqing@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Wang Qing <wangqing@vivo.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] sound/soc/codecs: fix spelling typo in comments
Date: Thu, 24 Sep 2020 14:43:59 +0800
Message-Id: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGUhOTxpJT0lNTUMeVkpNS0tCSUJDTUNCQ0xVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6Vio5ND8oEgMSKhMQLk9C
 CDNPFDBVSlVKTUtLQklCQ01CSEJMVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
 SU5KVUxPVUlISllXWQgBWUFKT0JINwY+
X-HM-Tid: 0a74bedb2c4b9376kuws9e06d4e17a5
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

Modify the comment typo: "compliment" -> "complement".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 sound/soc/codecs/ak4458.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
index f906215..e43144c
--- a/sound/soc/codecs/ak4458.h
+++ b/sound/soc/codecs/ak4458.h
@@ -49,7 +49,7 @@
 
 /* DIF2	1 0
  *  x	1 0 MSB justified  Figure 3 (default)
- *  x	1 1 I2S Compliment  Figure 4
+ *  x	1 1 I2S Complement  Figure 4
  */
 #define AK4458_DIF_SHIFT	1
 #define AK4458_DIF_MASK		GENMASK(3, 1)
-- 
2.7.4

