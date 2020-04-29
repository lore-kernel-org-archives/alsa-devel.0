Return-Path: <SRS0=Op9s=6N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E7C83000
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:14:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0DF21D82
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZkxxLxpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DF21D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3AF31676;
	Wed, 29 Apr 2020 21:13:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3AF31676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588187662;
	bh=aNvW/JDCVG19/yLEIdjfYK8YSuVfeScxG2evT4l0kwU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkxxLxpwFJGjMO7aYOWWq10OsVKETN1eGEUEKOTmk6r4ds2qITa6MIBU2Op42avzc
	 MmzDH7smYTDKEbaxD22kqFAEFuTmcMU5hICbp48GKP9jd4PiO2GH5PeoruxrZvIEko
	 sWyoCMtRFAcKNs9ZtiAMWProc9qDNml+XiQYdF7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 459E9F8029B;
	Wed, 29 Apr 2020 21:11:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F0B3F802A7; Wed, 29 Apr 2020 21:11:13 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2429EF80257
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2020 21:11:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2429EF80257
Received: from is232189.intra.cea.fr ([46.193.2.18]) by mwinf5d31 with ME
 id YjAq2200t0PJwDa03jB4iX; Wed, 29 Apr 2020 21:11:04 +0200
X-ME-Helo: is232189.intra.cea.fr
X-ME-Auth: ZnJlZGVyaWMucmVjb3VsZXNAb3JhbmdlLmZy
X-ME-Date: Wed, 29 Apr 2020 21:11:04 +0200
X-ME-IP: 46.193.2.18
From: frederic.recoules@univ-grenoble-alpes.fr
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/6 V2] [pcm_dmix assembly] fix the interface for safety (mmx)
Date: Wed, 29 Apr 2020 21:10:37 +0200
Message-Id: <20200429191039.28106-4-frederic.recoules@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429191039.28106-1-frederic.recoules@univ-grenoble-alpes.fr>
References: <20200429191039.28106-1-frederic.recoules@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Recoules?= <frederic.recoules@orange.fr>
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

From: Frédéric Recoules <frederic.recoules@orange.fr>

- initialize mm1 with 0s;
- add mm0 and mm1 in the clobber list if the compiler
  is aware of the mmx technology;
- otherwise, add the mmx aliased x87 floating point
  register in the clobbers.

Note: produce exactly the same binary output except
      for mm1 initialization implying address shifts.

Signed-off-by: Frédéric Recoules <frederic.recoules@orange.fr>
---
 src/pcm/pcm_dmix_i386.h   | 9 ++++++++-
 src/pcm/pcm_dmix_x86_64.h | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_dmix_i386.h b/src/pcm/pcm_dmix_i386.h
index 3ea0737d..d9bf8f50 100644
--- a/src/pcm/pcm_dmix_i386.h
+++ b/src/pcm/pcm_dmix_i386.h
@@ -173,8 +173,9 @@ static void MIX_AREAS_16_MMX(unsigned int size,

 		"\tmovl %%ebx, %[old_ebx]\n"	/* ebx is GOT pointer (-fPIC) */
 		/*
-		 *  initialization, load ESI, EDI, EBX registers
+		 *  initialization, load ESI, EDI, EBX registers and clear MM1
 		 */
+		"\tpxor %%mm1, %%mm1\n"
 		"\tmovl %[dst], %%edi\n"
 		"\tmovl %[src], %%esi\n"
 		"\tmovl %[sum], %%ebx\n"
@@ -237,6 +238,12 @@ static void MIX_AREAS_16_MMX(unsigned int size,
 		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
 		  [sum_step] "m" (sum_step)
 		: "esi", "edi", "edx", "ecx", "eax", "memory", "cc"
+#               ifdef HAVE_MMX
+		  , "mm0", "mm1"
+#               else
+		  , "st", "st(1)", "st(2)", "st(3)",
+		  "st(4)", "st(5)", "st(6)", "st(7)"
+#               endif
 	);
 }

diff --git a/src/pcm/pcm_dmix_x86_64.h b/src/pcm/pcm_dmix_x86_64.h
index 7f711547..8ad1b2a0 100644
--- a/src/pcm/pcm_dmix_x86_64.h
+++ b/src/pcm/pcm_dmix_x86_64.h
@@ -50,8 +50,9 @@ static void MIX_AREAS_16(unsigned int size,

 		"\tmovq %%rbx, %[old_rbx]\n"
 		/*
-		 *  initialization, load RSI, RDI, RBX registers
+		 *  initialization, load RSI, RDI, RBX registers and clear MM1
 		 */
+		"\tpxor %%mm1, %%mm1\n"
 		"\tmovq %[dst], %%rdi\n"
 		"\tmovq %[src], %%rsi\n"
 		"\tmovq %[sum], %%rbx\n"
@@ -119,6 +120,12 @@ static void MIX_AREAS_16(unsigned int size,
 		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
 		  [sum_step] "m" (sum_step)
 		: "rsi", "rdi", "edx", "ecx", "eax", "memory", "cc"
+#               ifdef HAVE_MMX
+		  , "mm0", "mm1"
+#               else
+		  , "st", "st(1)", "st(2)", "st(3)",
+		  "st(4)", "st(5)", "st(6)", "st(7)"
+#               endif
 	);
 }

--
2.17.1
