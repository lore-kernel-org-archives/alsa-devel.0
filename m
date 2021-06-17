Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD653C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 13:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E766060BD3
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E766060BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8BA616F9;
	Thu, 17 Jun 2021 15:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8BA616F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623937728;
	bh=KJvuDO4iv96euylTD7TmKkdU3RjytlqMW2wrEddA/co=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BrQmH43fZukk9EH6BNESX/8wnKiuwAqJ1LTuK9PD9+Uk2W66gEFlob3+kKcSkNv9k
	 dS3dCjG6xCIbfSiwuqvR0hFWtLXxs5zhYz6L8AFr7/pyh+xigKh+hMnXUfCzepIfqJ
	 sgVi1sDwO5axTAA9Obrb7MYY+0f1yJYPGS46nv48=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F7BCF80171;
	Thu, 17 Jun 2021 15:47:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5ACD6F8025A; Thu, 17 Jun 2021 15:47:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D8FDF80088
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 15:47:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D8FDF80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="K+FOQgET"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="myoBqh9B"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3CB2D1FD7D;
 Thu, 17 Jun 2021 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623937664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k+3z6VHXaClhSLURpgtaBIfpJdIdS4Fmcv3ZxtlZxc4=;
 b=K+FOQgETJcHxyMJKMySI9XyDjjrALKzmBJXRaeHlrA38zH58FJOjlwFzlqUEPvQ7uEptvz
 /pYHhVp6+TNtcMNqVT4AQ+0TKYlkX3tZG1hHbzO7ANV57EsMPitFxgOJ791jg/5VYe2nNo
 hAXRMLqbgiv5/Hx7KDWkteQl9MpSGhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623937664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k+3z6VHXaClhSLURpgtaBIfpJdIdS4Fmcv3ZxtlZxc4=;
 b=myoBqh9BRkRXyeSmO1QaDzRhefbR2mNTVRbRtLhIq87wt6CC+jJdRYYwB3dB/l1tmH4UJY
 mkwRUCaFvu5HMfDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 2C2DBA3B99;
 Thu, 17 Jun 2021 13:47:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: seq: oss: Fix error check at system port creation
Date: Thu, 17 Jun 2021 15:47:42 +0200
Message-Id: <20210617134742.6321-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dan Carpenter <dan.carpenter@oracle.com>
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

The system port creation in ALSA OSS sequencer was wrongly checked
against to the port number that can be never negative.  The error code
should be checked rather against the ioctl call.

This patch corrects the error check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index a53d81a86af2..0ee4a5081fd6 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -94,11 +94,10 @@ snd_seq_oss_create_client(void)
 	port_callback.event_input = receive_announce;
 	port->kernel = &port_callback;
 	
-	call_ctl(SNDRV_SEQ_IOCTL_CREATE_PORT, port);
-	system_port = port->addr.port;
-	if (system_port >= 0) {
+	if (call_ctl(SNDRV_SEQ_IOCTL_CREATE_PORT, port) >= 0) {
 		struct snd_seq_port_subscribe subs;
 
+		system_port = port->addr.port;
 		memset(&subs, 0, sizeof(subs));
 		subs.sender.client = SNDRV_SEQ_CLIENT_SYSTEM;
 		subs.sender.port = SNDRV_SEQ_PORT_SYSTEM_ANNOUNCE;
-- 
2.26.2

