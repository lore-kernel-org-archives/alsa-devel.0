From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 06/13] ASoC: Add add_dai_link ops for a soc
	card
Date: Thu,  5 Nov 2015 17:59:11 +0800
Message-ID: <7dc5e61b6df2eb7ae52ded08f7928b7ae519d069.1446717205.git.mengdong.lin@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 66922265AE4
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:43:45 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

When a new DAI link is added, the ASoC core will call this ops to notify
a machine driver for extra intialization.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 60e5fda..9a0e0e8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1103,6 +1103,9 @@ struct snd_soc_card {
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level);
 
+	int (*add_dai_link)(struct snd_soc_card *,
+			    struct snd_soc_dai_link *link);
+
 	long pmdown_time;
 
 	/* CPU <--> Codec DAI links  */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c855e30..24e0c50 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1243,6 +1243,10 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 void snd_soc_add_dai_link(struct snd_soc_card *card,
 		struct snd_soc_dai_link *dai_link)
 {
+	/* Notify the machine driver for extra initialization. */
+	if (card && card->add_dai_link)
+		card->add_dai_link(card, dai_link);
+
 	lockdep_assert_held(&client_mutex);
 	list_add_tail(&dai_link->list, &card->dai_link_list);
 	card->num_dai_links++;
-- 
1.9.1
