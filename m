From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: bebob/fireworks: simplify handling
	of local device entry table
Date: Wed, 10 Oct 2018 15:35:01 +0900
Message-ID: <20181010063502.4698-4-o-takashi@sakamocchi.jp>
References: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F33126795C
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 08:35:16 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so2001007pgv.13
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2018 23:35:16 -0700 (PDT)
In-Reply-To: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In drivers of ALSA firewire stack, bebob and fireworks drivers have
local device entry table. At present, critical section to operate the
table is from the beginning/end of 'do_registration' call. This can be
more narrow and simplify codes.

This commit applies small refactoring for the above purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         | 17 ++++++-----------
 sound/firewire/fireworks/fireworks.c | 21 +++++++--------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 34ed8afbb30c..3bc68499974a 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -128,6 +128,10 @@ name_device(struct snd_bebob *bebob)
 
 static void bebob_free(struct snd_bebob *bebob)
 {
+	mutex_lock(&devices_mutex);
+	clear_bit(bebob->card_index, devices_used);
+	mutex_unlock(&devices_mutex);
+
 	snd_bebob_stream_destroy_duplex(bebob);
 }
 
@@ -140,12 +144,6 @@ static void bebob_free(struct snd_bebob *bebob)
 static void
 bebob_card_free(struct snd_card *card)
 {
-	struct snd_bebob *bebob = card->private_data;
-
-	mutex_lock(&devices_mutex);
-	clear_bit(bebob->card_index, devices_used);
-	mutex_unlock(&devices_mutex);
-
 	bebob_free(card->private_data);
 }
 
@@ -186,7 +184,6 @@ do_registration(struct work_struct *work)
 		return;
 
 	mutex_lock(&devices_mutex);
-
 	for (card_index = 0; card_index < SNDRV_CARDS; card_index++) {
 		if (!test_bit(card_index, devices_used) && enable[card_index])
 			break;
@@ -202,6 +199,8 @@ do_registration(struct work_struct *work)
 		mutex_unlock(&devices_mutex);
 		return;
 	}
+	set_bit(card_index, devices_used);
+	mutex_unlock(&devices_mutex);
 
 	err = name_device(bebob);
 	if (err < 0)
@@ -242,9 +241,6 @@ do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
-	set_bit(card_index, devices_used);
-	mutex_unlock(&devices_mutex);
-
 	/*
 	 * After registered, bebob instance can be released corresponding to
 	 * releasing the sound card instance.
@@ -255,7 +251,6 @@ do_registration(struct work_struct *work)
 
 	return;
 error:
-	mutex_unlock(&devices_mutex);
 	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_free(bebob->card);
 	dev_info(&bebob->unit->device,
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 5854d2a87a18..da0c31033821 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -186,6 +186,10 @@ get_hardware_info(struct snd_efw *efw)
 
 static void efw_free(struct snd_efw *efw)
 {
+	mutex_lock(&devices_mutex);
+	clear_bit(efw->card_index, devices_used);
+	mutex_unlock(&devices_mutex);
+
 	snd_efw_stream_destroy_duplex(efw);
 	snd_efw_transaction_remove_instance(efw);
 }
@@ -199,14 +203,6 @@ static void efw_free(struct snd_efw *efw)
 static void
 efw_card_free(struct snd_card *card)
 {
-	struct snd_efw *efw = card->private_data;
-
-	if (efw->card_index >= 0) {
-		mutex_lock(&devices_mutex);
-		clear_bit(efw->card_index, devices_used);
-		mutex_unlock(&devices_mutex);
-	}
-
 	efw_free(card->private_data);
 }
 
@@ -220,9 +216,8 @@ do_registration(struct work_struct *work)
 	if (efw->registered)
 		return;
 
-	mutex_lock(&devices_mutex);
-
 	/* check registered cards */
+	mutex_lock(&devices_mutex);
 	for (card_index = 0; card_index < SNDRV_CARDS; ++card_index) {
 		if (!test_bit(card_index, devices_used) && enable[card_index])
 			break;
@@ -238,6 +233,8 @@ do_registration(struct work_struct *work)
 		mutex_unlock(&devices_mutex);
 		return;
 	}
+	set_bit(card_index, devices_used);
+	mutex_unlock(&devices_mutex);
 
 	/* prepare response buffer */
 	snd_efw_resp_buf_size = clamp(snd_efw_resp_buf_size,
@@ -279,9 +276,6 @@ do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
-	set_bit(card_index, devices_used);
-	mutex_unlock(&devices_mutex);
-
 	/*
 	 * After registered, efw instance can be released corresponding to
 	 * releasing the sound card instance.
@@ -292,7 +286,6 @@ do_registration(struct work_struct *work)
 
 	return;
 error:
-	mutex_unlock(&devices_mutex);
 	snd_efw_transaction_remove_instance(efw);
 	snd_efw_stream_destroy_duplex(efw);
 	snd_card_free(efw->card);
-- 
2.19.0
