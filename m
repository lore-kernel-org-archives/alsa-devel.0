From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: SPDIF mux fixes for STAC927x
Date: Tue, 16 Sep 2008 10:39:37 -0400
Message-ID: <48CFC529.7010605@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 3103E2446A
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 16:39:49 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Corrected bounds-checking in stac92xx_auto_create_mux_input_ctls() and added a spec->spdif_labels
pointer for custom SPDIF mux labels for non-standard codec connections.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index f00334f..dc7393f 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -175,6 +175,7 @@ struct sigmatel_spec {
 	unsigned int num_dmuxes;
 	hda_nid_t *smux_nids;
 	unsigned int num_smuxes;
+	const char **spdif_labels;

 	hda_nid_t dig_in_nid;
 	hda_nid_t mono_nid;
@@ -383,6 +384,11 @@ static hda_nid_t stac927x_dmic_nids[STAC927X_NUM_DMICS + 1] = {
 	0x13, 0x14, 0
 };

+static const char *stac927x_spdif_labels[5] = {
+	"Digital Playback", "ADAT", "Analog Mux 1",
+	"Analog Mux 2", "Analog Mux 3"
+};
+
 static hda_nid_t stac9205_adc_nids[2] = {
         0x12, 0x13
 };
@@ -2893,26 +2899,29 @@ static int stac92xx_auto_create_mux_input_ctls(struct hda_codec *codec)
 };

 static const char *stac92xx_spdif_labels[3] = {
-	"Digital Playback", "Analog Mux 1", "Analog Mux 2"
+	"Digital Playback", "Analog Mux 1", "Analog Mux 2",
 };

 static int stac92xx_auto_create_spdif_mux_ctls(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	struct hda_input_mux *spdif_mux = &spec->private_smux;
+	const char **labels = spec->spdif_labels;
 	int i, num_cons;
-	hda_nid_t con_lst[ARRAY_SIZE(stac92xx_spdif_labels)];
+	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];

 	num_cons = snd_hda_get_connections(codec,
 				spec->smux_nids[0],
 				con_lst,
 				HDA_MAX_NUM_INPUTS);
-	if (!num_cons || num_cons > ARRAY_SIZE(stac92xx_spdif_labels))
+	if (!num_cons)
 		return -EINVAL;

+	if (!labels)
+		labels = stac92xx_spdif_labels;
+
 	for (i = 0; i < num_cons; i++) {
-		spdif_mux->items[spdif_mux->num_items].label =
-					stac92xx_spdif_labels[i];
+		spdif_mux->items[spdif_mux->num_items].label = labels[i];
 		spdif_mux->items[spdif_mux->num_items].index = i;
 		spdif_mux->num_items++;
 	}
@@ -4376,6 +4385,7 @@ static int patch_stac927x(struct hda_codec *codec)
 	spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 	spec->smux_nids = stac927x_smux_nids;
 	spec->num_smuxes = ARRAY_SIZE(stac927x_smux_nids);
+	spec->spdif_labels = stac927x_spdif_labels;
 	spec->dac_list = stac927x_dac_nids;
 	spec->multiout.dac_nids = spec->dac_nids;
