From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: fireworks: move model quirk
	detection code to information parser
Date: Sun, 27 Mar 2016 16:09:08 +0900
Message-ID: <1459062549-18721-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 989A6260524
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 09:09:14 +0200 (CEST)
In-Reply-To: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, model-specific quirks are detected out of information parser,
however it's natural to detect it in the parser.

This commit applies the idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 8f27b67..8380fb5 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -168,6 +168,17 @@ get_hardware_info(struct snd_efw *efw)
 	       sizeof(struct snd_efw_phys_grp) * hwinfo->phys_in_grp_count);
 	memcpy(&efw->phys_out_grps, hwinfo->phys_out_grps,
 	       sizeof(struct snd_efw_phys_grp) * hwinfo->phys_out_grp_count);
+
+	/* AudioFire8 (since 2009) and AudioFirePre8 */
+	if (hwinfo->type == MODEL_ECHO_AUDIOFIRE_9)
+		efw->is_af9 = true;
+	/* These models uses the same firmware. */
+	if (hwinfo->type == MODEL_ECHO_AUDIOFIRE_2 ||
+	    hwinfo->type == MODEL_ECHO_AUDIOFIRE_4 ||
+	    hwinfo->type == MODEL_ECHO_AUDIOFIRE_9 ||
+	    hwinfo->type == MODEL_GIBSON_RIP ||
+	    hwinfo->type == MODEL_GIBSON_GOLDTOP)
+		efw->is_fireworks3 = true;
 end:
 	kfree(hwinfo);
 	return err;
@@ -248,16 +259,6 @@ efw_probe(struct fw_unit *unit,
 	err = get_hardware_info(efw);
 	if (err < 0)
 		goto error;
-	/* AudioFire8 (since 2009) and AudioFirePre8 */
-	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_9)
-		efw->is_af9 = true;
-	/* These models uses the same firmware. */
-	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_2 ||
-	    entry->model_id == MODEL_ECHO_AUDIOFIRE_4 ||
-	    entry->model_id == MODEL_ECHO_AUDIOFIRE_9 ||
-	    entry->model_id == MODEL_GIBSON_RIP ||
-	    entry->model_id == MODEL_GIBSON_GOLDTOP)
-		efw->is_fireworks3 = true;
 
 	snd_efw_proc_init(efw);
 
-- 
2.7.3
