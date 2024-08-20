Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8615C3DA4A
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Aug 2024 13:45:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42ABC826;
	Tue, 20 Aug 2024 15:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42ABC826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724161541;
	bh=3y3kbVFUd9gvsIIuZEIRaTQlIljPGi/zVwSyj3Je7VQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pZOSQUYq+ibZ+mD8+Lc4XkGcO1b9pHwuprMAvCkpjp34mZ3wZDvXj9ePrj4kaqXem
	 kMUoiLNrSm7S8i5LjGvwBLiD+Jd9EQ/hvkdLkFhlN74+cW+oq5xke+23EdK12ELbzy
	 KVNLN92f/ZUuHamLJuI4HIKSaK0bXHPxQ3YR7t3E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D242EF805B4; Tue, 20 Aug 2024 15:45:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15205F805AD;
	Tue, 20 Aug 2024 15:45:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4472F80494; Tue, 20 Aug 2024 15:45:02 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 797C4F80107
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2024 15:44:56 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E96382E91;
	Tue, 20 Aug 2024 15:44:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E96382E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1724161495; bh=pMJ/jqUsNDthyJux6lBfdVItPujYym23/PnZsNDl69s=;
	h=From:To:Cc:Subject:Date:From;
	b=ndrTmtgH0b9vSjWkEyy7b5KxFH9re+1h5Kt5jc12wz8KAJWh6lL7N4DowjqqgjG1V
	 Su5eS8/8FVrKXFQkl10rna9Q2ThOUpum4qSL5vPkkjo1sqSbMqWrqj8+rYuIYn7F6Y
	 bUFjryvwWXak72PvNQ+gqFJLfb/JxWv3j98r84mo=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue, 20 Aug 2024 15:44:53 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-lib] pcm: implement snd_pcm_hw_params_get_sync() and
 obsolete snd_pcm_info_get_sync()
Date: Tue, 20 Aug 2024 15:44:49 +0200
Message-ID: <20240820134449.2622498-1-perex@perex.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IOL4LOJ7HICVOJNAHVEMSL4TVNSP22KY
X-Message-ID-Hash: IOL4LOJ7HICVOJNAHVEMSL4TVNSP22KY
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IOL4LOJ7HICVOJNAHVEMSL4TVNSP22KY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use the new clock source mechanism to get information about
similar PCM clock sources for PCM streams.

Link: https://lore.kernel.org/linux-sound/20240625172836.589380-1-perex@perex.cz/
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 include/pcm.h               |  4 ++++
 include/sound/uapi/asound.h |  3 ++-
 src/pcm/pcm.c               | 30 ++++++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index 102ff812..b5c67889 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -508,6 +508,9 @@ typedef union _snd_pcm_sync_id {
 	unsigned int id32[4];
 } snd_pcm_sync_id_t;
 
+/** synchronization ID size (see snd_pcm_hw_params_get_sync) */
+#define SND_PCM_HW_PARAMS_SYNC_SIZE	16
+
 /** Infinite wait for snd_pcm_wait() */
 #define SND_PCM_WAIT_INFINITE		(-1)
 /** Wait for next i/o in snd_pcm_wait() */
@@ -747,6 +750,7 @@ int snd_pcm_hw_params_get_rate_numden(const snd_pcm_hw_params_t *params,
 				      unsigned int *rate_den);
 int snd_pcm_hw_params_get_sbits(const snd_pcm_hw_params_t *params);
 int snd_pcm_hw_params_get_fifo_size(const snd_pcm_hw_params_t *params);
+const unsigned char * snd_pcm_hw_params_get_sync(const snd_pcm_hw_params_t *params);
 
 #if 0
 typedef struct _snd_pcm_hw_strategy snd_pcm_hw_strategy_t;
diff --git a/include/sound/uapi/asound.h b/include/sound/uapi/asound.h
index f3b2b94d..012fd890 100644
--- a/include/sound/uapi/asound.h
+++ b/include/sound/uapi/asound.h
@@ -426,7 +426,8 @@ struct snd_pcm_hw_params {
 	unsigned int rate_num;		/* R: rate numerator */
 	unsigned int rate_den;		/* R: rate denominator */
 	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
-	unsigned char reserved[64];	/* reserved for future */
+	unsigned char sync[16];         /* R: synchronization ID (perfect sync - one clock source) */
+	unsigned char reserved[48];	/* reserved for future */
 };
 
 enum {
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 62e76e7e..f8581191 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -494,8 +494,8 @@ software parameter.
 There are two functions allowing link multiple streams together. In the
 case, the linking means that all operations are synchronized. Because the
 drivers cannot guarantee the synchronization (sample resolution) on hardware
-lacking this feature, the #snd_pcm_info_get_sync() function
-returns synchronization ID - #snd_pcm_sync_id_t, which is equal
+lacking this feature, the #snd_pcm_hw_params_get_sync() function
+returns 16-byte synchronization ID, which is equal
 for hardware synchronized streams. When the #snd_pcm_link()
 function is called, all operations managing the stream state for these two
 streams are joined. The opposite function is #snd_pcm_unlink().
@@ -3948,6 +3948,25 @@ int snd_pcm_hw_params_get_fifo_size(const snd_pcm_hw_params_t *params)
 	return params->fifo_size;
 }
 
+/**
+ * \brief Get hardware synchronization ID from a PCM info container
+ * \param params Configuration space
+ * \return 16-byte synchronization ID (use #SND_PCM_HW_PARAMS_SYNC_SIZE)
+ *
+ * This synchronization ID determines the similar clocks for the
+ * PCM stream between multiple devices (including different cards).
+ * "All zeros" means "not set". The contents of the ID can be used
+ * only for a comparison with the contents of another ID returned
+ * from this function. Applications should not do a comparison with
+ * hard-coded values, because the implementation generating such
+ * synchronization IDs may be changed in future.
+ */
+const unsigned char *snd_pcm_hw_params_get_sync(const snd_pcm_hw_params_t *params)
+{
+	assert(params);
+	return params->sync;
+}
+
 /**
  * \brief Fill params with a full configuration space for a PCM
  * \param pcm PCM handle
@@ -7332,7 +7351,7 @@ unsigned int snd_pcm_info_get_subdevices_avail(const snd_pcm_info_t *obj)
 }
 
 /**
- * \brief Get hardware synchronization ID from a PCM info container
+ * \brief (DEPRECATED) Get hardware synchronization ID from a PCM info container
  * \param obj PCM info container
  * \return hardware synchronization ID
  */
@@ -7340,9 +7359,12 @@ snd_pcm_sync_id_t snd_pcm_info_get_sync(const snd_pcm_info_t *obj)
 {
 	snd_pcm_sync_id_t res;
 	assert(obj);
-	memcpy(&res, &obj->sync, sizeof(res));
+	bzero(&res, sizeof(res));
 	return res;
 }
+#ifndef DOC_HIDDEN
+link_warning(snd_pcm_info_get_sync, "Warning: snd_pcm_info_get_sync is deprecated, consider to use snd_pcm_hw_params_get_sync");
+#endif
 
 /**
  * \brief Set wanted device inside a PCM info container (see #snd_ctl_pcm_info)
-- 
2.45.2

