From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 7/16] ALSA: VIA HDA: Modify
	notify_aa_path_ctls() function
Date: Mon, 21 Mar 2011 15:29:35 +0800
Message-ID: <4D86FE5F.9030106@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC59243DF
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:29:38 +0100 (CET)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Modify notify_aa_path_ctls() function.

Modify notify_aa_path_ctls() function to get volume control items name 
dynamically instead of by giving static item name.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -832,16 +832,23 @@
 
 static void notify_aa_path_ctls(struct hda_codec *codec)
 {
-	int i;
-	struct snd_ctl_elem_id id;
-	const char *labels[] = {"Mic", "Front Mic", "Line"};
-
-	memset(&id, 0, sizeof(id));
-	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	for (i = 0; i < ARRAY_SIZE(labels); i++) {
-		sprintf(id.name, "%s Playback Volume", labels[i]);
-		snd_ctl_notify(codec->bus->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &id);
+	struct snd_card *card = codec->bus->card;
+	struct snd_kcontrol *kctl;
+	struct via_spec *spec = codec->spec;
+	const struct auto_pin_cfg *cfg = &spec->autocfg;
+	list_for_each_entry(kctl, &card->controls, list) {
+		int i;
+		for (i = 0; i < cfg->num_inputs; i++) {
+			char name[32];
+			const char *label;
+			label = hda_get_autocfg_input_label(codec, cfg, i);
+			sprintf(name, "%s Playback Volume", label);
+			if (strcmp(kctl->id.name, name) == 0) {
+				snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+					       &kctl->id);
+				break;
+			}
+		}
 	}
 }
