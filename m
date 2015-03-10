From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: seq_oss: Drop superfluous
	error/debug messages after malloc failures
Date: Tue, 10 Mar 2015 15:43:17 +0100
Message-ID: <1425998599-9481-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 87B5F260496
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 15:43:23 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3A5F1AD32
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 14:43:23 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The kernel memory allocators already report the errors when the
requested allocation fails, thus we don't need to warn it again in
each caller side.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_init.c  | 4 +---
 sound/core/seq/oss/seq_oss_midi.c  | 5 ++---
 sound/core/seq/oss/seq_oss_readq.c | 9 ++++-----
 sound/core/seq/oss/seq_oss_synth.c | 6 ++----
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index b0e32e161dd1..2de3feff70d0 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -188,10 +188,8 @@ snd_seq_oss_open(struct file *file, int level)
 	struct seq_oss_devinfo *dp;
 
 	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
-	if (!dp) {
-		pr_err("ALSA: seq_oss: can't malloc device info\n");
+	if (!dp)
 		return -ENOMEM;
-	}
 
 	dp->cseq = system_client;
 	dp->port = -1;
diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index e79cc44b1394..96e8395ae586 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -173,10 +173,9 @@ snd_seq_oss_midi_check_new_port(struct snd_seq_port_info *pinfo)
 	/*
 	 * allocate midi info record
 	 */
-	if ((mdev = kzalloc(sizeof(*mdev), GFP_KERNEL)) == NULL) {
-		pr_err("ALSA: seq_oss: can't malloc midi info\n");
+	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
 		return -ENOMEM;
-	}
 
 	/* copy the port information */
 	mdev->client = pinfo->addr.client;
diff --git a/sound/core/seq/oss/seq_oss_readq.c b/sound/core/seq/oss/seq_oss_readq.c
index 654d17a5023c..c080c73cea04 100644
--- a/sound/core/seq/oss/seq_oss_readq.c
+++ b/sound/core/seq/oss/seq_oss_readq.c
@@ -47,13 +47,12 @@ snd_seq_oss_readq_new(struct seq_oss_devinfo *dp, int maxlen)
 {
 	struct seq_oss_readq *q;
 
-	if ((q = kzalloc(sizeof(*q), GFP_KERNEL)) == NULL) {
-		pr_err("ALSA: seq_oss: can't malloc read queue\n");
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
 		return NULL;
-	}
 
-	if ((q->q = kcalloc(maxlen, sizeof(union evrec), GFP_KERNEL)) == NULL) {
-		pr_err("ALSA: seq_oss: can't malloc read queue buffer\n");
+	q->q = kcalloc(maxlen, sizeof(union evrec), GFP_KERNEL);
+	if (!q->q) {
 		kfree(q);
 		return NULL;
 	}
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 835edc80f918..48e4fe1b68ab 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -106,10 +106,9 @@ snd_seq_oss_synth_probe(struct device *_dev)
 	struct snd_seq_oss_reg *reg = SNDRV_SEQ_DEVICE_ARGPTR(dev);
 	unsigned long flags;
 
-	if ((rec = kzalloc(sizeof(*rec), GFP_KERNEL)) == NULL) {
-		pr_err("ALSA: seq_oss: can't malloc synth info\n");
+	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
+	if (!rec)
 		return -ENOMEM;
-	}
 	rec->seq_device = -1;
 	rec->synth_type = reg->type;
 	rec->synth_subtype = reg->subtype;
@@ -249,7 +248,6 @@ snd_seq_oss_synth_setup(struct seq_oss_devinfo *dp)
 		if (info->nr_voices > 0) {
 			info->ch = kcalloc(info->nr_voices, sizeof(struct seq_oss_chinfo), GFP_KERNEL);
 			if (!info->ch) {
-				pr_err("ALSA: seq_oss: Cannot malloc voices\n");
 				rec->oper.close(&info->arg);
 				module_put(rec->oper.owner);
 				snd_use_lock_free(&rec->use_lock);
-- 
2.3.2
