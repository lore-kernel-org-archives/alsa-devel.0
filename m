From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/18] ALSA: firewire-motu: add a structure for
	model-dependent parameters.
Date: Wed, 22 Mar 2017 21:30:13 +0900
Message-ID: <20170322123028.24148-4-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 480D52673BC
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:39 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

MOTU FireWire series doesn't tell drivers their capabilities, thus
the drivers should have and apply model-dependent parameters to detected
models.

This commit adds a structure to represent such parameters. Capabilities
are represented by enumeration except for the number of analog line
in/out. Identification name also be in the structure because the units has
no registers for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 10 +++++++---
 sound/firewire/motu/motu.h | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index bdd82dd..e69aa7b 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -31,9 +31,11 @@ static void name_card(struct snd_motu *motu)
 	}
 
 	strcpy(motu->card->driver, "FW-MOTU");
+	strcpy(motu->card->shortname, motu->spec->name);
+	strcpy(motu->card->mixername, motu->spec->name);
 	snprintf(motu->card->longname, sizeof(motu->card->longname),
-		 "MOTU (version:%d), GUID %08x%08x at %s, S%d",
-		 version,
+		 "MOTU %s (version:%d), GUID %08x%08x at %s, S%d",
+		 motu->spec->name, version,
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&motu->unit->device), 100 << fw_dev->max_speed);
 }
@@ -101,6 +103,7 @@ static int motu_probe(struct fw_unit *unit,
 	if (motu == NULL)
 		return -ENOMEM;
 
+	motu->spec = (const struct snd_motu_spec *)entry->driver_data;
 	motu->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, motu);
 
@@ -142,7 +145,7 @@ static void motu_bus_update(struct fw_unit *unit)
 		snd_fw_schedule_registration(unit, &motu->dwork);
 }
 
-#define SND_MOTU_DEV_ENTRY(model)			\
+#define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
 			  IEEE1394_MATCH_MODEL_ID |	\
@@ -150,6 +153,7 @@ static void motu_bus_update(struct fw_unit *unit)
 	.vendor_id	= OUI_MOTU,			\
 	.model_id	= model,			\
 	.specifier_id	= OUI_MOTU,			\
+	.driver_data	= (kernel_ulong_t)data,		\
 }
 
 static const struct ieee1394_device_id motu_id_table[] = {
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index eb0ffd5..cb7324d 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -29,6 +29,29 @@ struct snd_motu {
 
 	bool registered;
 	struct delayed_work dwork;
+
+	/* Model dependent information. */
+	const struct snd_motu_spec *spec;
+};
+
+enum snd_motu_spec_flags {
+	SND_MOTU_SPEC_SUPPORT_CLOCK_X2	= 0x0001,
+	SND_MOTU_SPEC_SUPPORT_CLOCK_X4	= 0x0002,
+	SND_MOTU_SPEC_TX_MICINST_CHUNK	= 0x0004,
+	SND_MOTU_SPEC_TX_RETURN_CHUNK	= 0x0008,
+	SND_MOTU_SPEC_TX_REVERB_CHUNK	= 0x0010,
+	SND_MOTU_SPEC_TX_AESEBU_CHUNK	= 0x0020,
+	SND_MOTU_SPEC_HAS_OPT_IFACE_A	= 0x0040,
+	SND_MOTU_SPEC_HAS_OPT_IFACE_B	= 0x0080,
+	SND_MOTU_SPEC_HAS_MIDI		= 0x0100,
+};
+
+struct snd_motu_spec {
+	const char *const name;
+	enum snd_motu_spec_flags flags;
+
+	unsigned char analog_in_ports;
+	unsigned char analog_out_ports;
 };
 
 #endif
-- 
2.9.3
