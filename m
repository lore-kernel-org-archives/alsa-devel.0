From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/sigmatel - Allow auto-switching for
	dock line-in of HP laptops
Date: Thu, 27 Feb 2014 16:51:04 +0100
Message-ID: <1393516264-30257-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B9423261B20
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 16:51:04 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 582AE7501A
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 15:51:04 +0000 (UTC)
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

Many HP laptops with STAC codecs have a docking station port and BIOS
sets the pins for the input on the dock as a line in.  Because the
generic parser doesn't handle a line in pin as auto-switchable, this
resulted in the manual capture source selection on these laptops.

However, from the usability POV, the automatic switching is easier.
This patch adds the line_in_auto_switch hint in the fixup function for
these laptops.  Even if no dock port is present, this should be
harmless as the generic parser allows the auto-switching only in a
limited situation (all three pins are located in different
positions).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index f3784808758e..75515b494034 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2089,6 +2089,9 @@ static void stac92hd83xxx_fixup_hp(struct hda_codec *codec,
 		codec_dbg(codec, "mute LED gpio %d polarity %d\n",
 				spec->gpio_led,
 				spec->gpio_led_polarity);
+
+	/* allow auto-switching of dock line-in */
+	spec->gen.line_in_auto_switch = true;
 }
 
 static void stac92hd83xxx_fixup_hp_zephyr(struct hda_codec *codec,
-- 
1.9.0
