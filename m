From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/18] ALSA: firewire-motu: enable to read
	transaction cache via hwdep interface
Date: Wed, 22 Mar 2017 21:30:25 +0900
Message-ID: <20170322123028.24148-16-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 9B0A62673CD
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:44 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

MOTU FireWire series can transfer messages to registered address. These
messages are transferred for the status of internal clock synchronization
just after starting streams.

When the synchronization is stable, it's 0x01ffffff. Else, it's 0x05ffffff.

This commit adds a functionality for user space applications to receive
content of the message.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h          |  7 +++++++
 sound/firewire/motu/motu-hwdep.c       | 10 ++++++++--
 sound/firewire/motu/motu-transaction.c | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index 59c6d81..29afc5e 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -10,6 +10,7 @@
 #define SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION	0xd1ce004e
 #define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE	0x4e617475
 #define SNDRV_FIREWIRE_EVENT_DIGI00X_MESSAGE	0x746e736c
+#define SNDRV_FIREWIRE_EVENT_MOTU_NOTIFICATION	0x64776479
 
 struct snd_firewire_event_common {
 	unsigned int type; /* SNDRV_FIREWIRE_EVENT_xxx */
@@ -46,12 +47,18 @@ struct snd_firewire_event_digi00x_message {
 	__u32 message;	/* Digi00x-specific message */
 };
 
+struct snd_firewire_event_motu_notification {
+	unsigned int type;
+	__u32 message;	/* MOTU-specific bits. */
+};
+
 union snd_firewire_event {
 	struct snd_firewire_event_common            common;
 	struct snd_firewire_event_lock_status       lock_status;
 	struct snd_firewire_event_dice_notification dice_notification;
 	struct snd_firewire_event_efw_response      efw_response;
 	struct snd_firewire_event_digi00x_message   digi00x_message;
+	struct snd_firewire_event_motu_notification motu_notification;
 };
 
 
diff --git a/sound/firewire/motu/motu-hwdep.c b/sound/firewire/motu/motu-hwdep.c
index e795a52..b87ccb6 100644
--- a/sound/firewire/motu/motu-hwdep.c
+++ b/sound/firewire/motu/motu-hwdep.c
@@ -26,7 +26,7 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 
 	spin_lock_irq(&motu->lock);
 
-	while (!motu->dev_lock_changed) {
+	while (!motu->dev_lock_changed && motu->msg == 0) {
 		prepare_to_wait(&motu->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&motu->lock);
 		schedule();
@@ -43,6 +43,12 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 		motu->dev_lock_changed = false;
 
 		count = min_t(long, count, sizeof(event.lock_status));
+	} else {
+		event.motu_notification.type = SNDRV_FIREWIRE_EVENT_MOTU_NOTIFICATION;
+		event.motu_notification.message = motu->msg;
+		motu->msg = 0;
+
+		count = min_t(long, count, sizeof(event.motu_notification));
 	}
 
 	spin_unlock_irq(&motu->lock);
@@ -62,7 +68,7 @@ static unsigned int hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
 	poll_wait(file, &motu->hwdep_wait, wait);
 
 	spin_lock_irq(&motu->lock);
-	if (motu->dev_lock_changed)
+	if (motu->dev_lock_changed || motu->msg)
 		events = POLLIN | POLLRDNORM;
 	else
 		events = 0;
diff --git a/sound/firewire/motu/motu-transaction.c b/sound/firewire/motu/motu-transaction.c
index 416dd98..7fc3009 100644
--- a/sound/firewire/motu/motu-transaction.c
+++ b/sound/firewire/motu/motu-transaction.c
@@ -50,7 +50,27 @@ static void handle_message(struct fw_card *card, struct fw_request *request,
 			   int generation, unsigned long long offset,
 			   void *data, size_t length, void *callback_data)
 {
+	struct snd_motu *motu = callback_data;
+	__be32 *buf = (__be32 *)data;
+	unsigned long flags;
+
+	if (tcode != TCODE_WRITE_QUADLET_REQUEST) {
+		fw_send_response(card, request, RCODE_COMPLETE);
+		return;
+	}
+
+	if (offset != motu->async_handler.offset || length != 4) {
+		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
+		return;
+	}
+
+	spin_lock_irqsave(&motu->lock, flags);
+	motu->msg = be32_to_cpu(*buf);
+	spin_unlock_irqrestore(&motu->lock, flags);
+
 	fw_send_response(card, request, RCODE_COMPLETE);
+
+	wake_up(&motu->hwdep_wait);
 }
 
 int snd_motu_transaction_reregister(struct snd_motu *motu)
-- 
2.9.3
