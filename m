From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] ASoC: Avoid writing to WM8971_RESET in wm8971_resume
Date: Tue, 04 Oct 2011 07:44:22 +0800
Message-ID: <1317685462.3640.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kenneth Kiraly <kiraly@lab126.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Writing to WM8971_RESET resets all registers to the default state.
Thus we should avoid writing to WM8971_RESET on resume.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Hi,
While reading the code, I don't understand why we need to do (in wm8971_resume):

for (i = 0; i < ARRAY_SIZE(wm8971_reg); i++) {
        if (i + 1 == WM8971_RESET)
                continue;

My understanding is that we want to avoid writing to WM8971_RESET on resume.
Thus I send this patch for review.
I don't have the hardware for testing, I'd appreciate if someone can test this patch.

Thanks,
Axel

 sound/soc/codecs/wm8971.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 572bb80..7ec4165 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -612,7 +612,7 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 
 	/* Sync reg_cache with the hardware */
 	for (i = 0; i < ARRAY_SIZE(wm8971_reg); i++) {
-		if (i + 1 == WM8971_RESET)
+		if (i == WM8971_RESET)
 			continue;
 		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
 		data[1] = cache[i] & 0x00ff;
-- 
1.7.4.1
