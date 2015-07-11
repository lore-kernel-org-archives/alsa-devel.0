From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 30/37] ALSA: firewire-motu: add a
	structure for model-dependent parameters.
Date: Sat, 11 Jul 2015 23:12:41 +0900
Message-ID: <1436623968-10780-31-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 263F22605CE
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:07 +0200 (CEST)
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

MOTU FireWire series doesn't tell drivers their capabilities, thus
the drivers should have model-dependent parameters and apply it to
detected models.

This commit adds a structure to represent such parameters.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 169 ++++++++++++++++++++++++++++++++++++++++++---
 sound/firewire/motu/motu.h |  16 +++++
 2 files changed, 176 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 929899dd..eb83e87 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -28,9 +28,11 @@ static void name_card(struct snd_motu *motu)
 	}
 
 	strcpy(motu->card->driver, "MOTU");
+	strcpy(motu->card->shortname, motu->spec->name);
+	strcpy(motu->card->mixername, motu->spec->name);
 	snprintf(motu->card->longname, sizeof(motu->card->longname),
-		 "MOTU (version:%d), GUID %08x%08x at %s, S%d",
-		 be32_to_cpu(version),
+		 "MOTU %s (version:%d), GUID %08x%08x at %s, S%d",
+		 motu->spec->name, be32_to_cpu(version),
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&motu->unit->device), 100 << fw_dev->max_speed);
 }
@@ -89,14 +91,163 @@ static void motu_bus_reset(struct fw_unit *unit)
 	return;
 }
 
+static struct snd_motu_spec motu_828mk2 = {
+	.name = "828Mk2",
+	.generation = 2,
+
+	.tx_common_pcm_channels = {14, 14, 0},
+	.tx_optical_ifaces = 1,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14, 14, 0},
+	.rx_optical_ifaces = 1,
+	.rx_midi_ports = 1,
+};
+
+static struct snd_motu_spec motu_8pre = {
+	.name = "8PRE",
+	.generation = 2,
+
+	.tx_common_pcm_channels = {10 , 10, 0},
+	.tx_optical_ifaces = 1,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {6 , 6, 0},
+	.rx_optical_ifaces = 1,
+	.rx_midi_ports = 1
+};
+
+static struct snd_motu_spec motu_traveler = {
+	.name = "Traveler",
+	.generation = 2,
+
+	.tx_common_pcm_channels = {14, 14, 8},
+	.tx_optical_ifaces = 1,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14, 14, 8},
+	.rx_optical_ifaces = 1,
+	.rx_midi_ports = 1,
+};
+
+static struct snd_motu_spec motu_ultralite = {
+	.name = "UltraLite",
+	.generation = 2,
+
+	.tx_common_pcm_channels = {12, 12, 0},
+	.tx_optical_ifaces = 0,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14, 14, 0},
+	.rx_optical_ifaces = 0,
+	.rx_midi_ports = 1,
+};
+
+static struct snd_motu_spec motu_896hd = {
+	.name = "896HD",
+	.generation = 2,
+
+	.tx_common_pcm_channels = {12, 12, 8},
+	.tx_optical_ifaces = 1,
+	.tx_midi_ports = 0,
+
+	.rx_common_pcm_channels = {12, 12, 8},
+	.rx_optical_ifaces = 1,
+	.rx_midi_ports = 0,
+};
+
+static struct snd_motu_spec motu_4pre = {
+	.name = "4pre",
+	.generation = 3,
+
+	.tx_common_pcm_channels = {8, 8, 6},
+	.tx_optical_ifaces = 0,
+	.tx_midi_ports = 0,
+
+	.rx_common_pcm_channels = {8, 8, 6},
+	.rx_optical_ifaces = 0,
+	.rx_midi_ports = 0,
+};
+
+static struct snd_motu_spec motu_828mk3 = {
+	.name = "828Mk3",
+	.generation = 3,
+
+	.tx_common_pcm_channels = {18, 18, 12},
+	.tx_optical_ifaces = 2,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14, 14, 12},
+	.rx_optical_ifaces = 2,
+	.rx_midi_ports = 1,
+};
+
+static struct snd_motu_spec motu_travelermk3 = {
+	.name = "TravelerMk3",
+	.generation = 3,
+
+	.tx_common_pcm_channels = {18 , 16, 10},
+	.tx_optical_ifaces = 2,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14 , 14, 10},
+	.rx_optical_ifaces = 2,
+	.rx_midi_ports = 1,
+};
+
+static struct snd_motu_spec motu_896mk3 = {
+	.name = "896Mk3",
+	.generation = 3,
+
+	.tx_common_pcm_channels = {18, 14, 10},
+	.tx_optical_ifaces = 2,
+	.tx_midi_ports = 0,
+
+	.rx_common_pcm_channels = {18, 14, 10},
+	.rx_optical_ifaces = 2,
+	.rx_midi_ports = 0,
+};
+
+static struct snd_motu_spec motu_ultralitemk3 = {
+	.name = "UltraLiteMk3",
+	.generation = 3,
+
+	.tx_common_pcm_channels = {18, 14, 10},
+	.tx_optical_ifaces = 2,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14, 14, 14},
+	.rx_optical_ifaces = 2,
+	.rx_midi_ports = 1,
+};
+
+static struct snd_motu_spec motu_ultralitemk3hybrid = {
+	.name = "UltraLiteMk3Hybrid",
+	.generation = 3,
+
+	.tx_common_pcm_channels = {18, 14, 10},
+	.tx_optical_ifaces = 0,
+	.tx_midi_ports = 1,
+
+	.rx_common_pcm_channels = {14, 14, 12},
+	.rx_optical_ifaces = 0,
+	.rx_midi_ports = 1,
+};
+
+#define SND_MOTU_DEV_ENTRY(model, data)			\
+{							\
+	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
+			  IEEE1394_MATCH_MODEL_ID |	\
+			  IEEE1394_MATCH_SPECIFIER_ID,	\
+	.vendor_id	= 0x0001f2,			\
+	.model_id	= model,			\
+	.specifier_id	= 0x0001f2,			\
+	.driver_data	= (kernel_ulong_t)data,		\
+}
+
 static const struct ieee1394_device_id motu_id_table[] = {
-	{
-		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_MODEL_ID |
-				  IEEE1394_MATCH_SPECIFIER_ID,
-		.vendor_id	= 0x0001f2,
-		.specifier_id	= 0x0001f2,
-	},
+	/* 828 mk2 */
+	SND_MOTU_DEV_ENTRY(0x101800, &motu_828mk2),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index df16750..d5dddbd 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -24,11 +24,27 @@
 #include "../iso-resources.h"
 #include "../lib.h"
 
+struct snd_motu_spec {
+	const char *const name;
+	unsigned char generation;
+
+	unsigned int tx_common_pcm_channels[3];
+	unsigned int tx_optical_ifaces;
+	unsigned int tx_midi_ports;
+
+	unsigned int rx_common_pcm_channels[3];
+	unsigned int rx_optical_ifaces;
+	unsigned int rx_midi_ports;
+};
+
 struct snd_motu {
 	struct snd_card *card;
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+
+	/* Model dependent information. */
+	struct snd_motu_spec *spec;
 };
 
 #endif
-- 
2.1.4
