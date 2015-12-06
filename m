From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/17] ALSA: oxfw: allocate own address region
	for SCS.1 series
Date: Sun,  6 Dec 2015 13:18:19 +0900
Message-ID: <1449375505-2704-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AAF0F2651A3
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

When physical controls on SCS.1 models are operated, the models transfer
MIDI messages in asynchronous transactions on IEEE 1394 bus. The models
have a register to have an address for the transactions, and drivers
can register own address for this purpose.

This commit keeps a region of address, registers it and adds a handler for
the transactions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 69 +++++++++++++++++++++++++++++++++++++++-
 sound/firewire/oxfw/oxfw.h       |  1 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 34db0d0..4a2a7ff 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -9,18 +9,85 @@
 
 #include "oxfw.h"
 
+#define HSS1394_ADDRESS			0xc007dedadadaULL
+#define HSS1394_MAX_PACKET_SIZE		64
+#define HSS1394_TAG_CHANGE_ADDRESS	0xf1
+
+struct fw_scs1x {
+	struct fw_address_handler hss_handler;
+};
+
+static void handle_hss(struct fw_card *card, struct fw_request *request,
+		       int tcode, int destination, int source, int generation,
+		       unsigned long long offset, void *data, size_t length,
+		       void *callback_data)
+{
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+static int register_address(struct snd_oxfw *oxfw)
+{
+	struct fw_scs1x *scs = oxfw->spec;
+	__be64 data;
+
+	data = cpu_to_be64(((u64)HSS1394_TAG_CHANGE_ADDRESS << 56) |
+			    scs->hss_handler.offset);
+	return snd_fw_transaction(oxfw->unit, TCODE_WRITE_BLOCK_REQUEST,
+				  HSS1394_ADDRESS, &data, sizeof(data), 0);
+}
+
+static void remove_scs1x(struct snd_rawmidi *rmidi)
+{
+	struct fw_scs1x *scs = rmidi->private_data;
+
+	fw_core_remove_address_handler(&scs->hss_handler);
+	scs->hss_handler.length = 0;
+}
+
+void snd_oxfw_scs1x_update(struct snd_oxfw *oxfw)
+{
+	struct fw_scs1x *scs = oxfw->spec;
+
+	if (scs->hss_handler.length > 0)
+		register_address(oxfw);
+}
+
 int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 {
 	struct snd_rawmidi *rmidi;
+	struct fw_scs1x *scs;
 	int err;
 
+	scs = kzalloc(sizeof(struct fw_scs1x), GFP_KERNEL);
+	if (scs == NULL)
+		return -ENOMEM;
+	oxfw->spec = scs;
+
+	/* Allocate own handler for imcoming asynchronous transaction. */
+	scs->hss_handler.length = HSS1394_MAX_PACKET_SIZE;
+	scs->hss_handler.address_callback = handle_hss;
+	scs->hss_handler.callback_data = scs;
+	err = fw_core_add_address_handler(&scs->hss_handler,
+					  &fw_high_memory_region);
+	if (err < 0)
+		return err;
+
+	err = register_address(oxfw);
+	if (err < 0)
+		goto err_allocated;
+
 	/* Use unique name for backward compatibility to scs1x module. */
 	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 0, &rmidi);
 	if (err < 0)
-		return err;
+		goto err_allocated;
+	rmidi->private_data = scs;
+	rmidi->private_free = remove_scs1x;
 
 	snprintf(rmidi->name, sizeof(rmidi->name),
 		 "%s MIDI", oxfw->card->shortname);
 
+	return 0;
+err_allocated:
+	fw_core_remove_address_handler(&scs->hss_handler);
 	return err;
 }
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index cbf00ee..9beecc2 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -135,3 +135,4 @@ int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw);
 
 int snd_oxfw_add_spkr(struct snd_oxfw *oxfw, bool is_lacie);
 int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw);
+void snd_oxfw_scs1x_update(struct snd_oxfw *oxfw);
-- 
2.5.0
