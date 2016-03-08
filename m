From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 4/6] ASoC: core: allow private data for
	snd_soc_add_dai_pcm_controls
Date: Tue, 8 Mar 2016 13:53:59 +0100
Message-ID: <1457441641-7501-5-git-send-email-arnaud.pouliquen@st.com>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8D7264F8D
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 13:54:29 +0100 (CET)
In-Reply-To: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

To support generic iec958 control implementation, dai needs
to provide control private data to allow to retrieve context.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/soc.h          |  3 ++-
 sound/soc/soc-core.c         | 10 +++++++---
 sound/soc/sti/sti_uniperif.c |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 044adcf..e277e726 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -599,7 +599,8 @@ int snd_soc_add_card_controls(struct snd_soc_card *soc_card,
 int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_add_dai_pcm_controls(struct snd_soc_dai *dai,
-	const struct snd_kcontrol_new *controls, int num_controls);
+				 const struct snd_kcontrol_new *controls,
+				 int num_controls, void *data);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 08a1b9f..780192b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1606,6 +1606,7 @@ static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
 struct snd_soc_dai_pcm_ctls {
 	struct snd_kcontrol_new *controls;
 	int num_controls;
+	void *controls_data;
 	struct list_head list;
 };
 
@@ -1623,7 +1624,8 @@ static int soc_link_dai_pcm_controls(struct snd_soc_card *card,
 			kctl[i].device = rtd->pcm->device;
 
 		ret = snd_soc_add_controls(card->snd_card, dai->dev, kctl,
-					   ctls->num_controls, NULL, dai);
+					   ctls->num_controls, NULL,
+					   ctls->controls_data);
 		if (ret < 0)
 			return ret;
 		kfree(kctl);
@@ -2387,12 +2389,13 @@ EXPORT_SYMBOL_GPL(snd_soc_add_dai_controls);
  * @dai: DAI to add controls to
  * @controls: array of controls to add
  * @num_controls: number of elements in the array
+ * @data: control private data
  *
  * Return 0 for success, else error.
  */
 int snd_soc_add_dai_pcm_controls(struct snd_soc_dai *dai,
 				 const struct snd_kcontrol_new *controls,
-				 int num_controls)
+				 int num_controls, void *data)
 {
 	struct snd_soc_card *card = dai->component->card;
 	struct snd_soc_pcm_runtime *rtd;
@@ -2425,13 +2428,14 @@ int snd_soc_add_dai_pcm_controls(struct snd_soc_dai *dai,
 		for (i = 0; i < num_controls; i++)
 			kctl[i].device = rtd->pcm->device;
 		snd_soc_add_controls(card->snd_card, dai->dev, kctl,
-				     num_controls, NULL, dai);
+				     num_controls, NULL, data);
 		kfree(kctl);
 	} else {
 		/* pcm device does not exists. Postpone to dai link creation */
 		ctls_list = kzalloc(sizeof(*ctls_list), GFP_KERNEL);
 		ctls_list->controls = kctl;
 		ctls_list->num_controls = num_controls;
+		ctls_list->controls_data = data;
 		list_add(&ctls_list->list, &dai->list_pcm_ctl);
 	}
 
diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 0c87380..267c44f 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -97,7 +97,7 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 
 	if (uni->num_ctrls)
 		return snd_soc_add_dai_pcm_controls(dai, uni->snd_ctrls,
-						    uni->num_ctrls);
+						    uni->num_ctrls, dai);
 
 	return 0;
 }
-- 
1.9.1
