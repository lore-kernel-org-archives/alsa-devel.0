From: mengdong.lin@intel.com
Subject: [PATCH v2 05/10] ASoC: Add support for dummy DAI links
	and PCM runtimes
Date: Mon, 10 Aug 2015 22:47:47 +0800
Message-ID: <0364569ce2898a20d08243ba59a92973b2dc4735.1439217448.git.mengdong.lin@intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4556B265938
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 16:34:34 +0200 (CEST)
In-Reply-To: <cover.1439217448.git.mengdong.lin@intel.com>
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Add dummy flag to a DAI link and PCM runtime. A dummy link will create
a dummy PCM runtime.

A machine driver can define dummy dai links to specify the expected
platform and codec. And its dummy runtime is used to probe the platform
and codec components, which can bring real DAI/DAI links based on topology.
After components probing, all dummy PCM runtimes will be removed.

Only non-dummy PCM runtimes will be assigned a valid number and create
PCM streams.

The ASoC core will find the platform for a dummy DAI link, assuming the
cpu DAI can be dummy but the platform can bring the topology info.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 79891e2..7e04ec0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -970,6 +970,11 @@ struct snd_soc_dai_link {
 
 	enum snd_soc_dpcm_trigger trigger[2]; /* trigger type for DPCM */
 
+	/* This DAI link is dummy. Machine drivers can define static dummy
+	 * links to specify platform/codec with topology.
+	 */
+	bool dummy;
+
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_pcm_runtime *rtd);
 
@@ -1087,6 +1092,7 @@ struct snd_soc_card {
 
 	struct list_head rtd_list;
 	int num_rtd;
+	int num_rtd_dev; /* monotonic increase and exclude dummy ones */
 
 	/* optional codec specific configuration */
 	struct snd_soc_codec_conf *codec_conf;
@@ -1181,6 +1187,7 @@ struct snd_soc_pcm_runtime {
 	struct dentry *debugfs_dpcm_state;
 #endif
 
+	bool dummy;
 	unsigned int num; /* 0-based and monotonic increasing */
 	struct list_head list; /* rtd list of the soc card */
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 58eac57..f552fa0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -561,6 +561,7 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 
 	rtd->card = card;
 	rtd->dai_link = dai_link;
+	rtd->dummy = dai_link->dummy;
 	rtd->codec_dais = devm_kzalloc(card->dev,
 					sizeof(struct snd_soc_dai *) *
 					dai_link->num_codecs,
@@ -583,10 +584,28 @@ static void soc_add_pcm_runtime(struct snd_soc_card *card,
 		struct snd_soc_pcm_runtime *rtd)
 {
 	list_add_tail(&rtd->list, &card->rtd_list);
-	rtd->num = card->num_rtd;
+
+	if (!rtd->dummy) {
+		rtd->num = card->num_rtd_dev;
+		card->num_rtd_dev++;
+	}
+
 	card->num_rtd++;
 }
 
+static void soc_remove_dummy_pcm_runtimes(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd, *_rtd;
+
+	list_for_each_entry_safe(rtd, _rtd, &card->rtd_list, list) {
+		if (rtd->dummy) {
+			list_del(&rtd->list);
+			soc_free_pcm_runtime(card, rtd);
+			card->num_rtd--;
+		}
+	}
+}
+
 static void soc_remove_pcm_runtimes(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd, *_rtd;
@@ -1007,6 +1026,15 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 		}
 	}
 
+	/* Dummy link can use dummy cpu DAI but set platform to get topology */
+	if (dai_link->dummy && dai_link->platform_name) {
+		if (!soc_find_component(NULL, dai_link->platform_name)) {
+			dev_err(card->dev, "ASoC: Platform %s not registered\n",
+				dai_link->platform_name);
+			goto _err_defer;
+		}
+	}
+
 	/* Single codec links expect codec and codec_dai in runtime data */
 	rtd->codec_dai = codec_dais[0];
 	rtd->codec = rtd->codec_dai->codec;
@@ -1250,6 +1278,10 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 void snd_soc_add_dai_link(struct snd_soc_card *card,
 		struct snd_soc_dai_link *dai_link)
 {
+	/* Dummy links should be static, so overlook them */
+	if (dai_link->dummy)
+		return;
+
 	lockdep_assert_held(&client_mutex);
 	list_add_tail(&dai_link->list, &card->dai_link_list);
 	card->num_dai_links++;
@@ -1818,6 +1850,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	/* no longer need dummy runtimes */
+	soc_remove_dummy_pcm_runtimes(card);
+
 	/* probe all DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
@@ -2516,6 +2551,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
+	card->num_rtd_dev = 0;
 
 	card->rtd_aux = devm_kzalloc(card->dev,
 				 sizeof(struct snd_soc_pcm_runtime) *
-- 
1.9.1
