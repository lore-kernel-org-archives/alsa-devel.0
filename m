From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/11] ALSA: bebob: preparation for replacing
	string literals by normalized representation for
	model-dependent structures
Date: Sun, 14 Jun 2015 12:49:29 +0900
Message-ID: <1434253777-433-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B432604E1
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:44 +0200 (CEST)
In-Reply-To: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Previous commit adds a enumerator as a normalized representation of
clock source, while model-dependent structures still use string literals
for this purpose.

This commit is a preparation for replacement.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_focusrite.c | 27 +++++++++++++++++++++++----
 sound/firewire/bebob/bebob_maudio.c    | 13 ++++++++++---
 sound/firewire/bebob/bebob_terratec.c  | 26 +++++++++++++++++++++++---
 sound/firewire/bebob/bebob_yamaha.c    | 18 ++++++++++++++++--
 4 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
index fc67c1b..45c8f76 100644
--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -106,9 +106,21 @@ saffire_write_quad(struct snd_bebob *bebob, u64 offset, u32 value)
 static const char *const saffirepro_10_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "Word Clock"
 };
+static enum snd_bebob_clock_type saffirepro_10_clk_src_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* Word Clock */
+};
 static const char *const saffirepro_26_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "ADAT1", "ADAT2", "Word Clock"
 };
+static enum snd_bebob_clock_type saffirepro_26_clk_src_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* ADAT1 */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* ADAT2 */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* Word Clock */
+};
 /* Value maps between registers and labels for SaffirePro 10/26. */
 static const signed char saffirepro_clk_maps[][SAFFIREPRO_CLOCK_SOURCE_COUNT] = {
 	/* SaffirePro 10 */
@@ -178,7 +190,7 @@ saffirepro_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 		goto end;
 
 	/* depending on hardware, use a different mapping */
-	if (bebob->spec->clock->labels == saffirepro_10_clk_src_labels)
+	if (bebob->spec->clock->types == saffirepro_10_clk_src_types)
 		map = saffirepro_clk_maps[0];
 	else
 		map = saffirepro_clk_maps[1];
@@ -198,6 +210,10 @@ struct snd_bebob_spec saffire_le_spec;
 static const char *const saffire_both_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF"
 };
+static enum snd_bebob_clock_type saffire_both_clk_src_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,
+};
 static int
 saffire_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
@@ -259,8 +275,9 @@ static struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
 };
 /* Saffire Pro 26 I/O  */
 static struct snd_bebob_clock_spec saffirepro_26_clk_spec = {
-	.num	= ARRAY_SIZE(saffirepro_26_clk_src_labels),
+	.num	= ARRAY_SIZE(saffirepro_26_clk_src_types),
 	.labels	= saffirepro_26_clk_src_labels,
+	.types	= saffirepro_26_clk_src_types,
 	.get	= &saffirepro_both_clk_src_get,
 };
 struct snd_bebob_spec saffirepro_26_spec = {
@@ -270,8 +287,9 @@ struct snd_bebob_spec saffirepro_26_spec = {
 };
 /* Saffire Pro 10 I/O */
 static struct snd_bebob_clock_spec saffirepro_10_clk_spec = {
-	.num	= ARRAY_SIZE(saffirepro_10_clk_src_labels),
+	.num	= ARRAY_SIZE(saffirepro_10_clk_src_types),
 	.labels	= saffirepro_10_clk_src_labels,
+	.types	= saffirepro_10_clk_src_types,
 	.get	= &saffirepro_both_clk_src_get,
 };
 struct snd_bebob_spec saffirepro_10_spec = {
@@ -285,8 +303,9 @@ static struct snd_bebob_rate_spec saffire_both_rate_spec = {
 	.set	= &snd_bebob_stream_set_rate,
 };
 static struct snd_bebob_clock_spec saffire_both_clk_spec = {
-	.num	= ARRAY_SIZE(saffire_both_clk_src_labels),
+	.num	= ARRAY_SIZE(saffire_both_clk_src_types),
 	.labels	= saffire_both_clk_src_labels,
+	.types	= saffire_both_clk_src_types,
 	.get	= &saffire_both_clk_src_get,
 };
 /* Saffire LE */
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 9ee25a6..7a43afc 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -343,6 +343,12 @@ end:
 static const char *const special_clk_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL " with Digital Mute", "Digital",
 	"Word Clock", SND_BEBOB_CLOCK_INTERNAL};
+static enum snd_bebob_clock_type special_clk_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,	/* With digital mute */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* SPDIF/ADAT */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* Word Clock */
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+};
 static int special_clk_get(struct snd_bebob *bebob, unsigned int *id)
 {
 	struct special_params *params = bebob->maudio_special_quirk;
@@ -352,7 +358,7 @@ static int special_clk_get(struct snd_bebob *bebob, unsigned int *id)
 static int special_clk_ctl_info(struct snd_kcontrol *kctl,
 				struct snd_ctl_elem_info *einf)
 {
-	return snd_ctl_enum_info(einf, 1, ARRAY_SIZE(special_clk_labels),
+	return snd_ctl_enum_info(einf, 1, ARRAY_SIZE(special_clk_types),
 				 special_clk_labels);
 }
 static int special_clk_ctl_get(struct snd_kcontrol *kctl,
@@ -371,7 +377,7 @@ static int special_clk_ctl_put(struct snd_kcontrol *kctl,
 	int err, id;
 
 	id = uval->value.enumerated.item[0];
-	if (id >= ARRAY_SIZE(special_clk_labels))
+	if (id >= ARRAY_SIZE(special_clk_types))
 		return -EINVAL;
 
 	mutex_lock(&bebob->mutex);
@@ -708,8 +714,9 @@ static struct snd_bebob_rate_spec special_rate_spec = {
 	.set	= &special_set_rate,
 };
 static struct snd_bebob_clock_spec special_clk_spec = {
-	.num	= ARRAY_SIZE(special_clk_labels),
+	.num	= ARRAY_SIZE(special_clk_types),
 	.labels	= special_clk_labels,
+	.types	= special_clk_types,
 	.get	= &special_clk_get,
 };
 static struct snd_bebob_meter_spec special_meter_spec = {
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index ad63500..3b64d8d 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -11,6 +11,11 @@
 static const char *const phase88_rack_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "Digital In", "Word Clock"
 };
+static enum snd_bebob_clock_type phase88_rack_clk_src_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* Word Clock */
+};
 static int
 phase88_rack_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
@@ -37,10 +42,23 @@ end:
 static const char *const phase24_series_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "Digital In"
 };
+static enum snd_bebob_clock_type phase24_series_clk_src_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
+};
 static int
 phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
-	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+	int err;
+
+	err = avc_audio_get_selector(bebob->unit, 0, 4, id);
+	if (err < 0)
+		return err;
+
+	if (*id >= ARRAY_SIZE(phase24_series_clk_src_types))
+		return -EIO;
+
+	return 0;
 }
 
 static struct snd_bebob_rate_spec phase_series_rate_spec = {
@@ -50,8 +68,9 @@ static struct snd_bebob_rate_spec phase_series_rate_spec = {
 
 /* PHASE 88 Rack FW */
 static struct snd_bebob_clock_spec phase88_rack_clk = {
-	.num	= ARRAY_SIZE(phase88_rack_clk_src_labels),
+	.num	= ARRAY_SIZE(phase88_rack_clk_src_types),
 	.labels	= phase88_rack_clk_src_labels,
+	.types	= phase88_rack_clk_src_types,
 	.get	= &phase88_rack_clk_src_get,
 };
 struct snd_bebob_spec phase88_rack_spec = {
@@ -62,8 +81,9 @@ struct snd_bebob_spec phase88_rack_spec = {
 
 /* 'PHASE 24 FW' and 'PHASE X24 FW' */
 static struct snd_bebob_clock_spec phase24_series_clk = {
-	.num	= ARRAY_SIZE(phase24_series_clk_src_labels),
+	.num	= ARRAY_SIZE(phase24_series_clk_src_types),
 	.labels	= phase24_series_clk_src_labels,
+	.types	= phase24_series_clk_src_types,
 	.get	= &phase24_series_clk_src_get,
 };
 struct snd_bebob_spec phase24_series_spec = {
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
index ef1fe38..2f59512 100644
--- a/sound/firewire/bebob/bebob_yamaha.c
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -29,13 +29,27 @@
  */
 
 static const char *const clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
+static enum snd_bebob_clock_type clk_src_types[] = {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
+};
 static int
 clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
-	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+	int err;
+
+	err = avc_audio_get_selector(bebob->unit, 0, 4, id);
+	if (err < 0)
+		return err;
+
+	if (*id >= ARRAY_SIZE(clk_src_types))
+		return -EIO;
+
+	return 0;
 }
 static struct snd_bebob_clock_spec clock_spec = {
-	.num	= ARRAY_SIZE(clk_src_labels),
+	.num	= ARRAY_SIZE(clk_src_types),
+	.types	= clk_src_types,
 	.labels	= clk_src_labels,
 	.get	= &clk_src_get,
 };
-- 
2.1.4
