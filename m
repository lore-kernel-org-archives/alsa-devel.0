From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] ASoC: wm8996: match
	wait_for_completion_timeout return type
Date: Sun,  8 Mar 2015 06:02:15 -0400
Message-ID: <1425808935-17070-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB88260438
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 11:06:37 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Xiubo Li <Li.Xiubo@freescale.com>, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Sachin Kamat <sachin.kamat@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nicholas Mc Guire <hofrat@osadl.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, abdoulaye berthe <berthe.ab@gmail.com>
List-Id: alsa-devel@alsa-project.org

return type of wait_for_completion_timeout is unsigned long not int. An
appropriately named unsigned long is added and the assignment fixed up
in case of completion occurring the remaining time is >=1 so ret is set to
1 if no timeout occurred.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

This was only compile tested for exynos_defconfig + CONFIG_COMPILE_TEST=y, 
SND_SOC_ALL_CODECS=m (implies CONFIG_SND_SOC_WM8996=m)

Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)

 sound/soc/codecs/wm8996.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index dc92d5e..24d9705 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2009,7 +2009,7 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
 	struct _fll_div fll_div;
-	unsigned long timeout;
+	unsigned long timeout, time_left;
 	int ret, reg, retry;
 
 	/* Any change? */
@@ -2113,10 +2113,11 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		timeout /= 2;
 
 	for (retry = 0; retry < 10; retry++) {
-		ret = wait_for_completion_timeout(&wm8996->fll_lock,
-						  timeout);
-		if (ret != 0) {
+		time_left = wait_for_completion_timeout(&wm8996->fll_lock,
+							timeout);
+		if (time_left != 0) {
 			WARN_ON(!i2c->irq);
+			ret = 1;
 			break;
 		}
 
-- 
1.7.10.4
