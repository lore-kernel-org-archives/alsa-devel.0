From: leitao@debian.org
Subject: [PATCH] aserver: fix building on ppc64le
Date: Wed, 22 Feb 2017 16:45:00 -0300
Message-ID: <1487792700-25592-1-git-send-email-leitao@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by alsa0.perex.cz (Postfix) with ESMTP id AD470266E3A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 20:45:13 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MJcUAm119727
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 14:45:12 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28sau3k5bt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 14:45:12 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <alsa-devel@alsa-project.org> from <leitao@debian.org>;
 Wed, 22 Feb 2017 16:45:10 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 532133520068
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 14:44:33 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MJj61e20840466
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 16:45:07 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MJj6c9019417
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 16:45:06 -0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Breno Leitao <leitao@debian.org>
List-Id: alsa-devel@alsa-project.org

From: Breno Leitao <leitao@debian.org>

Currently aserver fails to build when using parameter
--without-versioned, due to an workaround for ppc64
(06221f86d207cb33ddd4867ca5301eeb247c4400).  This workaround is
not required anymore on the ppc64 ABI v2, and, in fact is breaking the
compilation. Reverting this commit

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/alsa-symbols.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/alsa-symbols.h b/include/alsa-symbols.h
index 51cb982..eeacfdb 100644
--- a/include/alsa-symbols.h
+++ b/include/alsa-symbols.h
@@ -29,19 +29,10 @@
 #define INTERNAL_CONCAT2_2(Pre, Post) Pre##Post
 #define INTERNAL(Name) INTERNAL_CONCAT2_2(__, Name)
 
-#ifdef __powerpc64__
-# define symbol_version(real, name, version) 			\
-	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@" #version);	\
-	__asm__ (".symver ." ASM_NAME(#real) ",." ASM_NAME(#name) "@" #version)
-# define default_symbol_version(real, name, version) 		\
-	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@@" #version);	\
-	__asm__ (".symver ." ASM_NAME(#real) ",." ASM_NAME(#name) "@@" #version)
-#else
 # define symbol_version(real, name, version) \
 	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@" #version)
 # define default_symbol_version(real, name, version) \
 	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@@" #version)
-#endif
 
 #ifdef USE_VERSIONED_SYMBOLS
 #define use_symbol_version(real, name, version) \
@@ -50,13 +41,6 @@
 		default_symbol_version(real, name, version)
 #else
 #define use_symbol_version(real, name, version) /* nothing */
-#ifdef __powerpc64__
-#define use_default_symbol_version(real, name, version) \
-	__asm__ (".weak " ASM_NAME(#name)); 			\
-	__asm__ (".weak ." ASM_NAME(#name)); 			\
-	__asm__ (".set " ASM_NAME(#name) "," ASM_NAME(#real));		\
-	__asm__ (".set ." ASM_NAME(#name) ",." ASM_NAME(#real))
-#else
 #if defined(__alpha__) || defined(__mips__)
 #define use_default_symbol_version(real, name, version) \
         __asm__ (".weak " ASM_NAME(#name)); \
@@ -67,6 +51,5 @@
 	__asm__ (".set " ASM_NAME(#name) "," ASM_NAME(#real))
 #endif
 #endif
-#endif
 
 #endif /* __ALSA_SYMBOLS_H */
-- 
1.9.3
