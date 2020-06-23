Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A8C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:51:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D512073E
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uN+lKEhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D512073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86C5417A7;
	Tue, 23 Jun 2020 17:50:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86C5417A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592927484;
	bh=dS4rt7CJcy8P1xBC8m2qBteO1gXgiIT94M6HPBtbY9o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uN+lKEhpDxmg0SeBM5W8PDRQOCBwkgYizxjzzl2n1t3+P6lB87z1JTUiVvKUqav+g
	 vMXIseiFvpBeTXyxJb0oHB1dVZ1O8uLUxRbu1g5uRNls9YJCdt1AIbIrgR8Os+qRAG
	 2vg8oeDTvgnSd+MoFxYg5tg8+6NpXiRVEB5Kiy7c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BD72F80291;
	Tue, 23 Jun 2020 17:49:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33FD9F80249; Tue, 23 Jun 2020 17:49:40 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6158BF800B2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 17:49:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6158BF800B2
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5C8FFB03A
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 15:49:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib v2 2/2] pcm: dmix: Fix semaphore usage with lockless
 operation
Date: Tue, 23 Jun 2020 17:49:31 +0200
Message-Id: <20200623154931.27755-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200623154931.27755-1-tiwai@suse.de>
References: <20200623154931.27755-1-tiwai@suse.de>
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

As Maarten Baert recently reported, the current dmix code applies the
semaphore unnecessarily around mixing streams even when the lockless
mix operation is used on x86.  This was rather introduced mistakenly
at the commit 267d7c728196 ("Add support of little-endian on
i386/x86_64 dmix") where the generic dmix code was included on x86,
too.

For achieving the original performance back, this patch changes the
semaphore handling to be checked at run time instead of statically at
compile time.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.h       |  1 +
 src/pcm/pcm_dmix.c         | 18 +++++++++++-------
 src/pcm/pcm_dmix_generic.c |  2 +-
 src/pcm/pcm_dmix_i386.c    |  1 +
 src/pcm/pcm_dmix_x86_64.c  |  1 +
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 8a236970a3a1..2150bce15449 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -186,6 +186,7 @@ struct snd_pcm_direct {
 			mix_areas_32_t *remix_areas_32;
 			mix_areas_24_t *remix_areas_24;
 			mix_areas_u8_t *remix_areas_u8;
+			unsigned int use_sem;
 		} dmix;
 		struct {
 			unsigned long long chn_mask;
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 843fa3168756..e9343b19a536 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -292,13 +292,17 @@ static void remix_areas(snd_pcm_direct_t *dmix,
  * the area via semaphore
  */
 #ifndef DOC_HIDDEN
-#ifdef NO_CONCURRENT_ACCESS
-#define dmix_down_sem(dmix) snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT)
-#define dmix_up_sem(dmix) snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT)
-#else
-#define dmix_down_sem(dmix)
-#define dmix_up_sem(dmix)
-#endif
+static void dmix_down_sem(snd_pcm_direct_t *dmix)
+{
+	if (dmix->u.dmix.use_sem)
+		snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
+}
+
+static void dmix_up_sem(snd_pcm_direct_t *dmix)
+{
+	if (dmix->u.dmix.use_sem)
+		snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
+}
 #endif
 
 /*
diff --git a/src/pcm/pcm_dmix_generic.c b/src/pcm/pcm_dmix_generic.c
index 40c08747a74a..8a5b6f148556 100644
--- a/src/pcm/pcm_dmix_generic.c
+++ b/src/pcm/pcm_dmix_generic.c
@@ -43,7 +43,6 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #ifndef ARCH_ADD
 #define ARCH_ADD(p,a) (*(p) += (a))
 #define ARCH_CMPXCHG(p,a,b) (*(p)) /* fake */
-#define NO_CONCURRENT_ACCESS	/* use semaphore to avoid race */
 #define IS_CONCURRENT	0	/* no race check */
 #endif
 
@@ -530,6 +529,7 @@ static void generic_mix_select_callbacks(snd_pcm_direct_t *dmix)
 	dmix->u.dmix.mix_areas_u8 = generic_mix_areas_u8;
 	dmix->u.dmix.remix_areas_24 = generic_remix_areas_24;
 	dmix->u.dmix.remix_areas_u8 = generic_remix_areas_u8;
+	dmix->u.dmix.use_sem = 1;
 }
 
 #endif
diff --git a/src/pcm/pcm_dmix_i386.c b/src/pcm/pcm_dmix_i386.c
index 1ab983a8a373..82a91c5c2897 100644
--- a/src/pcm/pcm_dmix_i386.c
+++ b/src/pcm/pcm_dmix_i386.c
@@ -135,4 +135,5 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 		dmix->u.dmix.mix_areas_24 = smp > 1 ? mix_areas_24_smp: mix_areas_24;
 		dmix->u.dmix.remix_areas_24 = smp > 1 ? remix_areas_24_smp: remix_areas_24;
 	}
+	dmix->u.dmix.use_sem = 0;
 }
diff --git a/src/pcm/pcm_dmix_x86_64.c b/src/pcm/pcm_dmix_x86_64.c
index 34c40d4e9d1d..4d882bfd01bf 100644
--- a/src/pcm/pcm_dmix_x86_64.c
+++ b/src/pcm/pcm_dmix_x86_64.c
@@ -102,4 +102,5 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 	dmix->u.dmix.remix_areas_32 = smp > 1 ? remix_areas_32_smp : remix_areas_32;
 	dmix->u.dmix.mix_areas_24 = smp > 1 ? mix_areas_24_smp : mix_areas_24;
 	dmix->u.dmix.remix_areas_24 = smp > 1 ? remix_areas_24_smp : remix_areas_24;
+	dmix->u.dmix.use_sem = 0;
 }
-- 
2.16.4

