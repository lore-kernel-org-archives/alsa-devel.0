From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] SoC: nau8825: remove unnecessary unlikely()
Date: Sun,  4 Nov 2018 07:55:29 -0500
Message-ID: <20181104125529.3681-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, KCHSU0@nuvoton.com, gustavo@embeddedor.com, abhijeet.kumar@intel.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: alsa-devel@alsa-project.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 sound/soc/codecs/nau8825.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index b9fed99d8b5e..7bbcbf5f05c8 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -424,10 +424,8 @@ static u32 nau8825_xtalk_sidetone(u32 sig_org, u32 sig_cros)
 {
 	u32 gain, sidetone;
 
-	if (unlikely(sig_org == 0) || unlikely(sig_cros == 0)) {
-		WARN_ON(1);
+	if (WARN_ON(sig_org == 0 || sig_cros == 0))
 		return 0;
-	}
 
 	sig_org = nau8825_intlog10_dec3(sig_org);
 	sig_cros = nau8825_intlog10_dec3(sig_cros);
-- 
2.17.0
