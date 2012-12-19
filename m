From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Revert "ALSA: hda - Shut up pins at
	power-saving mode with Conexnat codecs"
Date: Wed, 19 Dec 2012 09:44:47 +0100
Message-ID: <1355906687-2881-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 555BD261716
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 09:44:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, 886975@bugs.launchpad.net, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This reverts commit 697c373e34613609cb5450f98b91fefb6e910588.

The original patch was meant to remove clicking, but in fact caused even
more clicking instead.

Thanks to c4pp4 for doing most of the work with this bug.

BugLink: https://bugs.launchpad.net/bugs/886975
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

@c4pp4: Is this consistent with what you have done to reduce the clicking?
Will you recommend upstream Linux to take the patch below?

 sound/pci/hda/patch_conexant.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 60890bf..dd798c3 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -558,24 +558,12 @@ static int conexant_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int conexant_suspend(struct hda_codec *codec)
-{
-	snd_hda_shutup_pins(codec);
-	return 0;
-}
-#endif
-
 static const struct hda_codec_ops conexant_patch_ops = {
 	.build_controls = conexant_build_controls,
 	.build_pcms = conexant_build_pcms,
 	.init = conexant_init,
 	.free = conexant_free,
 	.set_power_state = conexant_set_power,
-#ifdef CONFIG_PM
-	.suspend = conexant_suspend,
-#endif
-	.reboot_notify = snd_hda_shutup_pins,
 };
 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
@@ -4405,10 +4393,6 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.init = cx_auto_init,
 	.free = conexant_free,
 	.unsol_event = snd_hda_jack_unsol_event,
-#ifdef CONFIG_PM
-	.suspend = conexant_suspend,
-#endif
-	.reboot_notify = snd_hda_shutup_pins,
 };
 
 /*
-- 
1.7.9.5
