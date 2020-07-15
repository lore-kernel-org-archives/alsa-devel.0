Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97905C433E5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:21:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207422071B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s/sRCfCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207422071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mawsonlakes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B9A31607;
	Thu, 16 Jul 2020 09:20:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B9A31607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594884074;
	bh=o7mdjroG5s9BvztFVmLwZmt2KTj98wqEKDV/glIinkc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s/sRCfCXZvjtIuvT4pu9UBnCw1pTQ/+Mdq6fnFU6B3YYIB+Nfe20lC6P80jZhIezE
	 xzv0Q1i8SAeBevcDo6E7HltsHgDCy/rDtAa9x9KMKr5z636juo+sDuRYgRM0LFFg3J
	 5/B8RfNakrHSGA4auNHhwEPS3w9hgITFDkiEz34E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6E3CF8014E;
	Thu, 16 Jul 2020 09:18:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1058CF8021D; Wed, 15 Jul 2020 18:48:55 +0200 (CEST)
Received: from ipmail04.adl3.internode.on.net (ipmail04.adl3.internode.on.net
 [150.101.137.10])
 by alsa1.perex.cz (Postfix) with ESMTP id 3DEC2F80113
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 18:48:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DEC2F80113
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AxEQAuMg9f/5UxyQ5gHAEBATwBAQQ?=
 =?us-ascii?q?EAQECAQEHAQEcgUWBPAIBgixfjTSGAJwwgWkLATwBAgQBAYRGBAKCDCU4EwI?=
 =?us-ascii?q?QAQEGAQEBAQEGBIZUhigBIyNPAYEBgyaCfKtKiTCBQIE2AgEBAYgAhQmCAIR?=
 =?us-ascii?q?fhCNnhSkEj0mJcoFjmhGCZ4ELmEEwgQueLgGzAoF6MxoIKAg7gmlQGQ2OKhe?=
 =?us-ascii?q?ONDQwNwIGCAEBAwlXAY9RAQE?=
Received: from 14-201-49-149.tpgi.com.au (HELO silver.lan) ([14.201.49.149])
 by ipmail04.adl3.internode.on.net with ESMTP; 16 Jul 2020 02:18:40 +0930
From: Paul Schulz <paul@mawsonlakes.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] sound/soc/soc-core: Removed instances of 'blacklist'
Date: Thu, 16 Jul 2020 02:18:36 +0930
Message-Id: <20200715164836.123012-1-paul@mawsonlakes.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2020 09:18:10 +0200
Cc: Takashi Iwai <tiwai@suse.com>, Paul Schulz <paul@mawsonlakes.org>
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

This patch removes 'blacklist' and replaces it with
'invalid list' in sound/soc/soc-core.c

This is a functionally trivial patch and has no other effect.

Signed-off-by: Paul Schulz <paul@mawsonlakes.org>
---
 sound/soc/soc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0f30f5aabaa8..6bc56c4cb207 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1457,11 +1457,11 @@ EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
 #ifdef CONFIG_DMI
 /*
- * If a DMI filed contain strings in this blacklist (e.g.
+ * If a DMI filed contain strings in this invalid list (e.g.
  * "Type2 - Board Manufacturer" or "Type1 - TBD by OEM"), it will be taken
  * as invalid and dropped when setting the card long name from DMI info.
  */
-static const char * const dmi_blacklist[] = {
+static const char * const dmi_invalid_list[] = {
 	"To be filled by OEM",
 	"TBD by OEM",
 	"Default String",
@@ -1493,14 +1493,14 @@ static void cleanup_dmi_name(char *name)
 
 /*
  * Check if a DMI field is valid, i.e. not containing any string
- * in the black list.
+ * in the invalid list.
  */
 static int is_dmi_valid(const char *field)
 {
 	int i = 0;
 
-	while (dmi_blacklist[i]) {
-		if (strstr(field, dmi_blacklist[i]))
+	while (dmi_invalid_list[i]) {
+		if (strstr(field, dmi_invalid_list[i]))
 			return 0;
 		i++;
 	}
-- 
2.25.1

