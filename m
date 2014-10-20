From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix inverted LED gpio setup for
	Lenovo Ideapad
Date: Mon, 20 Oct 2014 11:29:44 +0200
Message-ID: <1413797384-11766-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 04ADE260567
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 11:29:46 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C5D83ABCC
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 09:29:45 +0000 (UTC)
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

We implemented in a wrong way for mute LED on Lenovo Ideapad; the bit
must be flipped.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=16373
Cc: <stable@vger.kernel.org> # 3.15+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4c35490cf119..34b7bdb510c7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5613,9 +5613,9 @@ static void alc662_led_gpio1_mute_hook(void *private_data, int enabled)
 	unsigned int oldval = spec->gpio_led;
 
 	if (enabled)
-		spec->gpio_led &= ~0x01;
-	else
 		spec->gpio_led |= 0x01;
+	else
+		spec->gpio_led &= ~0x01;
 	if (spec->gpio_led != oldval)
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
 				    spec->gpio_led);
-- 
2.1.2
