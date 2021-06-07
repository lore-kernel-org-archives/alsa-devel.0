Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8AFC47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 08:16:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379DC61208
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 08:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379DC61208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D962168F;
	Mon,  7 Jun 2021 10:15:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D962168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623053781;
	bh=bTfyxPCpvrtL7SzVNPnx5JrFqFzyOZ7f6KHBjOJdN80=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LmUpI3s+riGymWxz0P1FPUofVN2Os4T1R8QHEcL7e/wQ2OHrgF/G8uGoOuAyt8G3D
	 6xNHaxzTrosAnbQCcBzeJcOZgRiqenJfh/XDTr3Wiazca1aKf8LfYp3tN5+T14joo3
	 aVlBTAWlzM17xvZXYr726hELErGf5wu+plmEnYkY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52F8CF804E2;
	Mon,  7 Jun 2021 10:13:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5D50F804D0; Mon,  7 Jun 2021 10:13:19 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77182F8027C
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 10:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77182F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="RnFtjur1"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="vdw+AL3O"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id A77FE5C0121;
 Mon,  7 Jun 2021 04:13:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 07 Jun 2021 04:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=H1JpwNOLrPdvd
 SnUhjR3Jx2Ui1yXOQclDS0bL7vgzaE=; b=RnFtjur1lERzZ6VArIIparcoEGutW
 xi0uTgotSWqFdi1ETlBPGwTDht2FFoljUCWBSIXaAScvy15C+pOMswGVHzKxKMRg
 8VGK8vixG9h8dzCDDW+AvSgCkHd9SgTbF0PTRd1AVJt7tADJIO3BDfWDdko1C1bD
 QIdOMmi5nRguSrkr68hhnTFatzDBb0FT+ZMmfw+a9Opofe7cQAOg0omGr9+cXOyB
 SXP5zIMCotLM3rZNTvKrotAfNx7v/JmlvVHCCW7kOw25Ll4ZLsS7hvpRlyvnwKQN
 FdLaJ8wtE1WHslHdonImHA1TCfTV8SbjZCWeiv8tGEEpAwRH4X0qO7deA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=H1JpwNOLrPdvdSnUhjR3Jx2Ui1yXOQclDS0bL7vgzaE=; b=vdw+AL3O
 8EYomR1/6s9A5uhr90Ms25qpQhMJzpWj6aUyQcSOsIJbAY7q25EUWm4tRqsV9hDM
 2LlC/ZN1Y9ZxnIksg0RLS7Lv2BctlzSLx+dHXy538mNJggi+CAnT33gwjDWiZ/0N
 +qMFJwK1fRZV3QSy9zXnhqnVhrabRI1Kxz5JYtcqBV24NjZulAw/DZEh0mcgEJY+
 R/ZFLizFa6WNEgm8eICmAbJFIb8DeO/tiCkzlPFw2t9QqQjIBr0tSz7L+ASZ9GZ1
 68LM6q322Oq1kifqXvnKcLjO1nc7YiFBjolfLht+AXEIY6hx23rXmjxUFsC5MxZI
 IaPGbrYK5hT83w==
X-ME-Sender: <xms:DtW9YNKqeSE19Bmr23upDeci2mXhSAM6NYED7z5_rVhGGT0oKYaIiw>
 <xme:DtW9YJKD1G0N1DwRAQJR_ZePhmT3dBeGdU2rmQeRbNs5EbVS0oEcCCGo6UsjEzbiK
 hqqwhSPFZ8JW5LwAsY>
X-ME-Received: <xmr:DtW9YFuJqY8u3bhmyEsc6vgulQ8oKM2d_NR961NA5Bn-Lo6-8ZLEDMy37mRPhPwmmCrhWPByGQQHT4CYzNrw5p59uP-NftmGVGq2Le24Y0ZAQjYgqAsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjecutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertd
 dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeektefgve
 egfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
 hmohgttghhihdrjhhp
X-ME-Proxy: <xmx:DtW9YOapXkuOhaKHOfIubZGbSo3Y_ESATcpsz15E9ErZpMR71NNnfw>
 <xmx:DtW9YEa_PnQ6nucJyWn0sILMRZ_yze0evzzV8lZ6_jjHbwXhxF8UXg>
 <xmx:DtW9YCDx_mcuaKZu_6MLCti_Lao5jGFkAtU48O8YIcIwFNhrbWSIpQ>
 <xmx:DtW9YPzLTgaCZEKt7fNcpTtPwNoSlmdf-S-5JyV-MQJ0qcY0dj3FQQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 04:13:01 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 4/9] ALSA: dice: cease from delayed card registration
Date: Mon,  7 Jun 2021 17:12:45 +0900
Message-Id: <20210607081250.13397-5-o-takashi@sakamocchi.jp>
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
 sound/firewire/dice/dice.c | 138 +++++++++++++------------------------
 sound/firewire/dice/dice.h |   4 --
 2 files changed, 48 insertions(+), 94 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 239d164b0eea..f75902bc8e74 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -135,22 +135,51 @@ static void dice_card_free(struct snd_card *card)
 
 	snd_dice_stream_destroy_duplex(dice);
 	snd_dice_transaction_destroy(dice);
+
+	mutex_destroy(&dice->mutex);
+	fw_unit_put(dice->unit);
 }
 
-static void do_registration(struct work_struct *work)
+static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *entry)
 {
-	struct snd_dice *dice = container_of(work, struct snd_dice, dwork.work);
+	struct snd_card *card;
+	struct snd_dice *dice;
+	snd_dice_detect_formats_t detect_formats;
 	int err;
 
-	if (dice->registered)
-		return;
+	if (!entry->driver_data && entry->vendor_id != OUI_SSL) {
+		err = check_dice_category(unit);
+		if (err < 0)
+			return -ENODEV;
+	}
 
-	err = snd_card_new(&dice->unit->device, -1, NULL, THIS_MODULE, 0,
-			   &dice->card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE, sizeof(*dice), &card);
 	if (err < 0)
-		return;
-	dice->card->private_free = dice_card_free;
-	dice->card->private_data = dice;
+		return err;
+	card->private_free = dice_card_free;
+
+	dice = card->private_data;
+	dice->unit = fw_unit_get(unit);
+	dev_set_drvdata(&unit->device, dice);
+	dice->card = card;
+
+	if (!entry->driver_data)
+		detect_formats = snd_dice_stream_detect_current_formats;
+	else
+		detect_formats = (snd_dice_detect_formats_t)entry->driver_data;
+
+	// Below models are compliant to IEC 61883-1/6 and have no quirk at high sampling transfer
+	// frequency.
+	// * Avid M-Box 3 Pro
+	// * M-Audio Profire 610
+	// * M-Audio Profire 2626
+	if (entry->vendor_id == OUI_MAUDIO || entry->vendor_id == OUI_AVID)
+		dice->disable_double_pcm_frames = true;
+
+	spin_lock_init(&dice->lock);
+	mutex_init(&dice->mutex);
+	init_completion(&dice->clock_accepted);
+	init_waitqueue_head(&dice->hwdep_wait);
 
 	err = snd_dice_transaction_init(dice);
 	if (err < 0)
@@ -162,7 +191,7 @@ static void do_registration(struct work_struct *work)
 
 	dice_card_strings(dice);
 
-	err = dice->detect_formats(dice);
+	err = detect_formats(dice);
 	if (err < 0)
 		goto error;
 
@@ -184,105 +213,34 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(dice->card);
+	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
 
-	dice->registered = true;
-
-	return;
-error:
-	snd_card_free(dice->card);
-	dev_info(&dice->unit->device,
-		 "Sound card registration failed: %d\n", err);
-}
-
-static int dice_probe(struct fw_unit *unit,
-		      const struct ieee1394_device_id *entry)
-{
-	struct snd_dice *dice;
-	int err;
-
-	if (!entry->driver_data && entry->vendor_id != OUI_SSL) {
-		err = check_dice_category(unit);
-		if (err < 0)
-			return -ENODEV;
-	}
-
-	/* Allocate this independent of sound card instance. */
-	dice = devm_kzalloc(&unit->device, sizeof(struct snd_dice), GFP_KERNEL);
-	if (!dice)
-		return -ENOMEM;
-	dice->unit = fw_unit_get(unit);
-	dev_set_drvdata(&unit->device, dice);
-
-	if (!entry->driver_data) {
-		dice->detect_formats = snd_dice_stream_detect_current_formats;
-	} else {
-		dice->detect_formats =
-				(snd_dice_detect_formats_t)entry->driver_data;
-	}
-
-	// Below models are compliant to IEC 61883-1/6 and have no quirk at high sampling transfer
-	// frequency.
-	// * Avid M-Box 3 Pro
-	// * M-Audio Profire 610
-	// * M-Audio Profire 2626
-	if (entry->vendor_id == OUI_MAUDIO || entry->vendor_id == OUI_AVID)
-		dice->disable_double_pcm_frames = true;
-
-	spin_lock_init(&dice->lock);
-	mutex_init(&dice->mutex);
-	init_completion(&dice->clock_accepted);
-	init_waitqueue_head(&dice->hwdep_wait);
-
-	/* Allocate and register this sound card later. */
-	INIT_DEFERRABLE_WORK(&dice->dwork, do_registration);
-	snd_fw_schedule_registration(unit, &dice->dwork);
-
 	return 0;
+error:
+	snd_card_free(card);
+	return err;
 }
 
 static void dice_remove(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
-	/*
-	 * Confirm to stop the work for registration before the sound card is
-	 * going to be released. The work is not scheduled again because bus
-	 * reset handler is not called anymore.
-	 */
-	cancel_delayed_work_sync(&dice->dwork);
-
-	if (dice->registered) {
-		// Block till all of ALSA character devices are released.
-		snd_card_free(dice->card);
-	}
-
-	mutex_destroy(&dice->mutex);
-	fw_unit_put(dice->unit);
+	// Block till all of ALSA character devices are released.
+	snd_card_free(dice->card);
 }
 
 static void dice_bus_reset(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
-	/* Postpone a workqueue for deferred registration. */
-	if (!dice->registered)
-		snd_fw_schedule_registration(unit, &dice->dwork);
-
 	/* The handler address register becomes initialized. */
 	snd_dice_transaction_reinit(dice);
 
-	/*
-	 * After registration, userspace can start packet streaming, then this
-	 * code block works fine.
-	 */
-	if (dice->registered) {
-		mutex_lock(&dice->mutex);
-		snd_dice_stream_update_duplex(dice);
-		mutex_unlock(&dice->mutex);
-	}
+	mutex_lock(&dice->mutex);
+	snd_dice_stream_update_duplex(dice);
+	mutex_unlock(&dice->mutex);
 }
 
 #define DICE_INTERFACE	0x000001
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 3c967d1b3605..fd440cc625f9 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -78,9 +78,6 @@ struct snd_dice {
 	spinlock_t lock;
 	struct mutex mutex;
 
-	bool registered;
-	struct delayed_work dwork;
-
 	/* Offsets for sub-addresses */
 	unsigned int global_offset;
 	unsigned int rx_offset;
@@ -93,7 +90,6 @@ struct snd_dice {
 	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
 	unsigned int tx_midi_ports[MAX_STREAMS];
 	unsigned int rx_midi_ports[MAX_STREAMS];
-	snd_dice_detect_formats_t detect_formats;
 
 	struct fw_address_handler notification_handler;
 	int owner_generation;
-- 
2.27.0

