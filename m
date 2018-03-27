From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: topology: Fix kcontrol name string
	handling.
Date: Tue, 27 Mar 2018 12:04:04 +0100
Message-ID: <20180327110404.27189-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A2BE2670D7
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 13:04:20 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Fix the topology kcontrol string handling so that string pointer
references are strdup()ed instead of being copied. This fixes issues
with kcontrol templates on the stack or ones that are freed. Remember
and free the strings too when topology is unloaded.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---

 sound/soc/soc-topology.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 87f3d9568180..d3ce9aa972f6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -523,6 +523,7 @@ static void remove_widget(struct snd_soc_component *comp,
 				kfree(se->dobj.control.dtexts[j]);
 
 			kfree(se);
+			kfree(w->kcontrol_news[i].name);
 		}
 		kfree(w->kcontrol_news);
 	} else {
@@ -540,6 +541,7 @@ static void remove_widget(struct snd_soc_component *comp,
 			 */
 			kfree((void *)kcontrol->private_value);
 			snd_ctl_remove(card, kcontrol);
+			kfree(w->kcontrol_news[i].name);
 		}
 		kfree(w->kcontrol_news);
 	}
@@ -1233,7 +1235,9 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
-		kc[i].name = mc->hdr.name;
+		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
+		if (kc[i].name == NULL)
+			goto err_str;
 		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
@@ -1278,8 +1282,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 err_str:
 	kfree(sm);
 err:
-	for (--i; i >= 0; i--)
+	for (--i; i >= 0; i--) {
 		kfree((void *)kc[i].private_value);
+		kfree(kc[i].name);
+	}
 	kfree(kc);
 	return NULL;
 }
@@ -1310,7 +1316,9 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
-		kc[i].name = ec->hdr.name;
+		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
+		if (kc[i].name == NULL)
+			goto err_se;
 		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
@@ -1386,6 +1394,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 			kfree(se->dobj.control.dtexts[j]);
 
 		kfree(se);
+		kfree(kc[i].name);
 	}
 err:
 	kfree(kc);
@@ -1424,7 +1433,9 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
-		kc[i].name = be->hdr.name;
+		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
+		if (kc[i].name == NULL)
+			goto err;
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
@@ -1454,8 +1465,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 	return kc;
 
 err:
-	for (--i; i >= 0; i--)
+	for (--i; i >= 0; i--) {
 		kfree((void *)kc[i].private_value);
+		kfree(kc[i].name);
+	}
 
 	kfree(kc);
 	return NULL;
-- 
2.14.1
