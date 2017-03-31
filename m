From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/14] ALSA: fireface: add model specific
	structure
Date: Fri, 31 Mar 2017 22:06:01 +0900
Message-ID: <20170331130612.18331-4-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 7B33E26691F
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:21 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
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
different. Currently, we find no way to retrieve the specifications
from actual devices and need to implement them in this driver.

This commit adds a structure to describe model specific data. This
structure has an identical name for each unit, and maximum number of
data channels in each mode. I'll describe about the mode in following
commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff.c |  9 +++++----
 sound/firewire/fireface/ff.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 7c02639..5c2bd92 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -17,13 +17,12 @@ MODULE_LICENSE("GPL v2");
 static void name_card(struct snd_ff *ff)
 {
 	struct fw_device *fw_dev = fw_parent_device(ff->unit);
-	const char *const model = "Fireface Skeleton";
 
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
@@ -86,6 +85,8 @@ static int snd_ff_probe(struct fw_unit *unit,
 
 	mutex_init(&ff->mutex);
 
+	ff->spec = (const struct snd_ff_spec *)entry->driver_data;
+
 	/* Register this sound card later. */
 	INIT_DEFERRABLE_WORK(&ff->dwork, do_registration);
 	snd_fw_schedule_registration(unit, &ff->dwork);
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index a0faae1..269fa25 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -22,6 +22,18 @@
 
 #include "../lib.h"
 
+#define SND_FF_STREAM_MODES		3
+
+struct snd_ff_spec {
+	const char *const name;
+
+	const unsigned int pcm_capture_channels[SND_FF_STREAM_MODES];
+	const unsigned int pcm_playback_channels[SND_FF_STREAM_MODES];
+
+	unsigned int midi_in_ports;
+	unsigned int midi_out_ports;
+};
+
 struct snd_ff {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -29,5 +41,7 @@ struct snd_ff {
 
 	bool registered;
 	struct delayed_work dwork;
+
+	const struct snd_ff_spec *spec;
 };
 #endif
-- 
2.9.3
