From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix kcontrol name string handling" to the asoc tree
Date: Wed, 28 Mar 2018 03:21:21 +0100 (BST)
Message-ID: <20180328022121.B14D744007A@finisterre.ee.mobilebroadband>
References: <20180327110404.27189-1-liam.r.girdwood@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180327110404.27189-1-liam.r.girdwood@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix kcontrol name string handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 267e2c6fd7ca3d4076d20f9d52d49dc91addfe9d Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 27 Mar 2018 12:04:04 +0100
Subject: [PATCH] ASoC: topology: Fix kcontrol name string handling

Fix the topology kcontrol string handling so that string pointer
references are strdup()ed instead of being copied. This fixes issues
with kcontrol templates on the stack or ones that are freed. Remember
and free the strings too when topology is unloaded.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-topology.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 01a50413c66f..782c580b7aa3 100644
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
2.16.2
