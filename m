From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Refresh sysfs at
	snd_hda_codec_update_widgets()
Date: Tue, 25 Aug 2015 08:56:20 +0200
Message-ID: <1440485780-3687-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C960426007E
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 08:56:27 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8FE02AC44
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 06:56:27 +0000 (UTC)
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

In the commit [fa4f18b4f402: ALSA: hda - Refresh widgets sysfs at
probing Haswell+ HDMI codecs], snd_hdac_refresh_widget_sysfs() is
explicitly called in the codec driver.  But this results in refreshing
twice, as snd_hdac_refresh_widget_sysfs() itself calls
snd_hdac_refresh_widgets() function.

Instead, we can replace the call in snd_hda_codec_update_widgets()
with snd_hdac_refresh_widget_sysfs().  This also fixes the missing
sysfs update for ca0132, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c  | 2 +-
 sound/pci/hda/patch_hdmi.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 792948418cf0..2c021911f88a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -955,7 +955,7 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 	hda_nid_t fg;
 	int err;
 
-	err = snd_hdac_refresh_widgets(&codec->core);
+	err = snd_hdac_refresh_widget_sysfs(&codec->core);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index df982fc6a872..a97db5fc8a15 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2331,7 +2331,6 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	if (is_haswell_plus(codec)) {
 		intel_haswell_enable_all_pins(codec, true);
 		intel_haswell_fixup_enable_dp12(codec);
-		snd_hdac_refresh_widget_sysfs(&codec->core);
 	}
 
 	/* For Valleyview/Cherryview, only the display codec is in the display
-- 
2.5.0
