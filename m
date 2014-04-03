From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix silent speaker output due to
	mute LED fixup
Date: Thu,  3 Apr 2014 11:57:57 +0200
Message-ID: <1396519077-4959-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B7552656A1
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 11:57:57 +0200 (CEST)
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
Cc: Hui Wang <hui.wang@canonical.com>
List-Id: alsa-devel@alsa-project.org

The recent fixups for HP laptops to support the mute LED made the
speaker output silent on some machines.  It turned out that they use
the NID 0x18 for the speaker while it's also used for controlling the
LED via VREF bits although the current driver code blindly assumes
that such a node is a mic pin (where 0x18 is usually so).

This patch fixes the problem by only changing the VREF bits and
keeping the other pin ctl bits.

Reported-and-tested-by: Hui Wang <hui.wang@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dba297288398..053107786f33 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3371,8 +3371,9 @@ static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 
 	if (spec->mute_led_polarity)
 		enabled = !enabled;
-	pinval = AC_PINCTL_IN_EN |
-		(enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80);
+	pinval = snd_hda_codec_get_pin_target(codec, spec->mute_led_nid);
+	pinval &= ~AC_PINCTL_VREFEN;
+	pinval |= enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80;
 	if (spec->mute_led_nid)
 		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
 }
-- 
1.9.1
