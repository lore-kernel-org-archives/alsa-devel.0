From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/20] ALSA: hda - Fix inconsistent input_paths
	after ADC reduction
Date: Tue, 15 Jan 2013 12:05:30 +0100
Message-ID: <1358247947-13992-4-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C3292652C6
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 705C0A520F
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

In the current parser code, the input_paths[] may become inconsistent
when some of detected ADCs are dropped due to incomplete inputs, since
the driver rearranges only adc_nids[] but doesn't touch input_paths[].

This patch fixes the issue, and also it optimizes the reachability
checks by simply referring to the parsed input_paths[] instead of
calling is_reachable() again for each connection.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index aa4e639..d16ef1d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2002,24 +2002,24 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct hda_input_mux *imux = &spec->input_mux;
-	hda_nid_t adc_nids[ARRAY_SIZE(spec->adc_nids)];
+	unsigned int ok_bits;
 	int i, n, nums;
-	hda_nid_t pin, adc;
 
  again:
 	nums = 0;
+	ok_bits = 0;
 	for (n = 0; n < spec->num_adc_nids; n++) {
-		adc = spec->adc_nids[n];
 		for (i = 0; i < imux->num_items; i++) {
-			pin = spec->imux_pins[i];
-			if (!is_reachable_path(codec, pin, adc))
+			if (!spec->input_paths[i][n])
 				break;
 		}
-		if (i >= imux->num_items)
-			adc_nids[nums++] = adc;
+		if (i >= imux->num_items) {
+			ok_bits |= (1 << n);
+			nums++;
+		}
 	}
 
-	if (!nums) {
+	if (!ok_bits) {
 		if (spec->shared_mic_hp) {
 			spec->shared_mic_hp = 0;
 			imux->num_items = 1;
@@ -2028,10 +2028,8 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 
 		/* check whether ADC-switch is possible */
 		for (i = 0; i < imux->num_items; i++) {
-			pin = spec->imux_pins[i];
 			for (n = 0; n < spec->num_adc_nids; n++) {
-				adc = spec->adc_nids[n];
-				if (is_reachable_path(codec, pin, adc)) {
+				if (spec->input_paths[i][n]) {
 					spec->dyn_adc_idx[i] = n;
 					break;
 				}
@@ -2041,7 +2039,19 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 		snd_printdd("hda-codec: enabling ADC switching\n");
 		spec->dyn_adc_switch = 1;
 	} else if (nums != spec->num_adc_nids) {
-		memcpy(spec->adc_nids, adc_nids, nums * sizeof(hda_nid_t));
+		/* shrink the invalid adcs and input paths */
+		nums = 0;
+		for (n = 0; n < spec->num_adc_nids; n++) {
+			if (!(ok_bits & (1 << n)))
+				continue;
+			if (n != nums) {
+				spec->adc_nids[nums] = spec->adc_nids[n];
+				for (i = 0; i < imux->num_items; i++)
+					spec->input_paths[i][nums] =
+						spec->input_paths[i][n];
+			}
+			nums++;
+		}
 		spec->num_adc_nids = nums;
 	}
 
-- 
1.8.1
