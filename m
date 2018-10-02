From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: fireworks: use managed-resource to
	maintain response buffer
Date: Wed,  3 Oct 2018 08:21:52 +0900
Message-ID: <20181002232154.29225-4-o-takashi@sakamocchi.jp>
References: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1932678B0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 01:22:12 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so2475481plo.9
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 16:22:12 -0700 (PDT)
In-Reply-To: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
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

ALSA fireworks driver allocates memory object to handle response from
target unit. The object is used to initiate transaction unique to
Fireworks board module. This can be released as managed-resource
of 'struct snd_card.card_dev'.

This commit uses managed-resource of the sound card device for this
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 2ff7b9cff9b0..f680e2f27806 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -189,8 +189,6 @@ static void efw_free(struct snd_efw *efw)
 	snd_efw_stream_destroy_duplex(efw);
 	snd_efw_transaction_remove_instance(efw);
 
-	kfree(efw->resp_buf);
-
 	mutex_destroy(&efw->mutex);
 	fw_unit_put(efw->unit);
 }
@@ -247,8 +245,9 @@ do_registration(struct work_struct *work)
 	/* prepare response buffer */
 	snd_efw_resp_buf_size = clamp(snd_efw_resp_buf_size,
 				      SND_EFW_RESPONSE_MAXIMUM_BYTES, 4096U);
-	efw->resp_buf = kzalloc(snd_efw_resp_buf_size, GFP_KERNEL);
-	if (efw->resp_buf == NULL) {
+	efw->resp_buf = devm_kzalloc(&efw->card->card_dev,
+				     snd_efw_resp_buf_size, GFP_KERNEL);
+	if (!efw->resp_buf) {
 		err = -ENOMEM;
 		goto error;
 	}
@@ -300,8 +299,6 @@ do_registration(struct work_struct *work)
 	snd_efw_transaction_remove_instance(efw);
 	snd_efw_stream_destroy_duplex(efw);
 	snd_card_free(efw->card);
-	kfree(efw->resp_buf);
-	efw->resp_buf = NULL;
 	dev_info(&efw->unit->device,
 		 "Sound card registration failed: %d\n", err);
 }
-- 
2.17.1
