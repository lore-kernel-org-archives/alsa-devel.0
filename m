From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Set stream_pm ops automatically by
	generic parser
Date: Wed, 27 May 2015 08:40:15 +0200
Message-ID: <1432708815-21314-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 58D59265913
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 08:40:17 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1C804AC69
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 06:40:17 +0000 (UTC)
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

This allows user to test power_save_node feature via sysfs or patch
firmware even on the codecs that don't specify it.  It'll also save a
few lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c    | 5 ++++-
 sound/pci/hda/patch_realtek.c  | 1 -
 sound/pci/hda/patch_sigmatel.c | 1 -
 sound/pci/hda/patch_via.c      | 1 -
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 1c8678775f40..ac0db1679f09 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4926,9 +4926,12 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
  dig_only:
 	parse_digital(codec);
 
-	if (spec->power_down_unused || codec->power_save_node)
+	if (spec->power_down_unused || codec->power_save_node) {
 		if (!codec->power_filter)
 			codec->power_filter = snd_hda_gen_path_power_filter;
+		if (!codec->patch_ops.stream_pm)
+			codec->patch_ops.stream_pm = snd_hda_gen_stream_pm;
+	}
 
 	if (!spec->no_analog && spec->beep_nid) {
 		err = snd_hda_attach_beep_device(codec, spec->beep_nid);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fc0ccc78bdc7..e3bf72bb278c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5724,7 +5724,6 @@ static int patch_alc269(struct hda_codec *codec)
 		set_beep_amp(spec, spec->gen.mixer_nid, 0x04, HDA_INPUT);
 
 	codec->patch_ops = alc_patch_ops;
-	codec->patch_ops.stream_pm = snd_hda_gen_stream_pm;
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;
 	codec->patch_ops.resume = alc269_resume;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 43c99ce4a520..0de0fd95144a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4403,7 +4403,6 @@ static const struct hda_codec_ops stac_patch_ops = {
 #ifdef CONFIG_PM
 	.suspend = stac_suspend,
 #endif
-	.stream_pm = snd_hda_gen_stream_pm,
 	.reboot_notify = stac_shutup,
 };
 
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 31a95cca015d..742087ef378f 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -472,7 +472,6 @@ static const struct hda_codec_ops via_patch_ops = {
 	.init = via_init,
 	.free = via_free,
 	.unsol_event = snd_hda_jack_unsol_event,
-	.stream_pm = snd_hda_gen_stream_pm,
 #ifdef CONFIG_PM
 	.suspend = via_suspend,
 	.check_power_status = via_check_power_status,
-- 
2.4.1
