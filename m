From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 2/2] ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs
Date: Sat, 28 Jul 2018 03:16:42 +0900
Message-ID: <20180727181642.7405-1-qkrwngud825@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.com, alsa-devel@alsa-project.org
Cc: Park Ju Hyung <qkrwngud825@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On rare occasions, we are still noticing that the internal speaker
spitting out spurious noises even after adding the problematic codec
to the list.

Adding a 10ms artificial delay before rebooting fixes the issue entirely.

Patch for Realtek codecs also adds the same amount of delay after
entering D3.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 909a880f5e01..1a8a2d440fbd 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -226,6 +226,7 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 	snd_hda_codec_set_power_to_all(codec, codec->core.afg, AC_PWRST_D3);
 	snd_hda_codec_write(codec, codec->core.afg, 0,
 			    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	msleep(10);
 }
 
 static void cx_auto_free(struct hda_codec *codec)
-- 
2.18.0
