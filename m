Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E2C54FCB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:58:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C9B206D4
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VGjNoVWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C9B206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B93C1682;
	Mon, 27 Apr 2020 18:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B93C1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588006692;
	bh=SWkNQHaXBFTIG76gjJ8cimgZ2vh7L24r61SQOkASCuw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VGjNoVWqa73+QhjC0nfpO32fcpaDkU+J1F/ewhBg6aR4DYdFqkCu8qNcWr836EXiC
	 CMLR2MkXyJxdmk95R38pm9Gz6fY6BVMNwI3hAlTqCqe/H+7u6id0IR3N6NWmT3bycB
	 Ig4+FGEXW/iL7l+iAnta5Vy78ip1c+Hp4VUQBboI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D613F8010A;
	Mon, 27 Apr 2020 18:57:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD66AF80217; Mon, 27 Apr 2020 18:57:20 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4E56F8010A
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 18:57:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4E56F8010A
Received: from is232189.intra.cea.fr ([46.193.2.18]) by mwinf5d82 with ME
 id XsxA2200d0PJwDa03sxBKK; Mon, 27 Apr 2020 18:57:11 +0200
X-ME-Helo: is232189.intra.cea.fr
X-ME-Auth: ZnJlZGVyaWMucmVjb3VsZXNAb3JhbmdlLmZy
X-ME-Date: Mon, 27 Apr 2020 18:57:11 +0200
X-ME-IP: 46.193.2.18
From: frederic.recoules@univ-grenoble-alpes.fr
To: alsa-devel@alsa-project.org
Subject: [PATCH] [inline assembly] fix pcm_dmix_i386.h assembly chunk
 interfaces
Date: Mon, 27 Apr 2020 18:57:07 +0200
Message-Id: <20200427165707.17570-1-frederic.recoules@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.17.1
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

Enabler change:
  - set HAVE_MMX in configure if the compiler is aware of MMX technology

Main changes are:
  - move 'size' and 'old_ebx' to the output list since they are clobbered
  - add the "memory" keyword since input pointers are dereferenced
  - add mmx registers in the clobber list and add an initialization for mm1
  - add ebx in clobbers via a set of macro when GCC is newer than 5.0
    (it will work for other compilers or non-PIC mode too)

Minor changes are:
  - keep consistent the token numbering in the template
  - remove the manual save/restore ebx when it is in the clobber list
  - allows 'dst_step', 'src_step' and 'sum_step' to be given by immediates
  - allows 'size' to be given by register (e.g. ebp)
  - add "cc" keyword since the eflag register is clobbered

Signed-off-by: Frédéric Recoules <frederic.recoules@orange.fr>
---
 configure.ac            |   7 ++
 src/pcm/pcm_dmix_i386.h | 174 +++++++++++++++++++++++-----------------
 2 files changed, 106 insertions(+), 75 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4b5ab662..1838e50b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -516,6 +516,13 @@ if test -z "$gcc_have_atomics"; then
 fi
 AC_MSG_RESULT($gcc_have_atomics)
 
+dnl check mmx register for pcm_dmix_i386
+
+AC_TRY_LINK([],
+    [__asm__ volatile ("" : : : "mm0");],
+    [AC_DEFINE([HAVE_MMX], "1", [MMX technology is enabled])],
+    [])
+
 PCM_PLUGIN_LIST="copy linear route mulaw alaw adpcm rate plug multi shm file null empty share meter hooks lfloat ladspa dmix dshare dsnoop asym iec958 softvol extplug ioplug mmap_emul"
 
 build_pcm_plugin="no"
diff --git a/src/pcm/pcm_dmix_i386.h b/src/pcm/pcm_dmix_i386.h
index 2778cb1d..aa1717f6 100644
--- a/src/pcm/pcm_dmix_i386.h
+++ b/src/pcm/pcm_dmix_i386.h
@@ -26,6 +26,13 @@
  *
  */
 
+#define COMMA ,
+#if __GNUC__ < 5 && defined(__PIC__)
+#  define GCC_PIC_SWITCH(before,after) before
+#else
+#  define GCC_PIC_SWITCH(before,after) after
+#endif
+
 /*
  *  for plain i386
  */
@@ -47,13 +54,14 @@ static void MIX_AREAS_16(unsigned int size,
 	__asm__ __volatile__ (
 		"\n"
 
-		"\tmovl %%ebx, %7\n"	/* ebx is GOT pointer (-fPIC) */
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %%ebx, %1\n",)
 		/*
 		 *  initialization, load ESI, EDI, EBX registers
 		 */
-		"\tmovl %1, %%edi\n"
-		"\tmovl %2, %%esi\n"
-		"\tmovl %3, %%ebx\n"
+		"\tmovl %2, %%edi\n"
+		"\tmovl %3, %%esi\n"
+		"\tmovl %4, %%ebx\n"
 		"\tcmpl $0, %0\n"
 		"\tjnz 2f\n"
 		"\tjmp 7f\n"
@@ -64,9 +72,9 @@ static void MIX_AREAS_16(unsigned int size,
 		 */
 		"\t.p2align 4,,15\n"
 		"1:"
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tadd %5, %%edi\n"
+		"\tadd %6, %%esi\n"
+		"\tadd %7, %%ebx\n"
 
 		/*
 		 *   sample = *src;
@@ -138,15 +146,16 @@ static void MIX_AREAS_16(unsigned int size,
 		"\tjnz 4b\n"
 		"\tdecl %0\n"
 		"\tjnz 1b\n"
-		
-		"7:"
-		"\tmovl %7, %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 
-		: /* no output regs */
-		: "m" (size), "m" (dst), "m" (src),
-		  "m" (sum), "m" (dst_step), "m" (src_step),
-		  "m" (sum_step), "m" (old_ebx)
-		: "esi", "edi", "edx", "ecx", "eax"
+		"7:"
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %1, %%ebx\n",)
+
+		: "+&rm" (size), GCC_PIC_SWITCH("=m","=X") (old_ebx)
+		: "m" (dst), "m" (src), "m" (sum),
+		  "im" (dst_step), "im" (src_step), "im" (sum_step)
+		: "esi", "edi", "edx", "ecx", GCC_PIC_SWITCH(,"ebx"COMMA) "eax",
+		  "memory", "cc"
 	);
 }
 
@@ -171,22 +180,24 @@ static void MIX_AREAS_16_MMX(unsigned int size,
 	__asm__ __volatile__ (
 		"\n"
 
-		"\tmovl %%ebx, %7\n"	/* ebx is GOT pointer (-fPIC) */
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %%ebx, %1\n",)
 		/*
-		 *  initialization, load ESI, EDI, EBX registers
+		 *  initialization, load ESI, EDI, EBX registers, clear MM1
 		 */
-		"\tmovl %1, %%edi\n"
-		"\tmovl %2, %%esi\n"
-		"\tmovl %3, %%ebx\n"
+		"\tpxor %%mm1, %%mm1\n"
+		"\tmovl %2, %%edi\n"
+		"\tmovl %3, %%esi\n"
+		"\tmovl %4, %%ebx\n"
 		"\tcmpl $0, %0\n"
 		"\tjnz 2f\n"
 		"\tjmp 5f\n"
 
 		"\t.p2align 4,,15\n"
 		"1:"
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tadd %5, %%edi\n"
+		"\tadd %6, %%esi\n"
+		"\tadd %7, %%ebx\n"
 
 		"2:"
 		/*
@@ -230,13 +241,20 @@ static void MIX_AREAS_16_MMX(unsigned int size,
 		"\tjnz 1b\n"
 		"\temms\n"
                 "5:"
-		"\tmovl %7, %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
-
-		: /* no output regs */
-		: "m" (size), "m" (dst), "m" (src),
-		  "m" (sum), "m" (dst_step), "m" (src_step),
-		  "m" (sum_step), "m" (old_ebx)
-		: "esi", "edi", "edx", "ecx", "eax"
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %1, %%ebx\n",)
+
+		: "+&rm" (size), GCC_PIC_SWITCH("=m","=X") (old_ebx)
+		: "m" (dst), "m" (src), "m" (sum),
+		  "im" (dst_step), "im" (src_step), "im" (sum_step)
+		: "esi", "edi", "edx", "ecx", GCC_PIC_SWITCH(,"ebx"COMMA) "eax",
+		  "memory", "cc",
+#               ifdef HAVE_MMX
+		  "mm0", "mm1"
+#               else
+		  "st", "st(1)", "st(2)", "st(3)",
+		  "st(4)", "st(5)", "st(6)", "st(7)"
+#               endif
 	);
 }
 
@@ -261,13 +279,14 @@ static void MIX_AREAS_32(unsigned int size,
 	__asm__ __volatile__ (
 		"\n"
 
-		"\tmovl %%ebx, %7\n"	/* ebx is GOT pointer (-fPIC) */
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %%ebx, %1\n",)
 		/*
 		 *  initialization, load ESI, EDI, EBX registers
 		 */
-		"\tmovl %1, %%edi\n"
-		"\tmovl %2, %%esi\n"
-		"\tmovl %3, %%ebx\n"
+		"\tmovl %2, %%edi\n"
+		"\tmovl %3, %%esi\n"
+		"\tmovl %4, %%ebx\n"
 		"\tcmpl $0, %0\n"
 		"\tjnz 1f\n"
 		"\tjmp 6f\n"
@@ -337,19 +356,20 @@ static void MIX_AREAS_32(unsigned int size,
 		 */
 		"\tdecl %0\n"
 		"\tjz 6f\n"
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tadd %5, %%edi\n"
+		"\tadd %6, %%esi\n"
+		"\tadd %7, %%ebx\n"
 		"\tjmp 1b\n"
-		
-		"6:"
-		"\tmovl %7, %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 
-		: /* no output regs */
-		: "m" (size), "m" (dst), "m" (src),
-		  "m" (sum), "m" (dst_step), "m" (src_step),
-		  "m" (sum_step), "m" (old_ebx)
-		: "esi", "edi", "edx", "ecx", "eax"
+		"6:"
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %1, %%ebx\n",)
+
+		: "+&rm" (size), GCC_PIC_SWITCH("=m","=X") (old_ebx)
+		: "m" (dst), "m" (src), "m" (sum),
+		  "im" (dst_step), "im" (src_step), "im" (sum_step)
+		: "esi", "edi", "edx", "ecx", GCC_PIC_SWITCH(,"ebx"COMMA) "eax",
+		  "memory", "cc"
 	);
 }
 
@@ -374,13 +394,14 @@ static void MIX_AREAS_24(unsigned int size,
 	__asm__ __volatile__ (
 		"\n"
 
-		"\tmovl %%ebx, %7\n"	/* ebx is GOT pointer (-fPIC) */
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %%ebx, %1\n",)
 		/*
 		 *  initialization, load ESI, EDI, EBX registers
 		 */
-		"\tmovl %1, %%edi\n"
-		"\tmovl %2, %%esi\n"
-		"\tmovl %3, %%ebx\n"
+		"\tmovl %2, %%edi\n"
+		"\tmovl %3, %%esi\n"
+		"\tmovl %4, %%ebx\n"
 		"\tcmpl $0, %0\n"
 		"\tjnz 1f\n"
 		"\tjmp 6f\n"
@@ -443,19 +464,20 @@ static void MIX_AREAS_24(unsigned int size,
 		 */
 		"\tdecl %0\n"
 		"\tjz 6f\n"
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tadd %5, %%edi\n"
+		"\tadd %6, %%esi\n"
+		"\tadd %7, %%ebx\n"
 		"\tjmp 1b\n"
-		
-		"6:"
-		"\tmovl %7, %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 
-		: /* no output regs */
-		: "m" (size), "m" (dst), "m" (src),
-		  "m" (sum), "m" (dst_step), "m" (src_step),
-		  "m" (sum_step), "m" (old_ebx)
-		: "esi", "edi", "edx", "ecx", "eax"
+		"6:"
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %1, %%ebx\n",)
+
+		: "+&rm" (size), GCC_PIC_SWITCH("=m","=X") (old_ebx)
+		: "m" (dst), "m" (src), "m" (sum),
+		  "im" (dst_step), "im" (src_step), "im" (sum_step)
+		: "esi", "edi", "edx", "ecx", GCC_PIC_SWITCH(,"ebx"COMMA) "eax",
+		  "memory", "cc"
 	);
 }
 
@@ -480,13 +502,14 @@ static void MIX_AREAS_24_CMOV(unsigned int size,
 	__asm__ __volatile__ (
 		"\n"
 
-		"\tmovl %%ebx, %7\n"	/* ebx is GOT pointer (-fPIC) */
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %%ebx, %1\n",)
 		/*
 		 *  initialization, load ESI, EDI, EBX registers
 		 */
-		"\tmovl %1, %%edi\n"
-		"\tmovl %2, %%esi\n"
-		"\tmovl %3, %%ebx\n"
+		"\tmovl %2, %%edi\n"
+		"\tmovl %3, %%esi\n"
+		"\tmovl %4, %%ebx\n"
 		"\tcmpl $0, %0\n"
 		"\tjz 6f\n"
 
@@ -541,19 +564,20 @@ static void MIX_AREAS_24_CMOV(unsigned int size,
 		/*
 		 * while (size-- > 0)
 		 */
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tadd %5, %%edi\n"
+		"\tadd %6, %%esi\n"
+		"\tadd %7, %%ebx\n"
 		"\tdecl %0\n"
 		"\tjnz 1b\n"
-		
-		"6:"
-		"\tmovl %7, %%ebx\n"	/* ebx is GOT pointer (-fPIC) */
 
-		: /* no output regs */
-		: "m" (size), "m" (dst), "m" (src),
-		  "m" (sum), "m" (dst_step), "m" (src_step),
-		  "m" (sum_step), "m" (old_ebx)
-		: "esi", "edi", "edx", "ecx", "eax"
+		"6:"
+		/* ebx is GOT pointer (-fPIC) */
+		GCC_PIC_SWITCH("\tmovl %1, %%ebx\n",)
+
+		: "+&rm" (size), GCC_PIC_SWITCH("=m","=X") (old_ebx)
+		: "m" (dst), "m" (src), "m" (sum),
+		  "im" (dst_step), "im" (src_step), "im" (sum_step)
+		: "esi", "edi", "edx", "ecx", GCC_PIC_SWITCH(,"ebx"COMMA) "eax",
+		  "memory", "cc"
 	);
 }
-- 
2.17.1

