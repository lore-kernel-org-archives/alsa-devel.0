From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Update mixer name for the
	lower codec address
Date: Thu, 15 Oct 2015 14:14:16 +0200
Message-ID: <1444911256-23738-2-git-send-email-tiwai@suse.de>
References: <1444911256-23738-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 028BC26046B
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 14:14:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A6737AAD1
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 12:14:18 +0000 (UTC)
In-Reply-To: <1444911256-23738-1-git-send-email-tiwai@suse.de>
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

In most cases, we prefer the onboard codec as the primary device, thus
it's better to set it as the mixer name.  Currently, however, the
mixer name is updated per the device instantiation order, and user
gets often HDMI/DP or other seen as a mixer chip name.  Also, if a
codec name is renamed by the driver, the old chip name might be left
still as the mixer name.

This patch addresses these issues by remembering the chip address that
was referred as the mixer name.  When a codec with the same or lower
address gives its name, renew the mixer name accordingly, as it's
either the update of the codec name or we get likely the more
appropriate chip as the reference.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c  | 4 +++-
 sound/pci/hda/hda_codec.c | 1 +
 sound/pci/hda/hda_codec.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index ef6b8f836a87..021bcce59447 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -61,10 +61,12 @@ int snd_hda_codec_set_name(struct hda_codec *codec, const char *name)
 		return err;
 
 	/* update the mixer name */
-	if (!*codec->card->mixername) {
+	if (!*codec->card->mixername ||
+	    codec->mixer_assigned >= codec->core.addr) {
 		snprintf(codec->card->mixername,
 			 sizeof(codec->card->mixername), "%s %s",
 			 codec->core.vendor_name, codec->core.chip_name);
+		codec->mixer_assigned = codec->core.addr;
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2eeaf5ea20f9..0e55c6a6cc7e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -851,6 +851,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	INIT_DELAYED_WORK(&codec->jackpoll_work, hda_jackpoll_work);
 	codec->depop_delay = -1;
 	codec->fixup_id = HDA_FIXUP_ID_NOT_SET;
+	codec->mixer_assigned = -1;
 
 #ifdef CONFIG_PM
 	codec->power_jiffies = jiffies;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index b6d937784afa..891864ac60f5 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -257,6 +257,7 @@ struct hda_codec {
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
 #endif
+	unsigned int mixer_assigned;
 
 	/* filter the requested power state per nid */
 	unsigned int (*power_filter)(struct hda_codec *codec, hda_nid_t nid,
-- 
2.6.1
