From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 18/37] ALSA: firewire-tascam: add a
	structure for model-dependent parameters.
Date: Sat, 11 Jul 2015 23:12:29 +0900
Message-ID: <1436623968-10780-19-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DB70026059C
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:05 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

TASCAM FireWire series doesn't tell drivers their capabilities, thus
the drivers should have model-dependent parameters and apply it to
detected models.

This commit adds a structure to represent such parameters.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.h | 13 +++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 9f2d2a3..73205077 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -12,12 +12,46 @@ MODULE_DESCRIPTION("TASCAM FireWire series Driver");
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
+		.midi_capture_ports = 5,
+		.midi_playback_ports = 5,
+		.is_controller = true,
+	},
+};
+
 static int check_name(struct snd_tscm *tscm)
 {
 	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
 	char vendor[8];
 	char model[8];
 	__u32 data;
+	unsigned int i;
 
 	/* Retrieve model name. */
 	data = be32_to_cpu(fw_dev->config_rom[28]);
@@ -26,6 +60,16 @@ static int check_name(struct snd_tscm *tscm)
 	memcpy(model + 4, &data, 4);
 	model[7] = '\0';
 
+	/* Check the name and set spec. */
+	for (i = 0; i < ARRAY_SIZE(model_specs); i++) {
+		if (strcmp(model, model_specs[i].name) == 0) {
+			tscm->spec = &model_specs[i];
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(model_specs))
+		return -ENODEV;
+
 	/* Retrieve vendor name. */
 	data = be32_to_cpu(fw_dev->config_rom[23]);
 	memcpy(vendor, &data, 4);
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 8aa5852..dfe08be 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -21,9 +21,22 @@
 
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
+	struct snd_tscm_spec *spec;
 };
-- 
2.1.4
