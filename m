From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] ac97: merge WM9703 and WM9705 ops
Date: Fri, 1 Jan 2010 19:05:43 +0100
Message-ID: <20100101190543.b22c3861.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B1489103806
	for <alsa-devel@alsa-project.org>; Fri,  1 Jan 2010 19:02:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The WM9705 and WM9703 ops are the same actually so use
the same code for both.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
I have another problem with the AC97. I have a Creative SB 128 card
(model CT4810). It has the ST Micro AC97 codec. There is no ST Micro
AC97 codec defined in the ALSA code. The sound plays ok, but reading
of certain registers (e.g. whole range from 0x2a to 0x7a) ends with timeout.

The codec ID (registers 0x7c and 0x7e) is "STM\04" (0x53544d04). 
The codec info is 20-bit DAC, 18-bit ADC, no 3D and reading of the tone control 
register (0x8) end with the timeout.

I put photos on the card here: http://picasaweb.google.com/krzysztof.h1/PCISoundCards#

Any help with identification is appreciated. Is there any list of codecs used by Creative 
in the SB 128/64/PCI cards? I suppose there were only few used.

Regards,
Krzysztof

 sound/pci/ac97/ac97_patch.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 139cf3b..e288a55 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -544,25 +544,10 @@ static int patch_wolfson04(struct snd_ac97 * ac97)
 	return 0;
 }
 
-static int patch_wolfson_wm9705_specific(struct snd_ac97 * ac97)
-{
-	int err, i;
-	for (i = 0; i < ARRAY_SIZE(wm97xx_snd_ac97_controls); i++) {
-		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm97xx_snd_ac97_controls[i], ac97))) < 0)
-			return err;
-	}
-	snd_ac97_write_cache(ac97,  0x72, 0x0808);
-	return 0;
-}
-
-static struct snd_ac97_build_ops patch_wolfson_wm9705_ops = {
-	.build_specific = patch_wolfson_wm9705_specific,
-};
-
 static int patch_wolfson05(struct snd_ac97 * ac97)
 {
 	/* WM9705, WM9710 */
-	ac97->build_ops = &patch_wolfson_wm9705_ops;
+	ac97->build_ops = &patch_wolfson_wm9703_ops;
 #ifdef CONFIG_TOUCHSCREEN_WM9705
 	/* WM9705 touchscreen uses AUX and VIDEO for touch */
 	ac97->flags |= AC97_HAS_NO_VIDEO | AC97_HAS_NO_AUX;
-- 
1.6.4


----------------------------------------------------------------------
Co Ci sie dzisiaj snilo? Czy wiesz, co oznacza Twoj sen?
Sprawdz w senniku >> http://link.interia.pl/f2532
