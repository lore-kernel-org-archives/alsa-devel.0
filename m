From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1305: Use ULL suffixes for 64-bit constants" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:18 +0100
Message-ID: <E1fUspW-0000CY-C2@debutante>
References: <1528379448-3937-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528379448-3937-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Shuming Fan <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1305: Use ULL suffixes for 64-bit constants

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4f29b663c08d369fe320a148179996c94cf7d01b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Jun 2018 15:50:48 +0200
Subject: [PATCH] ASoC: rt1305: Use ULL suffixes for 64-bit constants
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc 4.1.2:

    sound/soc/codecs/rt1305.c: In function ‘rt1305_calibrate’:
    sound/soc/codecs/rt1305.c:1069: warning: integer constant is too large for ‘long’ type
    sound/soc/codecs/rt1305.c:1086: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to fix this.

Fixes: 29bc643ddd7efb74 ("ASoC: rt1305: Add RT1305/RT1306 amplifier driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index f4c8c45f4010..421b8fb2fa04 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1066,7 +1066,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	pr_debug("Left_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Left channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0l = 562949953421312;
+	r0l = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0l, rhl);
 	pr_debug("Left_r0 = 0x%llx\n", r0l);
@@ -1083,7 +1083,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	pr_debug("Right_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Right channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0r = 562949953421312;
+	r0r = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0r, rhl);
 	pr_debug("Right_r0 = 0x%llx\n", r0r);
-- 
2.17.1
