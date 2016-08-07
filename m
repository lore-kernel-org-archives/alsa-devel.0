From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/39] ALSA: seq: add documentation for
	snd_seq_kernel_client_ctl
Date: Sun,  7 Aug 2016 18:48:41 +0900
Message-ID: <1470563355-18368-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id DA6BB265917
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:37 +0200 (CEST)
In-Reply-To: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
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

This kernel API is used by kernel implementation. Currently, it's used for
kernel clients of ALSA sequencer, while it can be used for application
clients. The difference is just on address spaces of argument. In short,
this kernel API can be available for application client with data in kernel
space.

This commit adds a document about this.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 17d988a..a09cb84 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2494,9 +2494,17 @@ int snd_seq_kernel_client_dispatch(int client, struct snd_seq_event * ev,
 
 EXPORT_SYMBOL(snd_seq_kernel_client_dispatch);
 
-/*
- * exported, called by kernel clients to perform same functions as with
- * userland ioctl() 
+/**
+ * snd_seq_kernel_client_ctl - operate a command for a client with data in
+ *			       kernel space.
+ * @clientid:	A numerical ID for a client.
+ * @cmd:	An ioctl(2) command for ALSA sequencer operation.
+ * @arg:	A pointer to data in kernel space.
+ *
+ * Against its name, both kernel/application client can be handled by this
+ * kernel API. Address space for 'arg' argument should be in kernel space.
+ *
+ * Return: 0 at success. Minus error code at failure.
  */
 int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 {
-- 
2.7.4
