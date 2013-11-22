From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Set current_headset_type to
	ALC_HEADSET_TYPE_ENUM (janitorial)
Date: Fri, 22 Nov 2013 12:17:06 +0100
Message-ID: <1385119027-26232-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FDDF261619
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 12:17:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

current_headset_type should be of the HEADSET_TYPE enum, not the
HEADSET_MODE enum. Since ALC_HEADSET_TYPE_UNKNOWN and ALC_HEADSET_MODE_UNKNOWN
are both 0, this patch is just janitorial.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d8d9b3..5e42059 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3414,7 +3414,7 @@ static void alc_update_headset_mode_hook(struct hda_codec *codec,
 static void alc_update_headset_jack_cb(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct alc_spec *spec = codec->spec;
-	spec->current_headset_type = ALC_HEADSET_MODE_UNKNOWN;
+	spec->current_headset_type = ALC_HEADSET_TYPE_UNKNOWN;
 	snd_hda_gen_hp_automute(codec, jack);
 }
 
-- 
1.7.9.5
