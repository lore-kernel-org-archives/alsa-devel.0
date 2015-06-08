From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/11] ALSA: bebob: obsolete string literal
	expression for clock source
Date: Mon,  8 Jun 2015 23:31:02 +0900
Message-ID: <1433773868-17505-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AFF62604B8
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 16:31:17 +0200 (CEST)
In-Reply-To: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
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

The old string literals were completely replaced by new normalized
representation.

This commit obsoletes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h           |  1 -
 sound/firewire/bebob/bebob_focusrite.c | 12 ------------
 sound/firewire/bebob/bebob_maudio.c    | 10 ++++++----
 sound/firewire/bebob/bebob_terratec.c  |  8 --------
 sound/firewire/bebob/bebob_yamaha.c    |  2 --
 5 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index f9f2180..76a65cc 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -49,7 +49,6 @@ struct snd_bebob_stream_formation {
 extern const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES];
 
 /* device specific operations */
-#define SND_BEBOB_CLOCK_INTERNAL	"Internal"
 enum snd_bebob_clock_type {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL = 0,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
index 45c8f76..a1a3949 100644
--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -103,17 +103,11 @@ saffire_write_quad(struct snd_bebob *bebob, u64 offset, u32 value)
 				  &data, sizeof(__be32), 0);
 }
 
-static const char *const saffirepro_10_clk_src_labels[] = {
-	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "Word Clock"
-};
 static enum snd_bebob_clock_type saffirepro_10_clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* Word Clock */
 };
-static const char *const saffirepro_26_clk_src_labels[] = {
-	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "ADAT1", "ADAT2", "Word Clock"
-};
 static enum snd_bebob_clock_type saffirepro_26_clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
@@ -207,9 +201,6 @@ end:
 }
 
 struct snd_bebob_spec saffire_le_spec;
-static const char *const saffire_both_clk_src_labels[] = {
-	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF"
-};
 static enum snd_bebob_clock_type saffire_both_clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,
@@ -276,7 +267,6 @@ static struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
 /* Saffire Pro 26 I/O  */
 static struct snd_bebob_clock_spec saffirepro_26_clk_spec = {
 	.num	= ARRAY_SIZE(saffirepro_26_clk_src_types),
-	.labels	= saffirepro_26_clk_src_labels,
 	.types	= saffirepro_26_clk_src_types,
 	.get	= &saffirepro_both_clk_src_get,
 };
@@ -288,7 +278,6 @@ struct snd_bebob_spec saffirepro_26_spec = {
 /* Saffire Pro 10 I/O */
 static struct snd_bebob_clock_spec saffirepro_10_clk_spec = {
 	.num	= ARRAY_SIZE(saffirepro_10_clk_src_types),
-	.labels	= saffirepro_10_clk_src_labels,
 	.types	= saffirepro_10_clk_src_types,
 	.get	= &saffirepro_both_clk_src_get,
 };
@@ -304,7 +293,6 @@ static struct snd_bebob_rate_spec saffire_both_rate_spec = {
 };
 static struct snd_bebob_clock_spec saffire_both_clk_spec = {
 	.num	= ARRAY_SIZE(saffire_both_clk_src_types),
-	.labels	= saffire_both_clk_src_labels,
 	.types	= saffire_both_clk_src_types,
 	.get	= &saffire_both_clk_src_get,
 };
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 7a43afc..057495d 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -340,9 +340,6 @@ end:
 }
 
 /* Clock source control for special firmware */
-static const char *const special_clk_labels[] = {
-	SND_BEBOB_CLOCK_INTERNAL " with Digital Mute", "Digital",
-	"Word Clock", SND_BEBOB_CLOCK_INTERNAL};
 static enum snd_bebob_clock_type special_clk_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,	/* With digital mute */
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* SPDIF/ADAT */
@@ -358,6 +355,12 @@ static int special_clk_get(struct snd_bebob *bebob, unsigned int *id)
 static int special_clk_ctl_info(struct snd_kcontrol *kctl,
 				struct snd_ctl_elem_info *einf)
 {
+	static const char *const special_clk_labels[] = {
+		"Internal with Digital Mute",
+		"Digital",
+		"Word Clock",
+		"Internal"
+	};
 	return snd_ctl_enum_info(einf, 1, ARRAY_SIZE(special_clk_types),
 				 special_clk_labels);
 }
@@ -715,7 +718,6 @@ static struct snd_bebob_rate_spec special_rate_spec = {
 };
 static struct snd_bebob_clock_spec special_clk_spec = {
 	.num	= ARRAY_SIZE(special_clk_types),
-	.labels	= special_clk_labels,
 	.types	= special_clk_types,
 	.get	= &special_clk_get,
 };
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index 3b64d8d..9242e33 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -8,9 +8,6 @@
 
 #include "./bebob.h"
 
-static const char *const phase88_rack_clk_src_labels[] = {
-	SND_BEBOB_CLOCK_INTERNAL, "Digital In", "Word Clock"
-};
 static enum snd_bebob_clock_type phase88_rack_clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
@@ -39,9 +36,6 @@ end:
 	return err;
 }
 
-static const char *const phase24_series_clk_src_labels[] = {
-	SND_BEBOB_CLOCK_INTERNAL, "Digital In"
-};
 static enum snd_bebob_clock_type phase24_series_clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
@@ -69,7 +63,6 @@ static struct snd_bebob_rate_spec phase_series_rate_spec = {
 /* PHASE 88 Rack FW */
 static struct snd_bebob_clock_spec phase88_rack_clk = {
 	.num	= ARRAY_SIZE(phase88_rack_clk_src_types),
-	.labels	= phase88_rack_clk_src_labels,
 	.types	= phase88_rack_clk_src_types,
 	.get	= &phase88_rack_clk_src_get,
 };
@@ -82,7 +75,6 @@ struct snd_bebob_spec phase88_rack_spec = {
 /* 'PHASE 24 FW' and 'PHASE X24 FW' */
 static struct snd_bebob_clock_spec phase24_series_clk = {
 	.num	= ARRAY_SIZE(phase24_series_clk_src_types),
-	.labels	= phase24_series_clk_src_labels,
 	.types	= phase24_series_clk_src_types,
 	.get	= &phase24_series_clk_src_get,
 };
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
index 2f59512..5810170 100644
--- a/sound/firewire/bebob/bebob_yamaha.c
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -28,7 +28,6 @@
  * reccomend users to close ffado-mixer at 192.0kHz if mixer is needless.
  */
 
-static const char *const clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
 static enum snd_bebob_clock_type clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
@@ -50,7 +49,6 @@ clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 static struct snd_bebob_clock_spec clock_spec = {
 	.num	= ARRAY_SIZE(clk_src_types),
 	.types	= clk_src_types,
-	.labels	= clk_src_labels,
 	.get	= &clk_src_get,
 };
 static struct snd_bebob_rate_spec rate_spec = {
-- 
2.1.4
