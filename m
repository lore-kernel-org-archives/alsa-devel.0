From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/27] ALSA: seq: add const qualifier to table
	of functions for ioctl
Date: Mon,  8 Aug 2016 23:54:27 +0900
Message-ID: <1470668093-31027-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 72E4E2670F6
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:00 +0200 (CEST)
In-Reply-To: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
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

Each entry in this table is never changed in runtime. This commit moves it
from .data to .rodata section.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index d6d9419..42be1e5 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2168,7 +2168,7 @@ static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
 
 /* -------------------------------------------------------- */
 
-static struct seq_ioctl_table {
+static const struct seq_ioctl_table {
 	unsigned int cmd;
 	int (*func)(struct snd_seq_client *client, void __user * arg);
 } ioctl_tables[] = {
@@ -2207,7 +2207,7 @@ static struct seq_ioctl_table {
 static int snd_seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
 			    void __user *arg)
 {
-	struct seq_ioctl_table *p;
+	const struct seq_ioctl_table *p;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
-- 
2.7.4
