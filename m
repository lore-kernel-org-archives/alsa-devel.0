Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7952CC33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:51:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6DB20866
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fgGgC9D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6DB20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27B44178B;
	Sun,  5 Jan 2020 15:50:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27B44178B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578235872;
	bh=NJxRqFbPzOci2bjybZhgAMDpbKqm0voqhD6vAjtmiLo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fgGgC9D6pBSjl20BO2ZsK/2DhmO3D0AXSu0nUShthApybpet8ggJS5rH3YLoKqSrO
	 iSCFq/GfDGS6KOvJbqoHxw83g4Hk0owl9V7AdHaS7xnGNYMdFmYZ1N2Kmku0MhHEys
	 5/+iDLUKyFuGhSJF0zxOuNEaOfLfwdj3W1mA5NJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45DC9F80308;
	Sun,  5 Jan 2020 15:48:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2960F80307; Sun,  5 Jan 2020 15:48:41 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD3CDF8014A
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD3CDF8014A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9AB43AC3C
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:31 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:16 +0100
Message-Id: <20200105144823.29547-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 01/68] ALSA: Allow const arrays for legacy
	resource management helpers
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

Declare the arrays passed to the helper functions for legacy resources
(mostly for ISA drivers) as const, so that each caller can make its
static data as const for minor optimizations, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/initval.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/initval.h b/include/sound/initval.h
index 3ddae2b4177e..a1ff3b4865b4 100644
--- a/include/sound/initval.h
+++ b/include/sound/initval.h
@@ -37,7 +37,7 @@
 #define SNDRV_DEFAULT_PTR	SNDRV_DEFAULT_STR
 
 #ifdef SNDRV_LEGACY_FIND_FREE_IOPORT
-static long snd_legacy_find_free_ioport(long *port_table, long size)
+static long snd_legacy_find_free_ioport(const long *port_table, long size)
 {
 	while (*port_table != -1) {
 		if (request_region(*port_table, size, "ALSA test")) {
@@ -58,7 +58,7 @@ static irqreturn_t snd_legacy_empty_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int snd_legacy_find_free_irq(int *irq_table)
+static int snd_legacy_find_free_irq(const int *irq_table)
 {
 	while (*irq_table != -1) {
 		if (!request_irq(*irq_table, snd_legacy_empty_irq_handler,
@@ -74,7 +74,7 @@ static int snd_legacy_find_free_irq(int *irq_table)
 #endif
 
 #ifdef SNDRV_LEGACY_FIND_FREE_DMA
-static int snd_legacy_find_free_dma(int *dma_table)
+static int snd_legacy_find_free_dma(const int *dma_table)
 {
 	while (*dma_table != -1) {
 		if (!request_dma(*dma_table, "ALSA Test DMA")) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
