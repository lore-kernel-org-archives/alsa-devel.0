From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 8/30] ALSA: HDA VIA: Change VT1708S & VT1702 hp
	mode controls
Date: Sat, 10 Oct 2009 19:07:43 +0800
Message-ID: <4AD06AFF.7090703@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 41858103837
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:07:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Change VT1708S & VT1702 hp mode controls

For VT1708S and VT1702, deactivate "Headphone Playback Volume" and
"Headphone Playback Mute" control if "Independent HP" mode is OFF.
and rename VT1702 "Independent HP" text.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -572,6 +572,18 @@
 	return 0;
 }
 
+static void activate_ctl(struct hda_codec *codec, const char *name, int active)
+{
+	struct snd_kcontrol *ctl = snd_hda_find_mixer_ctl(codec, name);
+	if (ctl) {
+		ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+		ctl->vd[0].access |= active
+			? 0 : SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+		snd_ctl_notify(codec->bus->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE, &ctl->id);
+	}
+}
+
 static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
@@ -620,6 +632,14 @@
 						   spec->multiout.hp_nid,
 						   0, 0, 0);
 
+	/* update HP volume/swtich active state */
+	if (spec->codec_type == VT1708S
+	    || spec->codec_type == VT1702) {
+		activate_ctl(codec, "Headphone Playback Volume",
+			     spec->hp_independent_mode);
+		activate_ctl(codec, "Headphone Playback Switch",
+			     spec->hp_independent_mode);
+	}
 	return 0;
 }
 
@@ -3342,11 +3362,11 @@
 
 static int vt1702_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
 {
-	int err;
-
+	int err, i;
+	struct hda_input_mux *imux;
+	static const char *texts[] = { "ON", "OFF", NULL};
 	if (!pin)
 		return 0;
-
 	spec->multiout.hp_nid = 0x1D;
 
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
@@ -3361,8 +3381,18 @@
 	if (err < 0)
 		return err;
 
-	create_hp_imux(spec);
+	imux = &spec->private_imux[1];
 
+	/* for hp mode select */
+	i = 0;
+	while (texts[i] != NULL)	{
+		imux->items[imux->num_items].label =  texts[i];
+		imux->items[imux->num_items].index = i;
+		imux->num_items++;
+		i++;
+	}
+
+	spec->hp_mux = &spec->private_imux[1];
 	return 0;
 }
