Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F076CC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:20:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1338C20748
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oMeMo7Vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1338C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83C03171F;
	Tue, 26 Nov 2019 11:19:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83C03171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574763603;
	bh=DBaWC7VpBgoJqvTpvq0DMHrWvDYoJc0QPYS0OE5H1wk=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oMeMo7VkmZQQ1ci2kthXaFlD9gEPVyVf6masFwxyzdElGLx0KWtoHYNfgXRLbJSll
	 8Znt1qta+eBxg+NidmLnc8r1iN0g2RDRGysHPp1cOUzbMwXckXd7HLQosCdA31DVY8
	 tp/CH/uBhZ6GaILkez8miv79ElbH9PRi0FBvkvwc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F932F80149;
	Tue, 26 Nov 2019 11:19:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29E62F80159; Tue, 26 Nov 2019 11:19:11 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07457F800DD
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 11:19:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07457F800DD
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 02:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; d="scan'208";a="202673504"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga008.jf.intel.com with ESMTP; 26 Nov 2019 02:18:47 -0800
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 26 Nov 2019 11:18:03 +0100
Message-Id: <1574763483-15947-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: vkoul@kernel.org, cezary.rojewski@intel.com, gustaw.lewandowski@intel.com
Subject: [alsa-devel] [PATCH] crecord: truncate file to remove content of
	existing file
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Without O_TRUNC overwriting bigger file by smaller one doesn't wipe the
old file fully.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 src/utils/crecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/utils/crecord.c b/src/utils/crecord.c
index 12ad961..abaafea 100644
--- a/src/utils/crecord.c
+++ b/src/utils/crecord.c
@@ -323,7 +323,7 @@ static void capture_samples(char *name, unsigned int card, unsigned int device,
         if (!name) {
                 file = STDOUT_FILENO;
         } else {
-	        file = open(name, O_RDWR | O_CREAT,
+	        file = open(name, O_RDWR | O_CREAT | O_TRUNC,
 			    S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
 	        if (file == -1) {
 		       fprintf(stderr, "Unable to open file '%s'\n", name);
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
