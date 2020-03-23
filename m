Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7165C3F2CD
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:08:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2904B20722
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nx6ngPyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2904B20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74DC11654;
	Mon, 23 Mar 2020 18:07:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74DC11654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584983319;
	bh=tZvgtYXKw9JI1ga0K/FmJNUJgpzYsMwmTczeuO/9R2c=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nx6ngPyx+Nr+4iV10rqOBKZzt8YH25c8SUUD7b3zxlvWy7/ttS3nryM6XmrT308yn
	 65zdl/ACyXMjcPSINIg7B7NC21AEXz5rJL0izZ+iAOJ9+F4WFhTQuDWyhkAQuYwKqs
	 31567TbBFYtTb0D1k5xfDNwwJJtGDKCOIDrf+fFM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5040F8015A;
	Mon, 23 Mar 2020 18:06:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3489F80158; Mon, 23 Mar 2020 18:06:52 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01628F800B9
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 18:06:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01628F800B9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 50EC9ABBE
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 17:06:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: core: Add snd_device_get_state() helper
Date: Mon, 23 Mar 2020 18:06:42 +0100
Message-Id: <20200323170643.19181-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

A new small helper to get the current state of the device registration
for the given object.  It'll be used for USB-audio driver to check the
delayed device registrations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  1 +
 sound/core/device.c  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index ac8b692b69b4..381a010a1bd4 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -266,6 +266,7 @@ void snd_device_disconnect(struct snd_card *card, void *device_data);
 void snd_device_disconnect_all(struct snd_card *card);
 void snd_device_free(struct snd_card *card, void *device_data);
 void snd_device_free_all(struct snd_card *card);
+int snd_device_get_state(struct snd_card *card, void *device_data);
 
 /* isadma.c */
 
diff --git a/sound/core/device.c b/sound/core/device.c
index cdc5af526739..bf0b04a7ee79 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -237,3 +237,24 @@ void snd_device_free_all(struct snd_card *card)
 	list_for_each_entry_safe_reverse(dev, next, &card->devices, list)
 		__snd_device_free(dev);
 }
+
+/**
+ * snd_device_get_state - Get the current state of the given device
+ * @card: the card instance
+ * @device_data: the data pointer to release
+ *
+ * Returns the current state of the given device object.  For the valid
+ * device, either @SNDRV_DEV_BUILD, @SNDRV_DEV_REGISTERED or
+ * @SNDRV_DEV_DISCONNECTED is returned.
+ * Or for a non-existing device, -1 is returned as an error.
+ */
+int snd_device_get_state(struct snd_card *card, void *device_data)
+{
+	struct snd_device *dev;
+
+	dev = look_for_dev(card, device_data);
+	if (dev)
+		return dev->state;
+	return -1;
+}
+EXPORT_SYMBOL_GPL(snd_device_get_state);
-- 
2.16.4

