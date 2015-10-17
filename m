From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hda - Fix bogus codec address check
	for mixer name assignment
Date: Sat, 17 Oct 2015 18:35:11 +0200
Message-ID: <1445099711-17600-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F281260483
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 18:35:17 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DD3A8AAD1
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 16:35:15 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The recent commit [7fbe824a0f0e: ALSA: hda - Update mixer name for the
lower codec address] tried to improve the mixer chip name assignment
in the order of codec address.  However, this fix was utterly bogus;
it checks the field set in each codec, thus this value is reset at
each codec creation, of course.  For really handling this priority,
the assignment has to be remembered in the common place, namely in
hda_bus, instead of hda_codec.

Fixes: 7fbe824a0f0e ('ALSA: hda - Update mixer name for the lower codec address')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c       | 4 ++--
 sound/pci/hda/hda_codec.c      | 1 -
 sound/pci/hda/hda_codec.h      | 2 +-
 sound/pci/hda/hda_controller.c | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 152acdaa0a45..70671ad65d24 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -63,11 +63,11 @@ int snd_hda_codec_set_name(struct hda_codec *codec, const char *name)
 
 	/* update the mixer name */
 	if (!*codec->card->mixername ||
-	    codec->mixer_assigned >= codec->core.addr) {
+	    codec->bus->mixer_assigned >= codec->core.addr) {
 		snprintf(codec->card->mixername,
 			 sizeof(codec->card->mixername), "%s %s",
 			 codec->core.vendor_name, codec->core.chip_name);
-		codec->mixer_assigned = codec->core.addr;
+		codec->bus->mixer_assigned = codec->core.addr;
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0e55c6a6cc7e..2eeaf5ea20f9 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -851,7 +851,6 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	INIT_DELAYED_WORK(&codec->jackpoll_work, hda_jackpoll_work);
 	codec->depop_delay = -1;
 	codec->fixup_id = HDA_FIXUP_ID_NOT_SET;
-	codec->mixer_assigned = -1;
 
 #ifdef CONFIG_PM
 	codec->power_jiffies = jiffies;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 055a80522282..5bcfe7407d83 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -70,6 +70,7 @@ struct hda_bus {
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
+	unsigned int mixer_assigned;	/* codec addr for mixer name */
 };
 
 /* from hdac_bus to hda_bus */
@@ -260,7 +261,6 @@ struct hda_codec {
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
 #endif
-	unsigned int mixer_assigned;
 
 	/* filter the requested power state per nid */
 	unsigned int (*power_filter)(struct hda_codec *codec, hda_nid_t nid,
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 944455997fdc..d6b93a20361b 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1045,6 +1045,7 @@ int azx_bus_init(struct azx *chip, const char *model,
 	mutex_init(&bus->prepare_mutex);
 	bus->pci = chip->pci;
 	bus->modelname = model;
+	bus->mixer_assigned = -1;
 	bus->core.snoop = azx_snoop(chip);
 	if (chip->get_position[0] != azx_get_pos_lpib ||
 	    chip->get_position[1] != azx_get_pos_lpib)
-- 
2.6.0
