From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: bebob: unify configurations for some
	models produced by Yamaha/Terratec
Date: Wed, 24 Aug 2016 21:42:43 +0900
Message-ID: <1472042563-24634-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1472042563-24634-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 89B0A26885E
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:42:49 +0200 (CEST)
In-Reply-To: <1472042563-24634-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The below models were developed with a cooperation by Yamaha and Terratec.
 - Yamaha GO 44/Terratec PHASE 24 FW
 - Yamaha GO 46/Terratec PHASE X24 FW

They have the same configurations, thus it's better to unify corresponding
codes.

This commit merges them to reduce the amount of maintained codes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c                 |  8 +++----
 sound/firewire/bebob/bebob.h                 |  3 +--
 sound/firewire/bebob/bebob_terratec.c        | 31 ----------------------------
 sound/firewire/bebob/bebob_yamaha_terratec.c |  5 ++++-
 4 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index f7e2cbd..3469ac14 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -458,17 +458,17 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* TerraTec Electronic GmbH, PHASE 88 Rack FW */
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000003, &phase88_rack_spec),
 	/* TerraTec Electronic GmbH, PHASE 24 FW */
-	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000004, &phase24_series_spec),
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000004, &yamaha_terratec_spec),
 	/* TerraTec Electronic GmbH, Phase X24 FW */
-	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000007, &phase24_series_spec),
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000007, &yamaha_terratec_spec),
 	/* TerraTec Electronic GmbH, EWS MIC2/MIC8 */
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000005, &spec_normal),
 	/* Terratec Electronic GmbH, Aureon 7.1 Firewire */
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000002, &spec_normal),
 	/* Yamaha, GO44 */
-	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000b, &yamaha_go_spec),
+	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000b, &yamaha_terratec_spec),
 	/* YAMAHA, GO46 */
-	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000c, &yamaha_go_spec),
+	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000c, &yamaha_terratec_spec),
 	/* Focusrite, SaffirePro 26 I/O */
 	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, 0x00000003, &saffirepro_26_spec),
 	/* Focusrite, SaffirePro 10 I/O */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index e7f1bb9..175da87 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -235,8 +235,7 @@ int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 
 /* model specific operations */
 extern const struct snd_bebob_spec phase88_rack_spec;
-extern const struct snd_bebob_spec phase24_series_spec;
-extern const struct snd_bebob_spec yamaha_go_spec;
+extern const struct snd_bebob_spec yamaha_terratec_spec;
 extern const struct snd_bebob_spec saffirepro_26_spec;
 extern const struct snd_bebob_spec saffirepro_10_spec;
 extern const struct snd_bebob_spec saffire_le_spec;
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index c38358b..2fdaf93 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -36,25 +36,6 @@ end:
 	return err;
 }
 
-static enum snd_bebob_clock_type phase24_series_clk_src_types[] = {
-	SND_BEBOB_CLOCK_TYPE_INTERNAL,
-	SND_BEBOB_CLOCK_TYPE_EXTERNAL,	/* S/PDIF */
-};
-static int
-phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
-{
-	int err;
-
-	err = avc_audio_get_selector(bebob->unit, 0, 4, id);
-	if (err < 0)
-		return err;
-
-	if (*id >= ARRAY_SIZE(phase24_series_clk_src_types))
-		return -EIO;
-
-	return 0;
-}
-
 static const struct snd_bebob_rate_spec phase_series_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
@@ -71,15 +52,3 @@ const struct snd_bebob_spec phase88_rack_spec = {
 	.rate	= &phase_series_rate_spec,
 	.meter	= NULL
 };
-
-/* 'PHASE 24 FW' and 'PHASE X24 FW' */
-static const struct snd_bebob_clock_spec phase24_series_clk = {
-	.num	= ARRAY_SIZE(phase24_series_clk_src_types),
-	.types	= phase24_series_clk_src_types,
-	.get	= &phase24_series_clk_src_get,
-};
-const struct snd_bebob_spec phase24_series_spec = {
-	.clock	= &phase24_series_clk,
-	.rate	= &phase_series_rate_spec,
-	.meter	= NULL
-};
diff --git a/sound/firewire/bebob/bebob_yamaha_terratec.c b/sound/firewire/bebob/bebob_yamaha_terratec.c
index 5c5d7d3..a6be3e7 100644
--- a/sound/firewire/bebob/bebob_yamaha_terratec.c
+++ b/sound/firewire/bebob/bebob_yamaha_terratec.c
@@ -26,6 +26,9 @@
  * Unfortunately current 'ffado-mixer' generated many asynchronous transaction
  * to observe device's state, mainly check cmp connection and signal format. I
  * recommend users to close ffado-mixer at 192.0kHz if mixer is needless.
+ *
+ * Terratec PHASE 24 FW and PHASE X24 FW are internally the same as
+ * Yamaha GO 44 and GO 46. Yamaha and Terratec had cooperated for these models.
  */
 
 static enum snd_bebob_clock_type clk_src_types[] = {
@@ -55,7 +58,7 @@ static const struct snd_bebob_rate_spec rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
 };
-const struct snd_bebob_spec yamaha_go_spec = {
+const struct snd_bebob_spec yamaha_terratec_spec = {
 	.clock	= &clock_spec,
 	.rate	= &rate_spec,
 	.meter	= NULL
-- 
2.7.4
