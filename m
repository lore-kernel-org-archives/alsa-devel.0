From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/3] ASoC: topology: Align tplg pointer
	increment across all kcontrols
Date: Fri,  1 Mar 2019 19:08:52 -0600
Message-ID: <20190302010853.18115-3-pierre-louis.bossart@linux.intel.com>
References: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EE0BF8073C
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 02:09:07 +0100 (CET)
In-Reply-To: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Liam Girdwood <liam.r.girdwood@linux.intel.com>, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

This aligns all kcontrol tplg pointer increments to be consistent
in the respective create methods and ensures that the position is
pointing to the next widget rather the current invalid widget.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-topology.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 25fca7055464..40fa2a48fa1d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -993,8 +993,6 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 
 	for (i = 0; i < count; i++) {
 		ec = (struct snd_soc_tplg_enum_control *)tplg->pos;
-		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
-			ec->priv.size);
 
 		/* validate kcontrol */
 		if (strnlen(ec->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
@@ -1005,6 +1003,9 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 		if (se == NULL)
 			return -ENOMEM;
 
+		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
+			ec->priv.size);
+
 		dev_dbg(tplg->dev, "ASoC: adding enum kcontrol %s size %d\n",
 			ec->hdr.name, ec->items);
 
@@ -1281,14 +1282,14 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		if (sm == NULL)
 			goto err;
 
-		tplg->pos += (sizeof(struct snd_soc_tplg_mixer_control) +
-			mc->priv.size);
-
 		/* validate kcontrol */
 		if (strnlen(mc->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
 			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
 			goto err_str;
 
+		tplg->pos += (sizeof(struct snd_soc_tplg_mixer_control) +
+			mc->priv.size);
+
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
@@ -1373,6 +1374,9 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		if (se == NULL)
 			goto err;
 
+		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
+				ec->priv.size);
+
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
@@ -1437,9 +1441,6 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 				ec->hdr.name);
 			goto err_se;
 		}
-
-		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
-				ec->priv.size);
 	}
 
 	return kc;
-- 
2.17.1
