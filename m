From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: rt1305: Use ULL suffixes for 64-bit constants
Date: Thu,  7 Jun 2018 15:50:48 +0200
Message-ID: <1528379448-3937-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuming Fan <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

With gcc 4.1.2:

    sound/soc/codecs/rt1305.c: In function ‘rt1305_calibrate’:
    sound/soc/codecs/rt1305.c:1069: warning: integer constant is too large for ‘long’ type
    sound/soc/codecs/rt1305.c:1086: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to fix this.

Fixes: 29bc643ddd7efb74 ("ASoC: rt1305: Add RT1305/RT1306 amplifier driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/rt1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index f4c8c45f40103cf8..421b8fb2fa04dd63 100644
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
2.7.4
