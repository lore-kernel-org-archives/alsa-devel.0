Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9462C1B08C
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:01:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132006100C
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132006100C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86ABC167E;
	Thu, 15 Jul 2021 10:01:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86ABC167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626336111;
	bh=pPJ3QSnirnoKQ8jb7PixSL1owvBhNMgxbBRIhdPw/jE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQX1Q3FG2RmKHlTePWk/seaEy79dcJzVNgQ1PB/fKhm47UAD9noozfh3Lc/8X4Px/
	 U4bGY4Mpa1jbnAIyKJ1n9RT34EZH07W8aV2MH3ejdY+Zb9tFLtsg0tqLfHhfZsIAJe
	 56JDI2YyRqYeRnFQQaEAN3PZTDjbs/W1wV10h/pY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BD94F80430;
	Thu, 15 Jul 2021 10:00:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08F74F80515; Thu, 15 Jul 2021 10:00:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A70EF80430
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 09:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A70EF80430
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="WAO5Y2E+"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="+Myqk21k"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EE8521FDEA
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 07:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626335991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK4bm4W8Ju9sf7P7p+C4ZrlV4vlyx6xPwwho/sgk99s=;
 b=WAO5Y2E+sFaYRh1Pzy5CnGRHQ0pxNFNHdjDpBP5Gu88kwxe5qZgzI3hAJjX/chYed+1rCf
 UDPO+hSwRO23Na6df57/6HCBb3SX66MmcMtbG2s5tfmDatG4z1Y14h726T3kk9004t6af/
 OYk9OUqr/K2pKyP/WVYXg0TKTco2PbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626335991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK4bm4W8Ju9sf7P7p+C4ZrlV4vlyx6xPwwho/sgk99s=;
 b=+Myqk21knWFjOAKn7h1w+L1AwX0CLkPnAK1cLBRv0FUeqUQYbQhY9Wbs4khM65Td7TDe96
 ad2NSfXRAlbhOWAA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id DD717A3B8D;
 Thu, 15 Jul 2021 07:59:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 03/79] ALSA: core: Add device-managed request_dma()
Date: Thu, 15 Jul 2021 09:58:25 +0200
Message-Id: <20210715075941.23332-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715075941.23332-1-tiwai@suse.de>
References: <20210715075941.23332-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch adds a devres-supported helper for requesting an ISA DMA
channel that will be automatically freed at the device unbinding.
It'll be used by quite a few ISA sound drivers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  1 +
 sound/core/isadma.c  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index 7885f903cd5a..b7e9b58d3c78 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -329,6 +329,7 @@ int snd_device_get_state(struct snd_card *card, void *device_data);
 void snd_dma_program(unsigned long dma, unsigned long addr, unsigned int size, unsigned short mode);
 void snd_dma_disable(unsigned long dma);
 unsigned int snd_dma_pointer(unsigned long dma, unsigned int size);
+int snd_devm_request_dma(struct device *dev, int dma, const char *name);
 #endif
 
 /* misc.c */
diff --git a/sound/core/isadma.c b/sound/core/isadma.c
index c3d789ef6975..1f45ede023b4 100644
--- a/sound/core/isadma.c
+++ b/sound/core/isadma.c
@@ -97,3 +97,41 @@ unsigned int snd_dma_pointer(unsigned long dma, unsigned int size)
 		return size - result;
 }
 EXPORT_SYMBOL(snd_dma_pointer);
+
+struct snd_dma_data {
+	int dma;
+};
+
+static void __snd_release_dma(struct device *dev, void *data)
+{
+	struct snd_dma_data *p = data;
+
+	snd_dma_disable(p->dma);
+	free_dma(p->dma);
+}
+
+/**
+ * snd_devm_request_dma - the managed version of request_dma()
+ * @dev: the device pointer
+ * @dma: the dma number
+ * @name: the name string of the requester
+ *
+ * Returns zero on success, or a negative error code.
+ * The requested DMA will be automatically released at unbinding via devres.
+ */
+int snd_devm_request_dma(struct device *dev, int dma, const char *name)
+{
+	struct snd_dma_data *p;
+
+	if (request_dma(dma, name))
+		return -EBUSY;
+	p = devres_alloc(__snd_release_dma, sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		free_dma(dma);
+		return -ENOMEM;
+	}
+	p->dma = dma;
+	devres_add(dev, p);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_devm_request_dma);
-- 
2.26.2

