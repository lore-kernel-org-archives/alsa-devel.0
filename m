From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: seq: fix passing wrong pointer in
	function call of compatibility layer
Date: Wed, 12 Oct 2016 09:05:50 +0900
Message-ID: <1476230750-20548-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 2777D266666
 for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2016 02:05:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

This commit is a fix for Linux 4.9-rc1.

In former commit, a function call of compatibility layer for ALSA sequencer
core was obsoleted by an alternative. Although, the alternative gets a
pointer to kernel stack due to mis-programming. As a result, ALSA sequencer
core unexpectedly refers over kernel stack.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 8ce8eb601c71 ("ALSA: seq: add an alternative way to handle ioctl requests")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index fce5697..8c35072 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -58,7 +58,7 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 		goto error;
 	data->kernel = NULL;
 
-	err = snd_seq_kernel_client_ctl(client->number, cmd, &data);
+	err = snd_seq_kernel_client_ctl(client->number, cmd, data);
 	if (err < 0)
 		goto error;
 
-- 
2.7.4
