From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/43] ALSA: bebob: More constify text arrays
Date: Tue, 21 Oct 2014 12:10:43 +0200
Message-ID: <1413886279-18704-8-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CF42726663B
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0C29DAD2B
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:23 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/firewire/bebob/bebob.h           |  4 ++--
 sound/firewire/bebob/bebob_focusrite.c | 10 +++++-----
 sound/firewire/bebob/bebob_maudio.c    | 18 +++++++++---------
 sound/firewire/bebob/bebob_terratec.c  |  4 ++--
 sound/firewire/bebob/bebob_yamaha.c    |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index e13eef99c27a..dfbcd233178c 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -52,7 +52,7 @@ extern const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES];
 #define SND_BEBOB_CLOCK_INTERNAL	"Internal"
 struct snd_bebob_clock_spec {
 	unsigned int num;
-	char *const *labels;
+	const char *const *labels;
 	int (*get)(struct snd_bebob *bebob, unsigned int *id);
 };
 struct snd_bebob_rate_spec {
@@ -61,7 +61,7 @@ struct snd_bebob_rate_spec {
 };
 struct snd_bebob_meter_spec {
 	unsigned int num;
-	char *const *labels;
+	const char *const *labels;
 	int (*get)(struct snd_bebob *bebob, u32 *target, unsigned int size);
 };
 struct snd_bebob_spec {
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
index 45a0eed6d5b1..a45a86952a41 100644
--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -101,11 +101,11 @@ saffire_write_quad(struct snd_bebob *bebob, u64 offset, u32 value)
 				  &data, sizeof(__be32), 0);
 }
 
-static char *const saffirepro_26_clk_src_labels[] = {
+static const char *const saffirepro_26_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "ADAT1", "ADAT2", "Word Clock"
 };
 
-static char *const saffirepro_10_clk_src_labels[] = {
+static const char *const saffirepro_10_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "Word Clock"
 };
 static int
@@ -161,7 +161,7 @@ end:
 }
 
 struct snd_bebob_spec saffire_le_spec;
-static char *const saffire_both_clk_src_labels[] = {
+static const char *const saffire_both_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF"
 };
 static int
@@ -176,12 +176,12 @@ saffire_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 
 	return err;
 };
-static char *const saffire_le_meter_labels[] = {
+static const char *const saffire_le_meter_labels[] = {
 	ANA_IN, ANA_IN, DIG_IN,
 	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT,
 	STM_IN, STM_IN
 };
-static char *const saffire_meter_labels[] = {
+static const char *const saffire_meter_labels[] = {
 	ANA_IN, ANA_IN,
 	STM_IN, STM_IN, STM_IN, STM_IN, STM_IN,
 };
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 70faa3a32526..34cba8037b36 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -340,7 +340,7 @@ end:
 }
 
 /* Clock source control for special firmware */
-static char *const special_clk_labels[] = {
+static const char *const special_clk_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL " with Digital Mute", "Digital",
 	"Word Clock", SND_BEBOB_CLOCK_INTERNAL};
 static int special_clk_get(struct snd_bebob *bebob, unsigned int *id)
@@ -438,7 +438,7 @@ static struct snd_kcontrol_new special_sync_ctl = {
 };
 
 /* Digital input interface control for special firmware */
-static char *const special_dig_in_iface_labels[] = {
+static const char *const special_dig_in_iface_labels[] = {
 	"S/PDIF Optical", "S/PDIF Coaxial", "ADAT Optical"
 };
 static int special_dig_in_iface_ctl_info(struct snd_kcontrol *kctl,
@@ -539,7 +539,7 @@ static struct snd_kcontrol_new special_dig_in_iface_ctl = {
 };
 
 /* Digital output interface control for special firmware */
-static char *const special_dig_out_iface_labels[] = {
+static const char *const special_dig_out_iface_labels[] = {
 	"S/PDIF Optical and Coaxial", "ADAT Optical"
 };
 static int special_dig_out_iface_ctl_info(struct snd_kcontrol *kctl,
@@ -631,7 +631,7 @@ end:
 }
 
 /* Hardware metering for special firmware */
-static char *const special_meter_labels[] = {
+static const char *const special_meter_labels[] = {
 	ANA_IN, ANA_IN, ANA_IN, ANA_IN,
 	SPDIF_IN,
 	ADAT_IN, ADAT_IN, ADAT_IN, ADAT_IN,
@@ -671,30 +671,30 @@ end:
 }
 
 /* last 4 bytes are omitted because it's clock info. */
-static char *const fw410_meter_labels[] = {
+static const char *const fw410_meter_labels[] = {
 	ANA_IN, DIG_IN,
 	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT, DIG_OUT,
 	HP_OUT
 };
-static char *const audiophile_meter_labels[] = {
+static const char *const audiophile_meter_labels[] = {
 	ANA_IN, DIG_IN,
 	ANA_OUT, ANA_OUT, DIG_OUT,
 	HP_OUT, AUX_OUT,
 };
-static char *const solo_meter_labels[] = {
+static const char *const solo_meter_labels[] = {
 	ANA_IN, DIG_IN,
 	STRM_IN, STRM_IN,
 	ANA_OUT, DIG_OUT
 };
 
 /* no clock info */
-static char *const ozonic_meter_labels[] = {
+static const char *const ozonic_meter_labels[] = {
 	ANA_IN, ANA_IN,
 	STRM_IN, STRM_IN,
 	ANA_OUT, ANA_OUT
 };
 /* TODO: need testers. these positions are based on authour's assumption */
-static char *const nrv10_meter_labels[] = {
+static const char *const nrv10_meter_labels[] = {
 	ANA_IN, ANA_IN, ANA_IN, ANA_IN,
 	DIG_IN,
 	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT,
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index 0e4c0bfc463b..83b677224f1f 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -8,7 +8,7 @@
 
 #include "./bebob.h"
 
-static char *const phase88_rack_clk_src_labels[] = {
+static const char *const phase88_rack_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "Digital In", "Word Clock"
 };
 static int
@@ -29,7 +29,7 @@ end:
 	return err;
 }
 
-static char *const phase24_series_clk_src_labels[] = {
+static const char *const phase24_series_clk_src_labels[] = {
 	SND_BEBOB_CLOCK_INTERNAL, "Digital In"
 };
 static int
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
index 9b7e798180ff..ef1fe3823a9c 100644
--- a/sound/firewire/bebob/bebob_yamaha.c
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -28,7 +28,7 @@
  * reccomend users to close ffado-mixer at 192.0kHz if mixer is needless.
  */
 
-static char *const clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
+static const char *const clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
 static int
 clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
-- 
2.1.2
