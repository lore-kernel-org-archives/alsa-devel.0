Return-Path: <SRS0=Pn0z=6U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C873DC28CBC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 17:22:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5158820736
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 17:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WWeAKeGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5158820736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B606A17A6;
	Wed,  6 May 2020 19:21:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B606A17A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588785757;
	bh=TLR4UHfvVE959GYYLTfIgOtvfbhdTUHpTIHFUetfAQ0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WWeAKeGildLW5fUQpzmgRCGUk6+n+MQZ3hpQ3QF8RAuO7kd/3Tr4z9i8UP+ByJJ8I
	 ssHnEr7DdRlahKOvxDKNtzoG/mSc5m7H/n6JQwRdjTzxpbDWWFDNxQ8p3B7vlIDUer
	 iTfd/4EA5gWCBnM2aX8685ITrBwDNRuifJGVUZME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55944F80299;
	Wed,  6 May 2020 19:20:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AF19F80299; Wed,  6 May 2020 19:20:09 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8810F80234
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 19:19:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8810F80234
Received: from is232189.intra.cea.fr ([46.193.2.18]) by mwinf5d87 with ME
 id bVKi2200W0PJwDa03VKr81; Wed, 06 May 2020 19:19:51 +0200
X-ME-Helo: is232189.intra.cea.fr
X-ME-Auth: ZnJlZGVyaWMucmVjb3VsZXNAb3JhbmdlLmZy
X-ME-Date: Wed, 06 May 2020 19:19:51 +0200
X-ME-IP: 46.193.2.18
From: frederic.recoules@univ-grenoble-alpes.fr
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 5/5] pcm_dmix assembly: give more freedom over the
 constraints
Date: Wed,  6 May 2020 19:19:24 +0200
Message-Id: <20200506171924.2644-5-frederic.recoules@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506171924.2644-1-frederic.recoules@univ-grenoble-alpes.fr>
References: <20200506171924.2644-1-frederic.recoules@univ-grenoble-alpes.fr>
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

Minor changes that could help the compiler to produce a
better (smaller/faster) code.

Signed-off-by: Frédéric Recoules <frederic.recoules@orange.fr>
---
 src/pcm/pcm_dmix_i386.h   | 30 +++++++++++++++---------------
 src/pcm/pcm_dmix_x86_64.h | 18 +++++++++---------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/src/pcm/pcm_dmix_i386.h b/src/pcm/pcm_dmix_i386.h
index bd1d6644..8dcba3d8 100644
--- a/src/pcm/pcm_dmix_i386.h
+++ b/src/pcm/pcm_dmix_i386.h
@@ -149,13 +149,13 @@ static void MIX_AREAS_16(unsigned int size,
 #ifdef BOUNDED_EBX
 		"\tmovl %[old_ebx], %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_EBX
 		  , [old_ebx] "=m" (old_ebx)
 #endif
 		: [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "esi", "edi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_EBX
 		  , "ebx"
@@ -248,13 +248,13 @@ static void MIX_AREAS_16_MMX(unsigned int size,
 #ifdef BOUNDED_EBX
 		"\tmovl %[old_ebx], %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_EBX
 		  , [old_ebx] "=m" (old_ebx)
 #endif
 		: [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "esi", "edi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_EBX
 		  , "ebx"
@@ -376,13 +376,13 @@ static void MIX_AREAS_32(unsigned int size,
 #ifdef BOUNDED_EBX
 		"\tmovl %[old_ebx], %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_EBX
 		  , [old_ebx] "=m" (old_ebx)
 #endif
 		: [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "esi", "edi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_EBX
 		  , "ebx"
@@ -491,13 +491,13 @@ static void MIX_AREAS_24(unsigned int size,
 #ifdef BOUNDED_EBX
 		"\tmovl %[old_ebx], %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_EBX
 		  , [old_ebx] "=m" (old_ebx)
 #endif
 		: [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "esi", "edi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_EBX
 		  , "ebx"
@@ -599,13 +599,13 @@ static void MIX_AREAS_24_CMOV(unsigned int size,
 #ifdef BOUNDED_EBX
 		"\tmovl %[old_ebx], %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_EBX
 		  , [old_ebx] "=m" (old_ebx)
 #endif
 		: [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "esi", "edi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_EBX
 		  , "ebx"
diff --git a/src/pcm/pcm_dmix_x86_64.h b/src/pcm/pcm_dmix_x86_64.h
index fff07529..aef5d90c 100644
--- a/src/pcm/pcm_dmix_x86_64.h
+++ b/src/pcm/pcm_dmix_x86_64.h
@@ -121,13 +121,13 @@ static void MIX_AREAS_16(unsigned int size,
 #ifdef BOUNDED_RBX
 		"\tmovq %[old_rbx], %%rbx\n"
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_RBX
 		  , [old_rbx] "=m" (old_rbx)
 #endif
 	        : [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "rsi", "rdi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_RBX
 		  , "rbx"
@@ -251,13 +251,13 @@ static void MIX_AREAS_32(unsigned int size,
 #ifdef BOUNDED_RBX
 		"\tmovq %[old_rbx], %%rbx\n"
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_RBX
 		  , [old_rbx] "=m" (old_rbx)
 #endif
 	        : [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "rsi", "rdi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_RBX
 		  , "rbx"
@@ -363,13 +363,13 @@ static void MIX_AREAS_24(unsigned int size,
 #ifdef BOUNDED_RBX
 		"\tmovq %[old_rbx], %%rbx\n"
 #endif
-		: [size] "+m" (size)
+		: [size] "+&rm" (size)
 #ifdef BOUNDED_RBX
 		  , [old_rbx] "=m" (old_rbx)
 #endif
 	        : [dst] "m" (dst), [src] "m" (src), [sum] "m" (sum),
-		  [dst_step] "m" (dst_step),  [src_step] "m" (src_step),
-		  [sum_step] "m" (sum_step)
+		  [dst_step] "im" (dst_step),  [src_step] "im" (src_step),
+		  [sum_step] "im" (sum_step)
 		: "rsi", "rdi", "edx", "ecx", "eax", "memory", "cc"
 #ifndef BOUNDED_RBX
 		  , "rbx"
-- 
2.17.1

