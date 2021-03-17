Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCDC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 09:21:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F19F64F10
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 09:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F19F64F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 942A016C9;
	Thu, 18 Mar 2021 10:20:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 942A016C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616059263;
	bh=8J+gVQvAtrtx1ThDy0Cvy0SRxX4BZzlONDPk4wpEFGs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lq32Kv1YPhaOcoGa8fR+LlKP6r6NpiylofYwFyToktHZgf+y9AN1LiwnAFfJjvsaY
	 g8e/G5OnnJ8sozlpI5f+d+yt4z7V9IP7ErAr3wom74p3DiCEuiNXClD/VS66cO4qZN
	 2CAmwz8DOX0vQAWHYIVYRA/cqYAi9DUQTONa3WAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E55F2F804DA;
	Thu, 18 Mar 2021 10:16:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88F49F80253; Wed, 17 Mar 2021 21:22:03 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDB1DF80124
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 21:21:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDB1DF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nqNnsd9Q"
Received: by mail-pg1-x52c.google.com with SMTP id g4so320031pgj.0
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=gDAq4DE4PBvBHlZJ3CaMSbFvBl5PB60V3/mTqquUBA0=;
 b=nqNnsd9QjmZAEesBQrZiDjMyz3oLxxXJxKtkKMe8GT3X2N6dFYpbXOzZSISq+SZbFu
 tSC9Z6PDiZMWE/xGc/MwC8vtjq+rRJm8icXpKQHAnrxx7MO1URm+sTtT/fv/wuirgPG4
 GV6TlokkfSmrLjle/XO9RMiamLMB8xLeizvigigoN/TwoKTpTDwobhY9luHgQko3A3Ve
 tK6u3Shsmz9IzoedC5GoT3gz4mrhoeeBJuQkGnv3fJsFqIsgXxjMspnhULe29+lIOI0E
 kfAW6p39MN1Q4MTYcF1hNL/JC8f0tfGrPYjEMzwZu+xmKmGXDpwXe5zwIQsIjGTZMzTS
 f7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gDAq4DE4PBvBHlZJ3CaMSbFvBl5PB60V3/mTqquUBA0=;
 b=UYKwnvTakp4WwG5DlPLk+4/oH1/4vAdeyO16w86vRhvBI+tOrXgevvWn9BH1DFxywg
 eFlxZ1Av6iXJ9QrMQs9HYJQd6W6Tvg5/O9uCZLvFdayza+0fLtjHOMznuMNgd9tZ5AKo
 Mcm6+pQU6bT1cvHTgVNxD5VHSgcNdJ9rYKHgpx9+WnmsVMON3FKi+6NAUCX3tun6bz04
 7qg8BKTI8QsJ2p9c/3sNqPDlq1Ggu/twZMJRX7bXKY90uOVns87EGrhV7LCuNzCBjBuX
 HtAu2R0iLgQ5037gxZzmvtR+g6dstnMVezQ0PXIQy5rdAlNI/rRpIJ3vC01ztpL8k6wX
 2PTg==
X-Gm-Message-State: AOAM533jf1RD9cSotAFD2idUJ1MHh4T3E+VLcbmnozbVZWJ2hyA4rzkv
 k9dAK8CALH0hZOLs4BGrMSsXpXFAcOFOrA==
X-Google-Smtp-Source: ABdhPJw//WXqfEPZhDC07hr0kMIG47o3Qo6OU6JBopYEdvbfgnNCCWuUDtw9QnzuRULP02XBC5CIKQ==
X-Received: by 2002:aa7:9605:0:b029:20e:b183:fc89 with SMTP id
 q5-20020aa796050000b029020eb183fc89mr695965pfg.70.1616012514025; 
 Wed, 17 Mar 2021 13:21:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:85d1:b0af:d6ff:42d8])
 by smtp.googlemail.com with ESMTPSA id e1sm8555pjt.10.2021.03.17.13.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 13:21:53 -0700 (PDT)
From: Aditya Srivastava <yashsri421@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: asihpi: fix comment syntax in file headers
Date: Thu, 18 Mar 2021 01:51:44 +0530
Message-Id: <20210317202144.20290-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 18 Mar 2021 10:16:09 +0100
Cc: yashsri421@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lukas.bulwahn@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
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

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are files in sound/pci/asihpi which follow this syntax in their file
headers, i.e. start with '/**' like comments, which causes unexpected
warnings from kernel-doc.

E.g., running scripts/kernel-doc -none on sound/pci/asihpi/hpidspcd.h
causes this warning:
"warning: Cannot understand
 on line 4 - I thought it was a doc line"

Provide a simple fix by replacing the kernel-doc like comment syntax with
general format, i.e. "/*", to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210312

 sound/pci/asihpi/hpicmn.h   | 2 +-
 sound/pci/asihpi/hpidspcd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
index de3bedd29d94..8ec656cf8848 100644
--- a/sound/pci/asihpi/hpicmn.h
+++ b/sound/pci/asihpi/hpicmn.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
 
     AudioScience HPI driver
     Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
diff --git a/sound/pci/asihpi/hpidspcd.h b/sound/pci/asihpi/hpidspcd.h
index a01e8c6092bd..9f1468ed7096 100644
--- a/sound/pci/asihpi/hpidspcd.h
+++ b/sound/pci/asihpi/hpidspcd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /***********************************************************************/
-/**
+/*
 
     AudioScience HPI driver
     Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
-- 
2.17.1

