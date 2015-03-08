From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: wm5100: match
	wait_for_completion_timeout return type
Date: Sun,  8 Mar 2015 06:57:07 -0400
Message-ID: <1425812227-24172-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 5573426043B
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 12:01:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Xiubo Li <Li.Xiubo@freescale.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, patches@opensource.wolfsonmicro.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nicholas Mc Guire <hofrat@osadl.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, abdoulaye berthe <berthe.ab@gmail.com>
List-Id: alsa-devel@alsa-project.org

return type of wait_for_completion_timeout is unsigned long not int. An
appropriately named unsigned long is added and the assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

This was only compile tested for exynos_defconfig + CONFIG_COMPILE_TEST=y,
SND_SOC_ALL_CODECS=m (implies CONFIG_SND_SOC_WM5100=m)

Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)

 sound/soc/codecs/wm5100.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index ea09db5..9674037 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1762,6 +1762,7 @@ static int wm5100_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	struct _fll_div factors;
 	struct wm5100_fll *fll;
 	int ret, base, lock, i, timeout;
+	unsigned long time_left;
 
 	switch (fll_id) {
 	case WM5100_FLL1:
@@ -1842,9 +1843,9 @@ static int wm5100_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	/* Poll for the lock; will use interrupt when we can test */
 	for (i = 0; i < timeout; i++) {
 		if (i2c->irq) {
-			ret = wait_for_completion_timeout(&fll->lock,
-							  msecs_to_jiffies(25));
-			if (ret > 0)
+			time_left = wait_for_completion_timeout(&fll->lock,
+							msecs_to_jiffies(25));
+			if (time_left > 0)
 				break;
 		} else {
 			msleep(1);
-- 
1.7.10.4
