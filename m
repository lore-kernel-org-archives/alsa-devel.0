From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Remove unused call to "get_pin" in
	patch_hdmi.c
Date: Mon, 11 May 2015 10:23:57 +0200
Message-ID: <1431332637-8650-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 598E326067F
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 10:23:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Janitorial patch (no functional change)

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e8d8478..fd11ad7 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2049,9 +2049,7 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hda_pcm *info;
 		struct hda_pcm_stream *pstr;
-		struct hdmi_spec_per_pin *per_pin;
 
-		per_pin = get_pin(spec, pin_idx);
 		info = snd_hda_codec_pcm_new(codec, "HDMI %d", pin_idx);
 		if (!info)
 			return -ENOMEM;
-- 
1.9.1
