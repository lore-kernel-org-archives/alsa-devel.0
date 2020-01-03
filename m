Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89769C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D8521835
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Szn2y/eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D8521835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6801116DB;
	Fri,  3 Jan 2020 09:17:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6801116DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578039498;
	bh=zLOGjz9a4REOoQMamSXQ237JAIGhizMixlyiWIQW6EE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Szn2y/eqvavKvyxQrOFkhoJISZR97JS7ud/Fh1Kmm6xgR+1E8elT+xiGiFYyfrF3L
	 jNrS0nx/Pn04xuU4FkPBrdOn/oapGGxtpUhcYPsKJSqo4vkrRaViChZ04srOTc1phj
	 sQTGLV8v0CEqCzoz6v5I380JeIF2sSrFYYKFfjWg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D05DF802C2;
	Fri,  3 Jan 2020 09:17:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB2E4F8028B; Fri,  3 Jan 2020 09:17:24 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82839F8013E
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82839F8013E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AE00CB200
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:19 +0100
Message-Id: <20200103081714.9560-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 03/58] ALSA: core: Treat snd_device_ops as const
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

This is a preliminary patch to allow const for snd_device_ops
definitions in each driver's code.  The ops reference is read-only,
hence it can be declared as const for further optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h | 4 ++--
 sound/core/device.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index af3dce956c17..0e14b7a3e67b 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -69,7 +69,7 @@ struct snd_device {
 	enum snd_device_state state;	/* state of the device */
 	enum snd_device_type type;	/* device type */
 	void *device_data;		/* device structure */
-	struct snd_device_ops *ops;	/* operations */
+	const struct snd_device_ops *ops;	/* operations */
 };
 
 #define snd_device(n) list_entry(n, struct snd_device, list)
@@ -256,7 +256,7 @@ static inline void snd_card_unref(struct snd_card *card)
 /* device.c */
 
 int snd_device_new(struct snd_card *card, enum snd_device_type type,
-		   void *device_data, struct snd_device_ops *ops);
+		   void *device_data, const struct snd_device_ops *ops);
 int snd_device_register(struct snd_card *card, void *device_data);
 int snd_device_register_all(struct snd_card *card);
 void snd_device_disconnect(struct snd_card *card, void *device_data);
diff --git a/sound/core/device.c b/sound/core/device.c
index 708b91944de3..cdc5af526739 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -27,7 +27,7 @@
  * Return: Zero if successful, or a negative error code on failure.
  */
 int snd_device_new(struct snd_card *card, enum snd_device_type type,
-		   void *device_data, struct snd_device_ops *ops)
+		   void *device_data, const struct snd_device_ops *ops)
 {
 	struct snd_device *dev;
 	struct list_head *p;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
