Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D78C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:26:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E41122210
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E41122210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7E14174E;
	Wed, 23 Dec 2020 18:25:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7E14174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608744394;
	bh=bVPjvGl2aJrmftvy6AH+naYZLiG73n7geMHZqE6bdgY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oq5prUb/vVxLxu+QNZ+ntPpxSgwG1Yzw/sA2onjlYRrdTPkaokYeQP3ovRxDVONHa
	 nj29SdOOpb/QWVMM81L3o+bUNOG60OiIiRybe+s3cN/ajwC4wKyQJoGgZpIho6w6dY
	 5pJjzGtyhzBYjT/ErWzWr1LsSyqtILN3ZU9Cub2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17D6EF804D8;
	Wed, 23 Dec 2020 18:23:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81199F801EB; Wed, 23 Dec 2020 18:23:18 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFF23F800BC
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 18:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFF23F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="hKVZbEjQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=fYo0RobiqrqzECasl7opFEvOEWIw54kbWjgJoxjA1dA=; b=hKVZbEjQ11amBy+NDRwkqG6EoC
 RDqHeKEnCpZW2hXLEPYzpSJ6fznz3MN/jMWrgzB02jGcXf0PRMbmvoVlW6nWbfK2rfUkZQCm6+N3a
 8WZUvrITEpu/CzwPOIZz44mFJaCpF8ffWDBIdWdtM1wX6yG9wxm6KQSF53iS6/QoUWhUU5dvvsOBU
 qnih91ocCKrRuThtmQP0GjPWM6j9gRog2KYq0qOnLsoGSbxMQ7p/Yr8J1lGCg/BLD2cqvWzUE07J2
 Cy7KdIPC9ZXFndIQcW2unfxtTLl7fip9LwfZipPskQahG/cHnqNMqXH9ygO2m8/fOJ+9zrXBha+GG
 p8urzEpg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1ks7qo-000EtM-5Z; Wed, 23 Dec 2020 18:23:02 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
 by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1ks7qo-000Crk-2O; Wed, 23 Dec 2020 18:23:02 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 01/18] ALSA: core: Use DIV_ROUND_UP() instead of open-coding it
Date: Wed, 23 Dec 2020 18:22:12 +0100
Message-Id: <20201223172229.781-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26026/Wed Dec 23 13:53:03 2020)
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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

Use DIV_ROUND_UP() instead of open-coding it. This documents intent
and makes it more clear what is going on for the casual reviewer.

Generated using the following the Coccinelle semantic patch.

// <smpl>
@@
expression x, y;
@@
-(((x) + (y) - 1) / (y))
+DIV_ROUND_UP(x, y)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/core/control.c        | 4 ++--
 sound/core/seq/seq_memory.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 3b44378b9dec..1571c7f7c43b 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -836,7 +836,7 @@ static void fill_remaining_elem_value(struct snd_ctl_elem_value *control,
 {
 	size_t offset = value_sizes[info->type] * info->count;
 
-	offset = (offset + sizeof(u32) - 1) / sizeof(u32);
+	offset = DIV_ROUND_UP(offset, sizeof(u32));
 	memset32((u32 *)control->value.bytes.data + offset, pattern,
 		 sizeof(control->value) / sizeof(u32) - offset);
 }
@@ -928,7 +928,7 @@ static int sanity_check_elem_value(struct snd_card *card,
 
 	/* check whether the remaining area kept untouched */
 	offset = value_sizes[info->type] * info->count;
-	offset = (offset + sizeof(u32) - 1) / sizeof(u32);
+	offset = DIV_ROUND_UP(offset, sizeof(u32));
 	p = (u32 *)control->value.bytes.data + offset;
 	for (; offset < sizeof(control->value) / sizeof(u32); offset++, p++) {
 		if (*p != pattern) {
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 65db1a7c77b7..e245bb6ba533 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -290,7 +290,7 @@ int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
 	extlen = 0;
 	if (snd_seq_ev_is_variable(event)) {
 		extlen = event->data.ext.len & ~SNDRV_SEQ_EXT_MASK;
-		ncells = (extlen + sizeof(struct snd_seq_event) - 1) / sizeof(struct snd_seq_event);
+		ncells = DIV_ROUND_UP(extlen, sizeof(struct snd_seq_event));
 	}
 	if (ncells >= pool->total_elements)
 		return -ENOMEM;
-- 
2.20.1

