From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/15] ALSA: oxfw: Add support for
	Behringer/Mackie devices
Date: Sun,  7 Dec 2014 22:19:04 +0900
Message-ID: <1417958348-30333-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id CFC26260689
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 14:19:16 +0100 (CET)
In-Reply-To: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some devices produced by Behringer/Mackie are based on OXFW970/971. This
commit adds support for them. Additionally, this commit changes the way to
name card with some information in config rom.

Ids of some Mackie(Loud) models are not identified, therefore this commit
applies name detection for these models.

The devices support capture/playback of PCM-samples and some of them
supports capture/playback of MIDI messages. These functionalities are
implemented by followed commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig     |  6 +++
 sound/firewire/oxfw/oxfw.c | 91 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 0932860..6364e5b 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -31,6 +31,12 @@ config SND_OXFW
 	  Oxford Semiconductor FW970/971 chipset.
 	   * Griffin Firewave
 	   * LaCie Firewire Speakers
+	   * Behringer F-Control Audio 202
+	   * Mackie(Loud) Onyx-i series (former models)
+	   * Mackie(Loud) Onyx Satellite
+	   * Mackie(Loud) Tapco Link.Firewire
+	   * Mackie(Loud) d.2 pro/d.4 pro
+	   * Mackie(Loud) U.420/U.420d
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 4256398..26ce615 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -14,7 +14,9 @@
 #define OXFORD_HARDWARE_ID_OXFW970	0x39443841
 #define OXFORD_HARDWARE_ID_OXFW971	0x39373100
 
+#define VENDOR_LOUD		0x000ff2
 #define VENDOR_GRIFFIN		0x001292
+#define VENDOR_BEHRINGER	0x001564
 #define VENDOR_LACIE		0x00d04b
 
 #define SPECIFIER_1394TA	0x00a02d
@@ -25,22 +27,69 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
+static bool detect_loud_models(struct fw_unit *unit)
+{
+	const char *const models[] = {
+		"Onyxi",
+		"Onyx-i",
+		"d.Pro",
+		"Mackie Onyx Satellite",
+		"Tapco LINK.firewire 4x6",
+		"U.420"};
+	char model[32];
+	unsigned int i;
+	int err;
+
+	err = fw_csr_string(unit->directory, CSR_MODEL,
+			    model, sizeof(model));
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(models); i++) {
+		if (strcmp(models[i], model) == 0)
+			break;
+	}
+
+	return (i < ARRAY_SIZE(models));
+}
+
 static int name_card(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
+	char vendor[24];
+	char model[32];
 	const char *d, *v, *m;
 	u32 firmware;
 	int err;
 
+	/* get vendor name from root directory */
+	err = fw_csr_string(fw_dev->config_rom + 5, CSR_VENDOR,
+			    vendor, sizeof(vendor));
+	if (err < 0)
+		goto end;
+
+	/* get model name from unit directory */
+	err = fw_csr_string(oxfw->unit->directory, CSR_MODEL,
+			    model, sizeof(model));
+	if (err < 0)
+		goto end;
+
 	err = snd_fw_transaction(oxfw->unit, TCODE_READ_QUADLET_REQUEST,
 				 OXFORD_FIRMWARE_ID_ADDRESS, &firmware, 4, 0);
 	if (err < 0)
 		goto end;
 	be32_to_cpus(&firmware);
 
-	d = oxfw->device_info->driver_name;
-	v = oxfw->device_info->vendor_name;
-	m = oxfw->device_info->model_name;
+	/* to apply card definitions */
+	if (oxfw->device_info) {
+		d = oxfw->device_info->driver_name;
+		v = oxfw->device_info->vendor_name;
+		m = oxfw->device_info->model_name;
+	} else {
+		d = "OXFW";
+		v = vendor;
+		m = model;
+	}
 
 	strcpy(oxfw->card->driver, d);
 	strcpy(oxfw->card->mixername, m);
@@ -75,6 +124,9 @@ static int oxfw_probe(struct fw_unit *unit,
 	struct snd_oxfw *oxfw;
 	int err;
 
+	if ((id->vendor_id == VENDOR_LOUD) && !detect_loud_models(unit))
+		return -ENODEV;
+
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
 			   sizeof(*oxfw), &card);
 	if (err < 0)
@@ -99,9 +151,11 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_oxfw_create_mixer(oxfw);
-	if (err < 0)
-		goto error;
+	if (oxfw->device_info) {
+		err = snd_oxfw_create_mixer(oxfw);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_oxfw_proc_init(oxfw);
 
@@ -185,6 +239,31 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.version      = VERSION_AVC,
 		.driver_data  = (kernel_ulong_t)&lacie_speakers,
 	},
+	/* Behringer,F-Control Audio 202 */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= VENDOR_BEHRINGER,
+		.model_id	= 0x00fc22,
+	},
+	/*
+	 * Any Mackie(Loud) models (name string/model id):
+	 *  Onyx-i series (former models):	0x081216
+	 *  Mackie Onyx Satellite:		0x00200f
+	 *  Tapco LINK.firewire 4x6:		0x000460
+	 *  d.2 pro:				Unknown
+	 *  d.4 pro:				Unknown
+	 *  U.420:				Unknown
+	 *  U.420d:				Unknown
+	 */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_SPECIFIER_ID |
+				  IEEE1394_MATCH_VERSION,
+		.vendor_id	= VENDOR_LOUD,
+		.specifier_id	= SPECIFIER_1394TA,
+		.version	= VERSION_AVC,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
2.1.0
