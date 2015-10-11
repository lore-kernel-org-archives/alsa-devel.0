From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v3] ALSA: bebob: constify various snd_bebob structures
Date: Sun, 11 Oct 2015 08:10:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1510110808470.2057@localhost6.localdomain6>
References: <1444484390-22158-1-git-send-email-Julia.Lawall@lip6.fr> <5619308C.7000601@sakamocchi.jp> <alpine.DEB.2.02.1510102323080.2053@localhost6.localdomain6> <5619DA57.6010705@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5619DA57.6010705@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The structures of type snd_bebob_clock_spec, snd_bebob_rate_spec,
snd_bebob_meter_spec, and snd_bebob_spec are never modified after they are
initialized.  Make them all const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v3: change subject line

 sound/firewire/bebob/bebob.c           |    2 +-
 sound/firewire/bebob/bebob.h           |   32 ++++++++++++++++----------------
 sound/firewire/bebob/bebob_focusrite.c |   26 +++++++++++++-------------
 sound/firewire/bebob/bebob_maudio.c    |   32 ++++++++++++++++----------------
 sound/firewire/bebob/bebob_pcm.c       |    2 +-
 sound/firewire/bebob/bebob_proc.c      |    6 +++---
 sound/firewire/bebob/bebob_stream.c    |    6 +++---
 sound/firewire/bebob/bebob_terratec.c  |   10 +++++-----
 sound/firewire/bebob/bebob_yamaha.c    |    6 +++---
 9 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 0ed5e5f..091290d 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -335,7 +335,7 @@ static void bebob_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(bebob->card);
 }
 
-static struct snd_bebob_rate_spec normal_rate_spec = {
+static const struct snd_bebob_rate_spec normal_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate
 };
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
index a1a3949..f110900 100644
--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -200,7 +200,7 @@ end:
 	return err;
 }
 
-struct snd_bebob_spec saffire_le_spec;
+const struct snd_bebob_spec saffire_le_spec;
 static enum snd_bebob_clock_type saffire_both_clk_src_types[] = {
 	SND_BEBOB_CLOCK_TYPE_INTERNAL,
 	SND_BEBOB_CLOCK_TYPE_EXTERNAL,
@@ -229,7 +229,7 @@ static const char *const saffire_meter_labels[] = {
 static int
 saffire_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
 {
-	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+	const struct snd_bebob_meter_spec *spec = bebob->spec->meter;
 	unsigned int channels;
 	u64 offset;
 	int err;
@@ -260,60 +260,60 @@ saffire_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
 	return err;
 }
 
-static struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
+static const struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
 	.get	= &saffirepro_both_clk_freq_get,
 	.set	= &saffirepro_both_clk_freq_set,
 };
 /* Saffire Pro 26 I/O  */
-static struct snd_bebob_clock_spec saffirepro_26_clk_spec = {
+static const struct snd_bebob_clock_spec saffirepro_26_clk_spec = {
 	.num	= ARRAY_SIZE(saffirepro_26_clk_src_types),
 	.types	= saffirepro_26_clk_src_types,
 	.get	= &saffirepro_both_clk_src_get,
 };
-struct snd_bebob_spec saffirepro_26_spec = {
+const struct snd_bebob_spec saffirepro_26_spec = {
 	.clock	= &saffirepro_26_clk_spec,
 	.rate	= &saffirepro_both_rate_spec,
 	.meter	= NULL
 };
 /* Saffire Pro 10 I/O */
-static struct snd_bebob_clock_spec saffirepro_10_clk_spec = {
+static const struct snd_bebob_clock_spec saffirepro_10_clk_spec = {
 	.num	= ARRAY_SIZE(saffirepro_10_clk_src_types),
 	.types	= saffirepro_10_clk_src_types,
 	.get	= &saffirepro_both_clk_src_get,
 };
-struct snd_bebob_spec saffirepro_10_spec = {
+const struct snd_bebob_spec saffirepro_10_spec = {
 	.clock	= &saffirepro_10_clk_spec,
 	.rate	= &saffirepro_both_rate_spec,
 	.meter	= NULL
 };
 
-static struct snd_bebob_rate_spec saffire_both_rate_spec = {
+static const struct snd_bebob_rate_spec saffire_both_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
 };
-static struct snd_bebob_clock_spec saffire_both_clk_spec = {
+static const struct snd_bebob_clock_spec saffire_both_clk_spec = {
 	.num	= ARRAY_SIZE(saffire_both_clk_src_types),
 	.types	= saffire_both_clk_src_types,
 	.get	= &saffire_both_clk_src_get,
 };
 /* Saffire LE */
-static struct snd_bebob_meter_spec saffire_le_meter_spec = {
+static const struct snd_bebob_meter_spec saffire_le_meter_spec = {
 	.num	= ARRAY_SIZE(saffire_le_meter_labels),
 	.labels	= saffire_le_meter_labels,
 	.get	= &saffire_meter_get,
 };
-struct snd_bebob_spec saffire_le_spec = {
+const struct snd_bebob_spec saffire_le_spec = {
 	.clock	= &saffire_both_clk_spec,
 	.rate	= &saffire_both_rate_spec,
 	.meter	= &saffire_le_meter_spec
 };
 /* Saffire */
-static struct snd_bebob_meter_spec saffire_meter_spec = {
+static const struct snd_bebob_meter_spec saffire_meter_spec = {
 	.num	= ARRAY_SIZE(saffire_meter_labels),
 	.labels	= saffire_meter_labels,
 	.get	= &saffire_meter_get,
 };
-struct snd_bebob_spec saffire_spec = {
+const struct snd_bebob_spec saffire_spec = {
 	.clock	= &saffire_both_clk_spec,
 	.rate	= &saffire_both_rate_spec,
 	.meter	= &saffire_meter_spec
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index d3c9d8d..4d8fcc7 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -70,9 +70,9 @@ struct snd_bebob_meter_spec {
 	int (*get)(struct snd_bebob *bebob, u32 *target, unsigned int size);
 };
 struct snd_bebob_spec {
-	struct snd_bebob_clock_spec *clock;
-	struct snd_bebob_rate_spec *rate;
-	struct snd_bebob_meter_spec *meter;
+	const struct snd_bebob_clock_spec *clock;
+	const struct snd_bebob_rate_spec *rate;
+	const struct snd_bebob_meter_spec *meter;
 };
 
 struct snd_bebob {
@@ -235,19 +235,19 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 
 /* model specific operations */
-extern struct snd_bebob_spec phase88_rack_spec;
-extern struct snd_bebob_spec phase24_series_spec;
-extern struct snd_bebob_spec yamaha_go_spec;
-extern struct snd_bebob_spec saffirepro_26_spec;
-extern struct snd_bebob_spec saffirepro_10_spec;
-extern struct snd_bebob_spec saffire_le_spec;
-extern struct snd_bebob_spec saffire_spec;
-extern struct snd_bebob_spec maudio_fw410_spec;
-extern struct snd_bebob_spec maudio_audiophile_spec;
-extern struct snd_bebob_spec maudio_solo_spec;
-extern struct snd_bebob_spec maudio_ozonic_spec;
-extern struct snd_bebob_spec maudio_nrv10_spec;
-extern struct snd_bebob_spec maudio_special_spec;
+extern const struct snd_bebob_spec phase88_rack_spec;
+extern const struct snd_bebob_spec phase24_series_spec;
+extern const struct snd_bebob_spec yamaha_go_spec;
+extern const struct snd_bebob_spec saffirepro_26_spec;
+extern const struct snd_bebob_spec saffirepro_10_spec;
+extern const struct snd_bebob_spec saffire_le_spec;
+extern const struct snd_bebob_spec saffire_spec;
+extern const struct snd_bebob_spec maudio_fw410_spec;
+extern const struct snd_bebob_spec maudio_audiophile_spec;
+extern const struct snd_bebob_spec maudio_solo_spec;
+extern const struct snd_bebob_spec maudio_ozonic_spec;
+extern const struct snd_bebob_spec maudio_nrv10_spec;
+extern const struct snd_bebob_spec maudio_special_spec;
 int snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814);
 int snd_bebob_maudio_load_firmware(struct fw_unit *unit);
 
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 057495d..7b86a6b 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -687,7 +687,7 @@ static const char *const nrv10_meter_labels[] = {
 static int
 normal_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
 {
-	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+	const struct snd_bebob_meter_spec *spec = bebob->spec->meter;
 	unsigned int c, channels;
 	int err;
 
@@ -712,85 +712,85 @@ end:
 }
 
 /* for special customized devices */
-static struct snd_bebob_rate_spec special_rate_spec = {
+static const struct snd_bebob_rate_spec special_rate_spec = {
 	.get	= &special_get_rate,
 	.set	= &special_set_rate,
 };
-static struct snd_bebob_clock_spec special_clk_spec = {
+static const struct snd_bebob_clock_spec special_clk_spec = {
 	.num	= ARRAY_SIZE(special_clk_types),
 	.types	= special_clk_types,
 	.get	= &special_clk_get,
 };
-static struct snd_bebob_meter_spec special_meter_spec = {
+static const struct snd_bebob_meter_spec special_meter_spec = {
 	.num	= ARRAY_SIZE(special_meter_labels),
 	.labels	= special_meter_labels,
 	.get	= &special_meter_get
 };
-struct snd_bebob_spec maudio_special_spec = {
+const struct snd_bebob_spec maudio_special_spec = {
 	.clock	= &special_clk_spec,
 	.rate	= &special_rate_spec,
 	.meter	= &special_meter_spec
 };
 
 /* Firewire 410 specification */
-static struct snd_bebob_rate_spec usual_rate_spec = {
+static const struct snd_bebob_rate_spec usual_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
 };
-static struct snd_bebob_meter_spec fw410_meter_spec = {
+static const struct snd_bebob_meter_spec fw410_meter_spec = {
 	.num	= ARRAY_SIZE(fw410_meter_labels),
 	.labels	= fw410_meter_labels,
 	.get	= &normal_meter_get
 };
-struct snd_bebob_spec maudio_fw410_spec = {
+const struct snd_bebob_spec maudio_fw410_spec = {
 	.clock	= NULL,
 	.rate	= &usual_rate_spec,
 	.meter	= &fw410_meter_spec
 };
 
 /* Firewire Audiophile specification */
-static struct snd_bebob_meter_spec audiophile_meter_spec = {
+static const struct snd_bebob_meter_spec audiophile_meter_spec = {
 	.num	= ARRAY_SIZE(audiophile_meter_labels),
 	.labels	= audiophile_meter_labels,
 	.get	= &normal_meter_get
 };
-struct snd_bebob_spec maudio_audiophile_spec = {
+const struct snd_bebob_spec maudio_audiophile_spec = {
 	.clock	= NULL,
 	.rate	= &usual_rate_spec,
 	.meter	= &audiophile_meter_spec
 };
 
 /* Firewire Solo specification */
-static struct snd_bebob_meter_spec solo_meter_spec = {
+static const struct snd_bebob_meter_spec solo_meter_spec = {
 	.num	= ARRAY_SIZE(solo_meter_labels),
 	.labels	= solo_meter_labels,
 	.get	= &normal_meter_get
 };
-struct snd_bebob_spec maudio_solo_spec = {
+const struct snd_bebob_spec maudio_solo_spec = {
 	.clock	= NULL,
 	.rate	= &usual_rate_spec,
 	.meter	= &solo_meter_spec
 };
 
 /* Ozonic specification */
-static struct snd_bebob_meter_spec ozonic_meter_spec = {
+static const struct snd_bebob_meter_spec ozonic_meter_spec = {
 	.num	= ARRAY_SIZE(ozonic_meter_labels),
 	.labels	= ozonic_meter_labels,
 	.get	= &normal_meter_get
 };
-struct snd_bebob_spec maudio_ozonic_spec = {
+const struct snd_bebob_spec maudio_ozonic_spec = {
 	.clock	= NULL,
 	.rate	= &usual_rate_spec,
 	.meter	= &ozonic_meter_spec
 };
 
 /* NRV10 specification */
-static struct snd_bebob_meter_spec nrv10_meter_spec = {
+static const struct snd_bebob_meter_spec nrv10_meter_spec = {
 	.num	= ARRAY_SIZE(nrv10_meter_labels),
 	.labels	= nrv10_meter_labels,
 	.get	= &normal_meter_get
 };
-struct snd_bebob_spec maudio_nrv10_spec = {
+const struct snd_bebob_spec maudio_nrv10_spec = {
 	.clock	= NULL,
 	.rate	= &usual_rate_spec,
 	.meter	= &nrv10_meter_spec
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 2fdc1f1..ef224d6 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -155,7 +155,7 @@ static int
 pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
-	struct snd_bebob_rate_spec *spec = bebob->spec->rate;
+	const struct snd_bebob_rate_spec *spec = bebob->spec->rate;
 	unsigned int sampling_rate;
 	enum snd_bebob_clock_type src;
 	int err;
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
index 301cc6a..ec24f96 100644
--- a/sound/firewire/bebob/bebob_proc.c
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -73,7 +73,7 @@ proc_read_meters(struct snd_info_entry *entry,
 		 struct snd_info_buffer *buffer)
 {
 	struct snd_bebob *bebob = entry->private_data;
-	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+	const struct snd_bebob_meter_spec *spec = bebob->spec->meter;
 	u32 *buf;
 	unsigned int i, c, channels, size;
 
@@ -138,8 +138,8 @@ proc_read_clock(struct snd_info_entry *entry,
 		"SYT-Match",
 	};
 	struct snd_bebob *bebob = entry->private_data;
-	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
-	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
+	const struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
+	const struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	enum snd_bebob_clock_type src;
 	unsigned int rate;
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index a2baa47..926e5dc 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -119,7 +119,7 @@ end:
 int snd_bebob_stream_get_clock_src(struct snd_bebob *bebob,
 				   enum snd_bebob_clock_type *src)
 {
-	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
+	const struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	u8 addr[AVC_BRIDGECO_ADDR_BYTES], input[7];
 	unsigned int id;
 	enum avc_bridgeco_plug_type type;
@@ -580,7 +580,7 @@ end:
 
 int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 {
-	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
+	const struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
 	struct amdtp_stream *master, *slave;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
@@ -967,7 +967,7 @@ end:
 
 int snd_bebob_stream_discover(struct snd_bebob *bebob)
 {
-	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
+	const struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	u8 plugs[AVC_PLUG_INFO_BUF_BYTES], addr[AVC_BRIDGECO_ADDR_BYTES];
 	enum avc_bridgeco_plug_type type;
 	unsigned int i;
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index 9242e33..c38358b 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -55,30 +55,30 @@ phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 	return 0;
 }
 
-static struct snd_bebob_rate_spec phase_series_rate_spec = {
+static const struct snd_bebob_rate_spec phase_series_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
 };
 
 /* PHASE 88 Rack FW */
-static struct snd_bebob_clock_spec phase88_rack_clk = {
+static const struct snd_bebob_clock_spec phase88_rack_clk = {
 	.num	= ARRAY_SIZE(phase88_rack_clk_src_types),
 	.types	= phase88_rack_clk_src_types,
 	.get	= &phase88_rack_clk_src_get,
 };
-struct snd_bebob_spec phase88_rack_spec = {
+const struct snd_bebob_spec phase88_rack_spec = {
 	.clock	= &phase88_rack_clk,
 	.rate	= &phase_series_rate_spec,
 	.meter	= NULL
 };
 
 /* 'PHASE 24 FW' and 'PHASE X24 FW' */
-static struct snd_bebob_clock_spec phase24_series_clk = {
+static const struct snd_bebob_clock_spec phase24_series_clk = {
 	.num	= ARRAY_SIZE(phase24_series_clk_src_types),
 	.types	= phase24_series_clk_src_types,
 	.get	= &phase24_series_clk_src_get,
 };
-struct snd_bebob_spec phase24_series_spec = {
+const struct snd_bebob_spec phase24_series_spec = {
 	.clock	= &phase24_series_clk,
 	.rate	= &phase_series_rate_spec,
 	.meter	= NULL
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
index 5810170..90d4404 100644
--- a/sound/firewire/bebob/bebob_yamaha.c
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -46,16 +46,16 @@ clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 
 	return 0;
 }
-static struct snd_bebob_clock_spec clock_spec = {
+static const struct snd_bebob_clock_spec clock_spec = {
 	.num	= ARRAY_SIZE(clk_src_types),
 	.types	= clk_src_types,
 	.get	= &clk_src_get,
 };
-static struct snd_bebob_rate_spec rate_spec = {
+static const struct snd_bebob_rate_spec rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
 };
-struct snd_bebob_spec yamaha_go_spec = {
+const struct snd_bebob_spec yamaha_go_spec = {
 	.clock	= &clock_spec,
 	.rate	= &rate_spec,
 	.meter	= NULL
