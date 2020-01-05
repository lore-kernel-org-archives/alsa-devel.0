Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA6C33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:04:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961EA2077B
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kvmqTkbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961EA2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFFAD17D1;
	Sun,  5 Jan 2020 16:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFFAD17D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578236685;
	bh=drCvC+ft9dW9ssTQ1L+XVhYrfGgixwegwcKJR1byJCw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kvmqTkbkc7PqW6vpeGprYzipYvVrEavfwEGj9gtdHxFORdGtZk4Z6fgwLq2Q22n+s
	 56GdzXuVNt6wShiwc2c1hqJbsqz5j7ZeI/45agEaB1OQkHxW68M88FiwFcgk4xZ7lV
	 UkM7o9Zbu9T8ECSYOouj/jRc5RfsKU1oQAPfCF8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7825CF803B2;
	Sun,  5 Jan 2020 15:49:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F0DDF8028F; Sun,  5 Jan 2020 15:49:10 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23BF0F8028F
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23BF0F8028F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2C725B286
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:33 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:46 +0100
Message-Id: <20200105144823.29547-32-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 31/68] ALSA: ctxfi: More constifications
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

Apply const prefix to each possible place: the DAIO tables and the
register offset table.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ctxfi/ctdaio.c     | 4 ++--
 sound/pci/ctxfi/ctresource.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 27441d498968..4cb47b5a792c 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -29,7 +29,7 @@ struct daio_rsc_idx {
 	unsigned short right;
 };
 
-static struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
+static const struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
 	[LINEO1] = {.left = 0x00, .right = 0x01},
 	[LINEO2] = {.left = 0x18, .right = 0x19},
 	[LINEO3] = {.left = 0x08, .right = 0x09},
@@ -40,7 +40,7 @@ static struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
 	[SPDIFI1] = {.left = 0x95, .right = 0x9d},
 };
 
-static struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
+static const struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
 	[LINEO1] = {.left = 0x40, .right = 0x41},
 	[LINEO2] = {.left = 0x60, .right = 0x61},
 	[LINEO3] = {.left = 0x50, .right = 0x51},
diff --git a/sound/pci/ctxfi/ctresource.c b/sound/pci/ctxfi/ctresource.c
index 0bb5696e44b3..61e51e35ba16 100644
--- a/sound/pci/ctxfi/ctresource.c
+++ b/sound/pci/ctxfi/ctresource.c
@@ -92,7 +92,7 @@ int mgr_put_resource(struct rsc_mgr *mgr, unsigned int n, unsigned int idx)
 	return 0;
 }
 
-static unsigned char offset_in_audio_slot_block[NUM_RSCTYP] = {
+static const unsigned char offset_in_audio_slot_block[NUM_RSCTYP] = {
 	/* SRC channel is at Audio Ring slot 1 every 16 slots. */
 	[SRC]		= 0x1,
 	[AMIXER]	= 0x4,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
