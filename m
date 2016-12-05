From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Only free TLV for volume
	mixers of a widget" to the asoc tree
Date: Mon, 05 Dec 2016 13:40:18 +0000
Message-ID: <E1cDtVC-0005CF-Ju@finisterre>
References: <1480061357-7905-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F513266C61
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 14:40:33 +0100 (CET)
In-Reply-To: <1480061357-7905-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Only free TLV for volume mixers of a widget

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From eea3dd4f1247aa8654194fb19ade22c94c42e41a Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Fri, 25 Nov 2016 16:09:17 +0800
Subject: [PATCH] ASoC: topology: Only free TLV for volume mixers of a widget

This patch will check the type of embedded controls for a widget, and
only free the TLV of volume mixers. Bytes controls don't have TLV.

Just free the private value which is used as struct soc_mixer_control
for volume mixers or soc_bytes_ext for bytes controls. No need to cast
to these types before freeing it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h |  2 +-
 sound/soc/soc-topology.c     | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index b897b9d63161..f9cc7b9271ac 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -53,7 +53,7 @@ struct snd_soc_dobj_control {
 
 /* dynamic widget object */
 struct snd_soc_dobj_widget {
-	unsigned int kcontrol_enum:1;	/* this widget is an enum kcontrol */
+	unsigned int kcontrol_type;	/* kcontrol type: mixer, enum, bytes */
 };
 
 /* generic dynamic object - all dynamic objects belong to this struct */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 63e1a50f2161..11feb19e9730 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -489,7 +489,7 @@ static void remove_widget(struct snd_soc_component *comp,
 	 * Dynamic Widgets either have 1..N enum kcontrols or mixers.
 	 * The enum may either have an array of values or strings.
 	 */
-	if (dobj->widget.kcontrol_enum) {
+	if (dobj->widget.kcontrol_type == SND_SOC_TPLG_TYPE_ENUM) {
 		/* enumerated widget mixer */
 		for (i = 0; i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
@@ -506,16 +506,21 @@ static void remove_widget(struct snd_soc_component *comp,
 		}
 		kfree(w->kcontrol_news);
 	} else {
-		/* non enumerated widget mixer */
+		/* volume mixer or bytes controls */
 		for (i = 0; i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
-			struct soc_mixer_control *sm =
-			(struct soc_mixer_control *) kcontrol->private_value;
 
-			kfree(w->kcontrols[i]->tlv.p);
+			if (dobj->widget.kcontrol_type
+			    == SND_SOC_TPLG_TYPE_MIXER)
+				kfree(kcontrol->tlv.p);
 
-			snd_ctl_remove(card, w->kcontrols[i]);
-			kfree(sm);
+			snd_ctl_remove(card, kcontrol);
+
+			/* Private value is used as struct soc_mixer_control
+			 * for volume mixers or soc_bytes_ext for bytes
+			 * controls.
+			 */
+			kfree((void *)kcontrol->private_value);
 		}
 		kfree(w->kcontrol_news);
 	}
@@ -1439,6 +1444,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	struct snd_soc_dapm_widget template, *widget;
 	struct snd_soc_tplg_ctl_hdr *control_hdr;
 	struct snd_soc_card *card = tplg->comp->card;
+	unsigned int kcontrol_type;
 	int ret = 0;
 
 	if (strnlen(w->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
@@ -1494,6 +1500,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_CTL_VOLSW_XR_SX:
 	case SND_SOC_TPLG_CTL_RANGE:
 	case SND_SOC_TPLG_DAPM_CTL_VOLSW:
+		kcontrol_type = SND_SOC_TPLG_TYPE_MIXER;  /* volume mixer */
 		template.num_kcontrols = w->num_kcontrols;
 		template.kcontrol_news =
 			soc_tplg_dapm_widget_dmixer_create(tplg,
@@ -1508,7 +1515,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
-		template.dobj.widget.kcontrol_enum = 1;
+		kcontrol_type = SND_SOC_TPLG_TYPE_ENUM;	/* enumerated mixer */
 		template.num_kcontrols = w->num_kcontrols;
 		template.kcontrol_news =
 			soc_tplg_dapm_widget_denum_create(tplg,
@@ -1519,6 +1526,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 		}
 		break;
 	case SND_SOC_TPLG_CTL_BYTES:
+		kcontrol_type = SND_SOC_TPLG_TYPE_BYTES; /* bytes control */
 		template.num_kcontrols = w->num_kcontrols;
 		template.kcontrol_news =
 			soc_tplg_dapm_widget_dbytes_create(tplg,
@@ -1555,6 +1563,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	}
 
 	widget->dobj.type = SND_SOC_DOBJ_WIDGET;
+	widget->dobj.widget.kcontrol_type = kcontrol_type;
 	widget->dobj.ops = tplg->ops;
 	widget->dobj.index = tplg->index;
 	kfree(template.sname);
-- 
2.10.2
