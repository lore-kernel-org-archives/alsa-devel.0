From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix wrong gpio_dir & gpio_mask
	hint setups for IDT/STAC codecs
Date: Mon,  5 Jan 2015 14:23:56 +0100
Message-ID: <1420464236-2625-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BCBCA260606
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 14:24:03 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9A2B7AAC9
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 13:24:01 +0000 (UTC)
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

stac_store_hints() does utterly wrong for masking the values for
gpio_dir and gpio_data, likely due to copy&paste errors.  Fortunately,
this feature is used very rarely, so the impact must be really small.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 4f6413e01c13..605d14003d25 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -568,9 +568,9 @@ static void stac_store_hints(struct hda_codec *codec)
 			spec->gpio_mask;
 	}
 	if (get_int_hint(codec, "gpio_dir", &spec->gpio_dir))
-		spec->gpio_mask &= spec->gpio_mask;
-	if (get_int_hint(codec, "gpio_data", &spec->gpio_data))
 		spec->gpio_dir &= spec->gpio_mask;
+	if (get_int_hint(codec, "gpio_data", &spec->gpio_data))
+		spec->gpio_data &= spec->gpio_mask;
 	if (get_int_hint(codec, "eapd_mask", &spec->eapd_mask))
 		spec->eapd_mask &= spec->gpio_mask;
 	if (get_int_hint(codec, "gpio_mute", &spec->gpio_mute))
-- 
2.2.1
