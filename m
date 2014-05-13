From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/15] oxfw: Add support for Behringer/Mackie devices
Date: Tue, 13 May 2014 23:27:49 +0900
Message-ID: <1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some devices produced by Behringer/Mackie are based on OXFW970/971. This
commit adds support for them. Additionally, this commit changes the way to
name card with some information in config rom.

The devices support capture/playback of PCM-samples and some of them
supports capture/playback of MIDI messages. These functionalities are
implemented by followed commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig     |  4 +++
 sound/firewire/oxfw/oxfw.c | 74 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 63f3cea..38027bd 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -35,6 +35,10 @@ config SND_OXFW
 	  Oxford Semiconductor OXFW970/971 chipset.
 	   * Griffin Firewave
 	   * LaCie Firewire Speakers
+	   * Behringer F-Control Audio 202
+	   * Mackie(Loud) Onyx-i series (former models)
+	   * Mackie(Loud) Onyx Satellite
+	   * Mackie(Loud) Tapco Link.Firewire
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 825377a..0c9b8e2 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -16,6 +16,8 @@
 
 #define VENDOR_GRIFFIN		0x001292
 #define VENDOR_LACIE		0x00d04b
+#define VEN_BEHRINGER		0x001564
+#define VEN_LOUD		0x000ff2
 
 #define SPECIFIER_1394TA	0x00a02d
 #define VERSION_AVC		0x010001
@@ -44,19 +46,40 @@ static const struct device_info lacie_speakers = {
 static int name_card(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
+	char vendor[24] = {0};
+	char model[32] = {0};
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
-	m = oxfw->device_info->driver_name;
+	/* to apply card definitions */
+	if (oxfw->device_info) {
+		d = oxfw->device_info->driver_name;
+		v = oxfw->device_info->vendor_name;
+		m = oxfw->device_info->driver_name;
+	} else {
+		d = "OXFW";
+		v = vendor;
+		m = model;
+	}
 
 	strcpy(oxfw->card->driver, d);
 	strcpy(oxfw->card->shortname, m);
@@ -109,16 +132,18 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = oxfw_create_mixer(oxfw);
-	if (err < 0)
-		goto error;
+	if (oxfw->device_info) {
+		err = snd_oxfw_create_mixer(oxfw);
+		if (err < 0)
+			goto error;
+	}
+
+	snd_oxfw_proc_init(oxfw);
 
 	err = snd_oxfw_stream_init_simplex(oxfw);
 	if (err < 0)
 		goto error;
 
-	snd_oxfw_proc_init(oxfw);
-
 	err = snd_card_register(card);
 	if (err < 0) {
 		snd_oxfw_stream_destroy_simplex(oxfw);
@@ -173,6 +198,39 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.version      = VERSION_AVC,
 		.driver_data  = (kernel_ulong_t)&lacie_speakers,
 	},
+	/* Behringer,F-Control Audio 202 */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= VEN_BEHRINGER,
+		.model_id	= 0x00fc22,
+	},
+	/* Mackie(Loud), Onyx-i series (former models) */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= VEN_LOUD,
+		.model_id	= 0x081216,
+	},
+	/* Mackie(Loud), Onyx Satellite */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= VEN_LOUD,
+		.model_id	= 0x00200f,
+	},
+	/*  Mackie(Loud), Tapco Link.Firewire */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= VEN_LOUD,
+		.model_id	= 0x000460,
+	},
+	/* IDs are unknown but able to be supported */
+	/*  Mackie(Loud), d.2 pro */
+	/*  Mackie(Loud), d.4 pro */
+	/*  Mackie(Loud), U.420 */
+	/*  Mackie(Loud), U.420d */
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
