From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/7] ALSA: firewire-tascam: add a structure for
	model-dependent parameters.
Date: Thu,  1 Oct 2015 22:02:12 +0900
Message-ID: <1443704537-3345-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1443704537-3345-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 82781266689
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 15:02:22 +0200 (CEST)
In-Reply-To: <1443704537-3345-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

TASCAM FireWire series doesn't tell drivers their capabilities, thus
the drivers should have model-dependent parameters and apply it to
detected devices.

This commit adds a structure to represent such parameters.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam.c | 36 ++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.h | 13 +++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 9f2d2a3..9ac09cb 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -12,6 +12,39 @@ MODULE_DESCRIPTION("TASCAM FireWire series Driver");
 MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
 MODULE_LICENSE("GPL v2");
 
+static struct snd_tscm_spec model_specs[] = {
+	{
+		.name = "FW-1884",
+		.has_adat = true,
+		.has_spdif = true,
+		.pcm_capture_analog_channels = 8,
+		.pcm_playback_analog_channels = 8,
+		.midi_capture_ports = 4,
+		.midi_playback_ports = 4,
+		.is_controller = true,
+	},
+	{
+		.name = "FW-1804",
+		.has_adat = true,
+		.has_spdif = true,
+		.pcm_capture_analog_channels = 8,
+		.pcm_playback_analog_channels = 2,
+		.midi_capture_ports = 2,
+		.midi_playback_ports = 4,
+		.is_controller = false,
+	},
+	{
+		.name = "FW-1082",
+		.has_adat = false,
+		.has_spdif = true,
+		.pcm_capture_analog_channels = 8,
+		.pcm_playback_analog_channels = 2,
+		.midi_capture_ports = 2,
+		.midi_playback_ports = 2,
+		.is_controller = true,
+	},
+};
+
 static int check_name(struct snd_tscm *tscm)
 {
 	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
@@ -72,6 +105,7 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	tscm = card->private_data;
 	tscm->card = card;
 	tscm->unit = fw_unit_get(unit);
+	tscm->spec = (const struct snd_tscm_spec *)entry->driver_data;
 
 	mutex_init(&tscm->mutex);
 
@@ -113,6 +147,7 @@ static const struct ieee1394_device_id snd_tscm_id_table[] = {
 		.vendor_id = 0x00022e,
 		.specifier_id = 0x00022e,
 		.version = 0x800003,
+		.driver_data = (kernel_ulong_t)&model_specs[2],
 	},
 	/* FW-1884 */
 	{
@@ -122,6 +157,7 @@ static const struct ieee1394_device_id snd_tscm_id_table[] = {
 		.vendor_id = 0x00022e,
 		.specifier_id = 0x00022e,
 		.version = 0x800000,
+		.driver_data = (kernel_ulong_t)&model_specs[0],
 	},
 	/* FW-1804 mey be supported if IDs are clear. */
 	/* FE-08 requires reverse-engineering because it just has faders. */
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index d2f4f67..e12f8b5 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -23,11 +23,24 @@
 
 #include "../lib.h"
 
+struct snd_tscm_spec {
+	const char *const name;
+	bool has_adat;
+	bool has_spdif;
+	unsigned int pcm_capture_analog_channels;
+	unsigned int pcm_playback_analog_channels;
+	unsigned int midi_capture_ports;
+	unsigned int midi_playback_ports;
+	bool is_controller;
+};
+
 struct snd_tscm {
 	struct snd_card *card;
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+
+	const struct snd_tscm_spec *spec;
 };
 
 #endif
-- 
2.1.4
