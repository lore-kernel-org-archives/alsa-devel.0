From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] oxfw: Read firmware version to name card
Date: Sun,  5 Jan 2014 20:13:31 +0900
Message-ID: <1388920417-5584-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EA0C265175
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:13:51 +0100 (CET)
In-Reply-To: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

There is already an driver for OXFW970/971, snd-firewire-speakers(speakers.c).
But this new driver aims to support recording equipment.

It's convinient to apply the same way for card name.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 34be292..e90c53a 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -30,9 +30,56 @@ MODULE_PARM_DESC(enable, "enable OXFW970/971 sound card");
 static DEFINE_MUTEX(devices_mutex);
 static unsigned int devices_used;
 
+#define OXFW_FIRMWARE_ID_ADDRESS	(CSR_REGISTER_BASE + 0x50000)
+
+#define OXFW_HARDWARE_ID_ADDRESS	(CSR_REGISTER_BASE + 0x90020)
+#define OXFW_HARDWARE_ID_OXFW970	0x39443841
+#define OXFW_HARDWARE_ID_OXFW971	0x39373100
+
 #define	VEN_BEHRINGER	0x001564
 #define	VEN_LOUD	0x000ff2
 
+static int
+name_device(struct snd_oxfw *oxfw, unsigned int vendor_id)
+{
+	char vendor[24] = {0};
+	char model[24] = {0};
+	u32 version = 0;
+	int err;
+
+	/* get vendor name from root directory */
+	err = fw_csr_string(oxfw->device->config_rom + 5, CSR_VENDOR,
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
+	/* 0x970?vvvv or 0x971?vvvv, where vvvv = firmware version */
+	err = snd_fw_transaction(oxfw->unit, TCODE_READ_QUADLET_REQUEST,
+				 OXFW_FIRMWARE_ID_ADDRESS,
+				 &version, sizeof(u32), 0);
+	if (err < 0)
+		goto end;
+	be32_to_cpus(&version);
+
+	strcpy(oxfw->card->driver, "OXFW");
+	strcpy(oxfw->card->shortname, model);
+	snprintf(oxfw->card->longname, sizeof(oxfw->card->longname),
+		 "%s %s (%x %04x), GUID %08x%08x at %s, S%d",
+		 vendor, model, version >> 20, version & 0xffff,
+		 oxfw->device->config_rom[3], oxfw->device->config_rom[4],
+		 dev_name(&oxfw->unit->device),
+		 100 << oxfw->device->max_speed);
+	strcpy(oxfw->card->mixername, oxfw->card->driver);
+end:
+	return err;
+}
+
 static void
 oxfw_card_free(struct snd_card *card)
 {
@@ -83,6 +130,10 @@ oxfw_probe(struct fw_unit *unit,
 	mutex_init(&oxfw->mutex);
 	spin_lock_init(&oxfw->lock);
 
+	err = name_device(oxfw, entry->vendor_id);
+	if (err < 0)
+		goto error;
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 3aee9e7..e75eb70 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -21,6 +21,8 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 
+#include "../lib.h"
+
 struct snd_oxfw {
 	struct snd_card *card;
 	struct fw_device *device;
-- 
1.8.3.2
