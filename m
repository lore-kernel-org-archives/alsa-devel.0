Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD58C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 14:29:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DBF64E40
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 14:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DBF64E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08DA774C;
	Sat,  6 Feb 2021 15:28:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08DA774C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612621765;
	bh=8pfLenxKVqGF/fCAkpr/oUrhzU+aVUg+scmAXf9qLwg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A4Eytap6Aoygsm+wOqF8XmHBySVC8yCK7N+LeFQ68LYmwGlbgCbAjbI+OWG+S305A
	 tZci2don6a1n7ePIjWV60ZLxA0aH/lu4ysrP56D6ISvwpq7ZqPfkhidVyYFfjQQgf7
	 och1RRCY8XfvnEfdYUFPL26dtuULwXyU/RBr/4aE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42B65F80155;
	Sat,  6 Feb 2021 15:28:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 672FAF80171; Sat,  6 Feb 2021 15:28:25 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7960FF800B8
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 15:28:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7960FF800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oasV2rsU"
Received: by mail-qt1-x82f.google.com with SMTP id r20so7247665qtm.3
 for <alsa-devel@alsa-project.org>; Sat, 06 Feb 2021 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=trBVjthcPa4Szq9iRBkzGcGAwzG2BWGvuWeRierNB7w=;
 b=oasV2rsUxYMGMghTGq+ZEmvFqtfGb+T5TIkzkB2aqOSIuWJRVzHLQG39dGmlJHgd5k
 GPImxjgr/d1XAJfMz+vukL/ez1hR7ObSMIc8gk3kvq0yejAB2SjvGqp/ieh9SQzMPmXc
 0oSmQDGgo1+lFVoDA1kQWKd8bZTnYxRH866wdzMedIDlVOqw2A274zSCA2f0XrtjPc7j
 d3tkiOQrnmcXei84g4539c7fb5AjTrZBwsUGYEz1y2wl0bTNwZqP89h/oPpKXHkgBwWX
 gK6LzJnv/S1u5hjg4+MF42XKhzgPDigjqvQid8CvFYSEvI9nKDnTl3Km+nbunIJLk9Uh
 UrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=trBVjthcPa4Szq9iRBkzGcGAwzG2BWGvuWeRierNB7w=;
 b=YRpyB2iCalF2fwckObkT+l9UlHbc6wXvah139wIyYDKJd1ZwkRP36AuHO0HoCYeqRJ
 9RpwXCLSFI3haTrrEWeFMxByN1h7WXoz1lZwgadIhhjotOhnVcOLmXMJbDgeII+yKIFA
 9jzu8fdpkZCM9XWW7bWgcpzEgBMt6Tuby452DyGSDnG23zUYosNZcxJdvgzqwPRr76ZS
 R1lEc+d/xgjZKJX5Je5RgAoIQD7l/DGfuI7DmW9iK9kAYChS3rUQLe2v2ctr0oAyttqa
 m8g3/wRvkhC66Z/yR23Y7Z93FKI5dT1TPlyD/Ds4dPmMEYzql2nDFKU7/MGbqlMc1jKK
 sodw==
X-Gm-Message-State: AOAM530KTRxIr+334zAxxrpS58Cmi7K/6m9AnKq/9S5RNV90iQUYWRwH
 fmipe/6u0fEWhldJno5XqOM=
X-Google-Smtp-Source: ABdhPJy+K36pBr4d2rZd2et2krL+Yq2rV1yQB+zZqKQBuaV4FY7cQrqCjcXS3S8j95X69pYbGEMFhQ==
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr1702791qta.168.1612621682548; 
 Sat, 06 Feb 2021 06:28:02 -0800 (PST)
Received: from localhost.localdomain ([2804:431:d77f:e61e:c875:9def:11d8:cdcf])
 by smtp.gmail.com with ESMTPSA id t22sm11368626qtp.7.2021.02.06.06.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Feb 2021 06:28:01 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH v2] ASoC: fsl_esai: Remove unused 'imx' field
Date: Sat,  6 Feb 2021 11:27:53 -0300
Message-Id: <20210206142753.536459-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nicoleotsuka@gmail.com, Fabio Estevam <festevam@gmail.com>,
 alsa-devel@alsa-project.org, shengjiu.wang@gmail.com
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

The 'imx' field is not used anywhere, so get rid of it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Also remove the comment about the imx member.

 sound/soc/fsl/fsl_esai.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index bac9f059c9fc..08056fa0a0fa 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -23,11 +23,9 @@
 
 /**
  * struct fsl_esai_soc_data - soc specific data
- * @imx: for imx platform
  * @reset_at_xrun: flags for enable reset operaton
  */
 struct fsl_esai_soc_data {
-	bool imx;
 	bool reset_at_xrun;
 };
 
@@ -86,17 +84,14 @@ struct fsl_esai {
 };
 
 static struct fsl_esai_soc_data fsl_esai_vf610 = {
-	.imx = false,
 	.reset_at_xrun = true,
 };
 
 static struct fsl_esai_soc_data fsl_esai_imx35 = {
-	.imx = true,
 	.reset_at_xrun = true,
 };
 
 static struct fsl_esai_soc_data fsl_esai_imx6ull = {
-	.imx = true,
 	.reset_at_xrun = false,
 };
 
-- 
2.25.1

