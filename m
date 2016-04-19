From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7219: Disallow unsupported 32KHz
 clock setting in set_dai_sysclk()
Date: Tue, 19 Apr 2016 15:19:03 +0100
Message-ID: <2f0a44c076880b6e39aa8440f9a021f9627f34a3.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F55A2655E3
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 16:19:04 +0200 (CEST)
In-Reply-To: <cover.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The PLL function was updated to disallow 32KHz in
commit 501f72e9c520 ("ASoC: da7219: Remove support for 32KHz PLL mode"),
but set_dai_sysclk() was missed and still permits it. This patch resolves
that discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 3b1d65b..caea2ee 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1025,7 +1025,7 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq))
 		return 0;
 
-	if (((freq < 2000000) && (freq != 32768)) || (freq > 54000000)) {
+	if ((freq < 2000000) || (freq > 54000000)) {
 		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
-- 
1.9.3
