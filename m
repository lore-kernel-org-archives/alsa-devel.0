From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] ALSA: seq: initialize whole fields of
	automatic variable with union type
Date: Wed, 31 Aug 2016 21:02:13 +0900
Message-ID: <1472644933-574-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 92420267BC6
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 14:02:18 +0200 (CEST)
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

Currently, automatic variable of 'union ioctl_arg' type is initialized
by designated initialization. Although, the actual effect is interpretation
of early element of int type and initialization of 'int pversion'.
Therefore the first field corresponding to int type is initialized to zero.
This is against my expectation to initialize whole fields.

This commit uses memset() to initialize the variable, instead of designated
initialization.

Fixes: 04a56dd8ed0d ('ALSA: seq: change ioctl command operation to get data in kernel space')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 286394b..811b95b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2084,7 +2084,7 @@ static long snd_seq_ioctl(struct file *file, unsigned int cmd,
 {
 	struct snd_seq_client *client = file->private_data;
 	/* To use kernel stack for ioctl data. */
-	union ioctl_arg {
+	union {
 		int pversion;
 		int client_id;
 		struct snd_seq_system_info	system_info;
@@ -2100,7 +2100,7 @@ static long snd_seq_ioctl(struct file *file, unsigned int cmd,
 		struct snd_seq_client_pool	client_pool;
 		struct snd_seq_remove_events	remove_events;
 		struct snd_seq_query_subs	query_subs;
-	} buf = {0};
+	} buf;
 	const struct ioctl_handler *handler;
 	unsigned long size;
 	int err;
@@ -2114,6 +2114,9 @@ static long snd_seq_ioctl(struct file *file, unsigned int cmd,
 	}
 	if (handler->cmd == 0)
 		return -ENOTTY;
+
+	memset(&buf, 0, sizeof(buf));
+
 	/*
 	 * All of ioctl commands for ALSA sequencer get an argument of size
 	 * within 13 bits. We can safely pick up the size from the command.
-- 
2.7.4
