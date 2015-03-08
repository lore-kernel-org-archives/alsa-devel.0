From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] ASoC: wm8996: ensure lower bounds of 1 for timeout
Date: Sun,  8 Mar 2015 06:02:38 -0400
Message-ID: <1425808958-17104-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, Sachin Kamat <sachin.kamat@samsung.com>, Axel Lin <axel.lin@ingics.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

wait_for_completion_timeout can be called with timeout == 0 due to
msecs_to_jiffies(2) == 1 for HZ < 1000 and usecs_to_jiffies(300) == 1
for all reasonable values of HZ, thus the following timeout /= 2; sets
timeout to 0. This patch simply adds a lower-bounds of 1.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

line numbers from wm9666.c linux-next -next-20150306

2101      /* Wait for the FLL to lock, using the interrupt if possible */
2102      if (Fref > 1000000)
2103              timeout = usecs_to_jiffies(300);
2104      else
2105              timeout = msecs_to_jiffies(2);
2106 
2107      /* Allow substantially longer if we've actually got the IRQ, poll
2108       * at a slightly higher rate if we don't.
2109       */
2110      if (i2c->irq)
2111              timeout *= 10;
2112      else
2113              timeout /= 2;
2114
2115      ret = wait_for_completion_timeout(&wm8996->fll_lock,
2116                                        timeout);

The call-path here would then be: 
 wait_for_completion_timeout(...,timeout)
  -> wait_for_common action==schedule_timeout
   -> schedule_timeout(timeout)
      ...
      expire = timeout + jiffies;

so expire == jiffies here and the timer would expire immediately
for systems with HZ<1000 due to msecs_to_jiffies(2) == 1 and the
following timeout /= 2 -> timeout == 0, which is probably a bit 
more that a "slightly higher rate".

This was only compile tested for exynos_defconfig + CONFIG_COMPILE_TEST=y,
SND_SOC_ALL_CODECS=m (implies CONFIG_SND_SOC_WM8996=m)

Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)

 sound/soc/codecs/wm8996.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 24d9705..5ded102 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2110,7 +2110,8 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	if (i2c->irq)
 		timeout *= 10;
 	else
-		timeout /= 2;
+		/* ensure timeout of atleast 1 jiffies */
+		timeout = timeout/2 ? : 1;
 
 	for (retry = 0; retry < 10; retry++) {
 		time_left = wait_for_completion_timeout(&wm8996->fll_lock,
-- 
1.7.10.4
