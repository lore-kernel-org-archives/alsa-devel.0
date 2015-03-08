From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: arizona: match
	wait_for_completion_timeout return type
Date: Sun,  8 Mar 2015 09:16:49 -0400
Message-ID: <1425820609-28684-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ECA4260444
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 14:21:07 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Lee Jones <lee.jones@linaro.org>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

return type of wait_for_completion_timeout is unsigned long not int. An
appropriately named unsigned long is added and the assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Note that the error message
 "Timed out waiting for lock"
might not be that clear in a kernel log message as it 
could probably be read as relating to a kernel lock 
 "Timed out waiting for FLL lock"
might be clearer.

This was only compile tested for exynos_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC_ALL_CODECS=m, EXTCON_ARIZONA=m, CONFIG_MFD_ARIZONA_SPI=m, 
CONFIG_MFD_WM5102=y, (implies SND_SOC_ARIZONA=m)

Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)

 sound/soc/codecs/arizona.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 95d31d6..57da0ce 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1902,7 +1902,7 @@ static int arizona_is_enabled_fll(struct arizona_fll *fll)
 static int arizona_enable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
-	int ret;
+	unsigned long time_left;
 	bool use_sync = false;
 	int already_enabled = arizona_is_enabled_fll(fll);
 	struct arizona_fll_cfg cfg;
@@ -1978,9 +1978,9 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 		regmap_update_bits_async(arizona->regmap, fll->base + 1,
 					 ARIZONA_FLL1_FREERUN, 0);
 
-	ret = wait_for_completion_timeout(&fll->ok,
+	time_left = wait_for_completion_timeout(&fll->ok,
 					  msecs_to_jiffies(250));
-	if (ret == 0)
+	if (time_left == 0)
 		arizona_fll_warn(fll, "Timed out waiting for lock\n");
 
 	return 0;
-- 
1.7.10.4
