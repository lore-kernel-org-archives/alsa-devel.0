Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC100C47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 08:17:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD0761029
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 08:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0761029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE6A9168F;
	Mon,  7 Jun 2021 10:17:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE6A9168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623053875;
	bh=FSmv/IaGdedwb3zB6fHJcoqACxfAQKGAKE7wjkfOiYk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRzqgvNohN+vjHXCnasy5LNy7Jtco+q6V9SMHRsy7IEaGnKBl8kZn0Z0kxC4nmWBg
	 q7ToPTIQ6vGN1G38TKMSStIUgW0SXxj08xFacJg7xy3XXKL3N9TBFnmAmZrudtmpY7
	 F/kcj+cv7pJazu3AKX3P85dQAEGPdSf1h9BLZWXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9474EF8050F;
	Mon,  7 Jun 2021 10:13:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89FEFF804FF; Mon,  7 Jun 2021 10:13:26 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B334F804C2
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 10:13:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B334F804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="TiaaCe8R"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="DNiCdSnJ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 811525C0166;
 Mon,  7 Jun 2021 04:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 07 Jun 2021 04:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=DZ3n0ba2RGFil
 /F3MIplbLvjz3DDmqaD1X4BbdIq/ho=; b=TiaaCe8R2z1M81q5PzGxlyiNV6gVU
 S1Lf9zfBSj09rvYh+Z9NPjCBtqsq4Jch3upDs9VDCaQVKsMXfILcrzdmJPsyJ66W
 yk+DpOa8dJnQxhv+j/seaTq6T/TRyG25SaQQc0Ybl+qkJLA49hkE4rIq+UXbMURa
 mi1Bm4uUUMdzdsgvYQvSEvpYazGIbezB4mcBw3WFubsE34M3YIN89/I5HuSSAg5E
 1VcwMfSuvj+yhxocrvby/KPJ6tOdXu/iyPM3gqr1n76woJ4A5Pgi8Md18ddvXv6C
 QhHfGo9G+gwuDLi1MSYGYGIANelNg/bz3ox42Mv8iOoovGM+Bmx9pHNlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=DZ3n0ba2RGFil/F3MIplbLvjz3DDmqaD1X4BbdIq/ho=; b=DNiCdSnJ
 6PYEE74ton5CR3tkU9ttjqgpPDiM6FPn3zZmFbra82uwCRaxaPfP+P4G5FTft42s
 aXyWIpaLFPmV4mOL+/bKdt/rxXFDU1PFFS0Ouh/7bTPm1ttqMqD9HeP0a/VphgKn
 o6ykBEWcMelHF2hueeo/YUIIEcKF1XJm/gdiltSWOtV2TVmztay9ZP8Dkd9LDd96
 7icjFA4tVaQGREa4O+jmOvbdS/sQAl78WjBZLQxHa2KsyTmJXnETJYstMKwVgWQp
 Mg2RBP4uyS0b1NmHQxkfyjU1KaO8x2up0pN5bSLh/NuojIcKRp11CSWqekFtxq0X
 3uuTC2TMkO5XtA==
X-ME-Sender: <xms:EtW9YHitYHOgNDUHyw8gxDsD9TCqdbMGubK-EPtMY9INace4wTBwCQ>
 <xme:EtW9YEDImT5PHvWleoIsBT1fZWEAq3QU_g1iM4Dr11y94q4QNXZTBI57dQG7y_RUm
 luwrrrUh2gWRJuvNvM>
X-ME-Received: <xmr:EtW9YHEbxOOVlCZGBZ3vXDCzzW1L_FRcyw-TbaYVPVRaNC6Pg4AJPlHCHVwTEmCBFmU4wnbCBLcXK492yY8LSmUDQEXSDGLpYsIEtth6cNQghi5HP-TJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjecutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertd
 dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeektefgve
 egfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghrufhi
 iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
 hmohgttghhihdrjhhp
X-ME-Proxy: <xmx:EtW9YEShNrohIDbw1Dq_SRkGrHYD1AjuvY0XOQwaI05kYlFGvWvEhQ>
 <xmx:EtW9YEyGGT2njl4CNu4qn5wf8khC1hCqN0x565XZAB6QEL-jv5CyMw>
 <xmx:EtW9YK4SfSm0NgmYCq7iWryOk3lt_BG1WsyUuCx5i1FZCGtozAQPGQ>
 <xmx:EtW9YBoRX5VsT1ic58mGjzTnFWYMSli76H1G99zRyuBU_ErAgCibhA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 04:13:05 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 7/9] ALSA: firewire-motu: cease from delayed card registration
Date: Mon,  7 Jun 2021 17:12:48 +0900
Message-Id: <20210607081250.13397-8-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210607081250.13397-1-o-takashi@sakamocchi.jp>
References: <20210607081250.13397-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

The delayed registration of sound card instance brings less benefit than
complication of kobject management. This commit ceases from it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 84 ++++++++++++--------------------------
 sound/firewire/motu/motu.h |  3 --
 2 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 2a8a6ea2d3f1..531eeb36eb87 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -57,22 +57,31 @@ static void motu_card_free(struct snd_card *card)
 
 	snd_motu_transaction_unregister(motu);
 	snd_motu_stream_destroy_duplex(motu);
+
+	mutex_destroy(&motu->mutex);
+	fw_unit_put(motu->unit);
 }
 
-static void do_registration(struct work_struct *work)
+static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *entry)
 {
-	struct snd_motu *motu = container_of(work, struct snd_motu, dwork.work);
+	struct snd_card *card;
+	struct snd_motu *motu;
 	int err;
 
-	if (motu->registered)
-		return;
-
-	err = snd_card_new(&motu->unit->device, -1, NULL, THIS_MODULE, 0,
-			   &motu->card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE, sizeof(*motu), &card);
 	if (err < 0)
-		return;
-	motu->card->private_free = motu_card_free;
-	motu->card->private_data = motu;
+		return err;
+	card->private_free = motu_card_free;
+
+	motu = card->private_data;
+	motu->unit = fw_unit_get(unit);
+	dev_set_drvdata(&unit->device, motu);
+	motu->card = card;
+
+	motu->spec = (const struct snd_motu_spec *)entry->driver_data;
+	mutex_init(&motu->mutex);
+	spin_lock_init(&motu->lock);
+	init_waitqueue_head(&motu->hwdep_wait);
 
 	name_card(motu);
 
@@ -103,71 +112,28 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(motu->card);
+	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
 
-	motu->registered = true;
-
-	return;
-error:
-	snd_card_free(motu->card);
-	dev_info(&motu->unit->device,
-		 "Sound card registration failed: %d\n", err);
-}
-
-static int motu_probe(struct fw_unit *unit,
-		      const struct ieee1394_device_id *entry)
-{
-	struct snd_motu *motu;
-
-	/* Allocate this independently of sound card instance. */
-	motu = devm_kzalloc(&unit->device, sizeof(struct snd_motu), GFP_KERNEL);
-	if (!motu)
-		return -ENOMEM;
-	motu->unit = fw_unit_get(unit);
-	dev_set_drvdata(&unit->device, motu);
-
-	motu->spec = (const struct snd_motu_spec *)entry->driver_data;
-	mutex_init(&motu->mutex);
-	spin_lock_init(&motu->lock);
-	init_waitqueue_head(&motu->hwdep_wait);
-
-	/* Allocate and register this sound card later. */
-	INIT_DEFERRABLE_WORK(&motu->dwork, do_registration);
-	snd_fw_schedule_registration(unit, &motu->dwork);
-
 	return 0;
+error:
+	snd_card_free(card);
+	return err;
 }
 
 static void motu_remove(struct fw_unit *unit)
 {
 	struct snd_motu *motu = dev_get_drvdata(&unit->device);
 
-	/*
-	 * Confirm to stop the work for registration before the sound card is
-	 * going to be released. The work is not scheduled again because bus
-	 * reset handler is not called anymore.
-	 */
-	cancel_delayed_work_sync(&motu->dwork);
-
-	if (motu->registered) {
-		// Block till all of ALSA character devices are released.
-		snd_card_free(motu->card);
-	}
-
-	mutex_destroy(&motu->mutex);
-	fw_unit_put(motu->unit);
+	// Block till all of ALSA character devices are released.
+	snd_card_free(motu->card);
 }
 
 static void motu_bus_update(struct fw_unit *unit)
 {
 	struct snd_motu *motu = dev_get_drvdata(&unit->device);
 
-	/* Postpone a workqueue for deferred registration. */
-	if (!motu->registered)
-		snd_fw_schedule_registration(unit, &motu->dwork);
-
 	/* The handler address register becomes initialized. */
 	snd_motu_transaction_reregister(motu);
 }
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 674e3dc4e45d..c5c0e446deb2 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -54,9 +54,6 @@ struct snd_motu {
 	struct mutex mutex;
 	spinlock_t lock;
 
-	bool registered;
-	struct delayed_work dwork;
-
 	/* Model dependent information. */
 	const struct snd_motu_spec *spec;
 
-- 
2.27.0

