From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 26/27] sound: oss: use kzalloc rather than kmalloc with memset
Date: Fri, 28 Jun 2019 10:50:43 +0800
Message-ID: <20190628025044.16187-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Richard Fontana <rfontana@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use zeroing allocator instead of using allocator followed
with memset with 0.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/core/seq/oss/seq_oss_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 6dc94efc19c9..6e8020d4368a 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -66,7 +66,7 @@ snd_seq_oss_create_client(void)
 	struct snd_seq_port_info *port;
 	struct snd_seq_port_callback port_callback;
 
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		rc = -ENOMEM;
 		goto __error;
@@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
 	system_client = rc;
 
 	/* create annoucement receiver port */
-	memset(port, 0, sizeof(*port));
 	strcpy(port->name, "Receiver");
 	port->addr.client = system_client;
 	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */
-- 
2.11.0
