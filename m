From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: opl4: Use IS_REACHABLE()
Date: Mon, 15 May 2017 11:33:36 +0200
Message-ID: <20170515093338.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5422C2673DA
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:33:41 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E71F9AC08
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:33:40 +0000 (UTC)
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

Rewrite the complex ifdef condition with IS_REACHABLE().
The ifdef in opl4_local.h was without defined(MODLE) check, but this
is likely the oversight.  Use IS_REACHABLE() here as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl4/opl4_lib.c   | 4 ++--
 sound/drivers/opl4/opl4_local.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index 89c7aa04b3bc..240656e54400 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -153,7 +153,7 @@ static int snd_opl4_detect(struct snd_opl4 *opl4)
 	return 0;
 }
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_REACHABLE(CONFIG_SND_SEQUENCER)
 static void snd_opl4_seq_dev_free(struct snd_seq_device *seq_dev)
 {
 	struct snd_opl4 *opl4 = seq_dev->private_data;
@@ -249,7 +249,7 @@ int snd_opl4_create(struct snd_card *card,
 	snd_opl4_create_mixer(opl4);
 	snd_opl4_create_proc(opl4);
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_REACHABLE(CONFIG_SND_SEQUENCER)
 	opl4->seq_client = -1;
 	if (opl4->hardware < OPL3_HW_OPL4_ML)
 		snd_opl4_create_seq_dev(opl4, seq_device);
diff --git a/sound/drivers/opl4/opl4_local.h b/sound/drivers/opl4/opl4_local.h
index 9a41bdebce6b..d5bac93f8245 100644
--- a/sound/drivers/opl4/opl4_local.h
+++ b/sound/drivers/opl4/opl4_local.h
@@ -184,7 +184,7 @@ struct snd_opl4 {
 #endif
 	struct mutex access_mutex;
 
-#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+#if IS_REACHABLE(CONFIG_SND_SEQUENCER)
 	int used;
 
 	int seq_dev_num;
-- 
2.12.2
