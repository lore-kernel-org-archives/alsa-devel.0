Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA2EC001E0
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Aug 2023 16:06:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7C5282A;
	Wed, 16 Aug 2023 18:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7C5282A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692201962;
	bh=FQe9VLDfVdRSl9wI/EZDxiX7gRbBjQeUFFFVYdsmsG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S8UWj8GFAV70YKZr+z/SavpOeY+6mWHvqB4+yxmMZVzIbW5OPIqxwY1FGvrZFzozl
	 P+4TGMAFLVGfFyZrRMKiirtQUK6zcZ3x4ao44Nrbq/C+JtYFkMy45QdgaQEMj4UQMo
	 QIHlzHs6xyKFID99Rc2SQvZmUTxLqJWpHJCU1yDo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40CDAF805C0; Wed, 16 Aug 2023 18:03:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 557E2F805B5;
	Wed, 16 Aug 2023 18:03:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5746F80587; Wed, 16 Aug 2023 18:03:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8ABE5F80290
	for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2023 18:02:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ABE5F80290
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=EnfwTQz1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=2E4UPoww
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40DCC21866;
	Wed, 16 Aug 2023 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1692201775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jib2xBRuDTapc67JM726oqyZiTwBwsXtCor6hQ+MqhE=;
	b=EnfwTQz1+PUlZ3V0T+3tGAbY8k8LGhOtlxaamlfWqoXn4g6leQGMmd4r1Kl5u+lyaR0N5w
	Gx+ClHtXVE3ShNzy0lEEo7KBiT4/acTxszGA9VhcQvDgZxBq+iCtOtKKfbc0Xks7CJiVLB
	RE39Yu75Tj/QswZ/miU1FmGTsZjE6IQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692201775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jib2xBRuDTapc67JM726oqyZiTwBwsXtCor6hQ+MqhE=;
	b=2E4UPowwzXWgxV/WL2U/+WGkvxypVEP//E3ZiwWBGLPxuwb4JR0/kk2ea6/FXyHteCP4Zu
	NMpF4a8Hjq2VrKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EBBD139F8;
	Wed, 16 Aug 2023 16:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WCuABi/z3GSNKQAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 16 Aug 2023 16:02:55 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Curtis Malainey <cujomalainey@google.com>
Subject: [PATCH RFC 1/9] ALSA: core: Introduce snd_device_alloc()
Date: Wed, 16 Aug 2023 18:02:44 +0200
Message-Id: <20230816160252.23396-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816160252.23396-1-tiwai@suse.de>
References: <20230816160252.23396-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Y4FI23PP7IHQSMU5BJVNIW5ISTTPSFUR
X-Message-ID-Hash: Y4FI23PP7IHQSMU5BJVNIW5ISTTPSFUR
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y4FI23PP7IHQSMU5BJVNIW5ISTTPSFUR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Introduce a new helper, snd_device_alloc(), for allocating a struct
device that is bound with the sound class.  It's a replacement of
snd_device_initialize().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  1 +
 sound/core/init.c    | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index f6e0dd648b80..f986fcc5f18f 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -239,6 +239,7 @@ extern struct dentry *sound_debugfs_root;
 
 void snd_request_card(int card);
 
+int snd_device_alloc(struct device **dev_p, struct snd_card *card);
 void snd_device_initialize(struct device *dev, struct snd_card *card);
 
 int snd_register_device(int type, struct snd_card *card, int dev,
diff --git a/sound/core/init.c b/sound/core/init.c
index baef2688d0cf..a4de9f00d90f 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -134,6 +134,37 @@ void snd_device_initialize(struct device *dev, struct snd_card *card)
 }
 EXPORT_SYMBOL_GPL(snd_device_initialize);
 
+/* the default release callback set in snd_device_alloc() */
+static void default_release_alloc(struct device *dev)
+{
+	kfree(dev);
+}
+
+/**
+ * snd_device_alloc - Allocate and initialize struct device for sound devices
+ * @dev_p: pointer to store the allocated device
+ * @card: card to assign, optional
+ *
+ * For releasing the allocated device, call put_device().
+ */
+int snd_device_alloc(struct device **dev_p, struct snd_card *card)
+{
+	struct device *dev;
+
+	*dev_p = NULL;
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	device_initialize(dev);
+	if (card)
+		dev->parent = &card->card_dev;
+	dev->class = &sound_class;
+	dev->release = default_release_alloc;
+	*dev_p = dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_device_alloc);
+
 static int snd_card_init(struct snd_card *card, struct device *parent,
 			 int idx, const char *xid, struct module *module,
 			 size_t extra_size);
-- 
2.35.3

