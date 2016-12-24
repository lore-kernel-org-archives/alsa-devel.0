From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] ALSA: mixart: fix a comment typo
Date: Sat, 24 Dec 2016 23:28:34 +0800
Message-ID: <33bee1ec2bea0a063ad6f6cf003e91ccfa6daab1.1482300478.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jiri Kosina <trivial@kernel.org>
Cc: Geliang Tang <geliangtang@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix a comment typo in mixart.h.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 sound/pci/mixart/mixart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/mixart/mixart.h b/sound/pci/mixart/mixart.h
index 0cc17e0..4267438 100644
--- a/sound/pci/mixart/mixart.h
+++ b/sound/pci/mixart/mixart.h
@@ -86,7 +86,7 @@ struct mixart_mgr {
 	u32 msg_fifo[MSG_FIFO_SIZE];
 	int msg_fifo_readptr;
 	int msg_fifo_writeptr;
-	atomic_t msg_processed;       /* number of messages to be processed in takslet */
+	atomic_t msg_processed;       /* number of messages to be processed in tasklet */
 
 	struct mutex lock;              /* interrupt lock */
 	struct mutex msg_lock;		/* mailbox lock */
-- 
2.9.3
