From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix incorrect usage of
	IS_REACHABLE()
Date: Fri, 27 Apr 2018 17:20:36 +0200
Message-ID: <20180427152036.21265-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CC926728A
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 17:20:39 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D6B95AE0F
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 15:20:38 +0000 (UTC)
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

The commit c469652bb5e8 ("ALSA: hda - Use IS_REACHABLE() for
dependency on input") simplified the dependencies with IS_REACHABLE()
macro, but it broke due to its incorrect usage: it should have been
IS_REACHABLE(CONFIG_INPUT) instead of IS_REACHABLE(INPUT).

Fixes: c469652bb5e8 ("ALSA: hda - Use IS_REACHABLE() for dependency on input")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c238e51bb5a..2dd34dd77447 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3832,7 +3832,7 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
 	}
 }
 
-#if IS_REACHABLE(INPUT)
+#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
-- 
2.16.3
