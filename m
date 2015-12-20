From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/11] fireface: add model specific structure
Date: Sun, 20 Dec 2015 21:28:35 +0900
Message-ID: <1450614523-9367-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 8735F2606D1
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:48 +0100 (CET)
In-Reply-To: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
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

RME Fireface series has several models and their specifications are
different. Currently, we find no way to retrieve the specification
from actual devices.

This commit adds a structure to describe model specific data.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/fireface.c | 13 +++++++++----
 sound/firewire/fireface/fireface.h |  6 ++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
index cf10e97..f96913b 100644
--- a/sound/firewire/fireface/fireface.c
+++ b/sound/firewire/fireface/fireface.c
@@ -16,16 +16,19 @@ MODULE_DESCRIPTION("RME Fireface series Driver");
 MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
 MODULE_LICENSE("GPL v2");
 
+struct snd_ff_spec spec_ff400 = {
+	.name = "Fireface400",
+};
+
 static void name_card(struct snd_ff *ff)
 {
 	struct fw_device *fw_dev = fw_parent_device(ff->unit);
-	const char *const model = "Fireface 400";
 
 	strcpy(ff->card->driver, "Fireface");
-	strcpy(ff->card->shortname, model);
-	strcpy(ff->card->mixername, model);
+	strcpy(ff->card->shortname, ff->spec->name);
+	strcpy(ff->card->mixername, ff->spec->name);
 	snprintf(ff->card->longname, sizeof(ff->card->longname),
-		 "RME %s, GUID %08x%08x at %s, S%d", model,
+		 "RME %s, GUID %08x%08x at %s, S%d", ff->spec->name,
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&ff->unit->device), 100 << fw_dev->max_speed);
 }
@@ -91,6 +94,7 @@ static int snd_ff_probe(struct fw_unit *unit,
 	mutex_init(&ff->mutex);
 	dev_set_drvdata(&unit->device, ff);
 
+	ff->spec = (const struct snd_ff_spec *)entry->driver_data;
 	name_card(ff);
 
 	/* Register this sound card later. */
@@ -140,6 +144,7 @@ static const struct ieee1394_device_id snd_ff_id_table[] = {
 		.specifier_id	= 0x000a35,
 		.version	= 0x000002,
 		.model_id	= 0x101800,
+		.driver_data	= (kernel_ulong_t)&spec_ff400,
 	},
 	{}
 };
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index 74877ef..91e924c 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -31,6 +31,10 @@
 #include "../amdtp-stream.h"
 #include "../iso-resources.h"
 
+struct snd_ff_spec {
+	const char *const name;
+};
+
 struct snd_ff {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -38,5 +42,7 @@ struct snd_ff {
 
 	bool probed;
 	struct delayed_work dwork;
+
+	const struct snd_ff_spec *spec;
 };
 #endif
-- 
2.5.0
