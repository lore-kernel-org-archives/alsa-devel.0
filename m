Return-Path: <SRS0=FEtg=KW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D35AC47082
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 03:06:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA4660C41
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 03:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA4660C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DC6D1704;
	Thu, 27 May 2021 05:06:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DC6D1704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622084812;
	bh=7DjVwUTWO0iS9v53A6zAzFnCLxpWvB/W65FF3LAEu6Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eroZL123UV50GCQ8sJ1r8ADFcuKXq2EGv6fZcG8ivjWlhQi0aeCzajjj5FIZ9hkzM
	 8GFTxmrtEYzsGXCc4KwwjH1XJhQ4xRpjIz8znDlBaGKJ4B2W4SdPRt1bfu5c8uYKaz
	 uloHaST12wmtk64PY9m8AElEMBLIXDCJQbziKSuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12C54F80116;
	Thu, 27 May 2021 05:06:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCB62F8012E; Thu, 27 May 2021 05:06:00 +0200 (CEST)
Received: from proxy25215.mail.163.com (proxy25215.mail.163.com
 [103.129.252.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 74CC5F800EA
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 05:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74CC5F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.b="YPjz89JD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=70Oom
 WJ3zwC7Ux4Cyuscx9W74Lf/fdGM/9aFa7xNXOw=; b=YPjz89JDYUNFXKZ8wozMj
 F2/GjaVmqfeGW15EBVVwd2n/4GGUypet5kP1K2An0CE0ojqLChtvx1glTV2u9Gj3
 HFndIWphdfyF103qWXkrZ/lzwMwGiR/Yb7E4zp0p7x9SRYCXaIIS360LJnMWbu9y
 8l9CcNvgXF7ievQZWhYTQE=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
 by smtp14 (Coremail) with SMTP id EsCowACHieFPDK9gAU9Clw--.31488S2;
 Thu, 27 May 2021 11:04:50 +0800 (CST)
From: zuoqilin1@163.com
To: perex@perex.cz,
	tiwai@suse.com,
	joe@perches.com,
	gustavoars@kernel.org
Subject: [PATCH] sound/oss/dmasound: Remove superfluous "break"
Date: Thu, 27 May 2021 11:04:45 +0800
Message-Id: <20210527030445.1201-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACHieFPDK9gAU9Clw--.31488S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW8ArWfGF18uFWUXryfXrb_yoWDCrc_X3
 yIgr1xWa4kZrn7A347XasrGrZrK3W7Aw1fW34UKa17Wr48GrWftw1DGrsxWrn5X34Fyw4x
 u3y2k3yIk3yFqjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0mXd5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQ+fiV8ZOwgNGgABsf
Cc: zuoqilin <zuoqilin@yulong.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

From: zuoqilin <zuoqilin@yulong.com>

Remove superfluous "break", as there is a "return" before them.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 sound/oss/dmasound/dmasound_core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 22cef0c..0c95828 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1229,31 +1229,22 @@ static char *get_afmt_string(int afmt)
         switch(afmt) {
             case AFMT_MU_LAW:
                 return "mu-law";
-                break;
             case AFMT_A_LAW:
                 return "A-law";
-                break;
             case AFMT_U8:
                 return "unsigned 8 bit";
-                break;
             case AFMT_S8:
                 return "signed 8 bit";
-                break;
             case AFMT_S16_BE:
                 return "signed 16 bit BE";
-                break;
             case AFMT_U16_BE:
                 return "unsigned 16 bit BE";
-                break;
             case AFMT_S16_LE:
                 return "signed 16 bit LE";
-                break;
             case AFMT_U16_LE:
                 return "unsigned 16 bit LE";
-                break;
 	    case 0:
 		return "format not set" ;
-		break ;
             default:
                 break ;
         }
-- 
1.9.1


