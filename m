From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RESEND] ASoC: pxa: remove unused variable
Date: Thu, 25 Feb 2016 23:02:04 +0100
Message-ID: <1456437736-732609-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FA7A2606F5
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 23:02:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

As pointed out by Zhangfei Gao, the sspa_div variable in
brownstone_wm8994_hw_params() is completely unused, so as a cleanup
following a prior patch, this removes both the variable and the division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Submitted originally on Nov 23 2015, this apparently got lost,
resending it now.

 sound/soc/pxa/brownstone.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 416ea646c3b1..ec522e94b0e2 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -52,7 +52,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int freq_out, sspa_mclk, sysclk;
-	int sspa_div;
 
 	if (params_rate(params) > 11025) {
 		freq_out  = params_rate(params) * 512;
@@ -63,7 +62,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 		sysclk    = params_rate(params) * 512;
 		sspa_mclk = params_rate(params) * 64;
 	}
-	sspa_div = freq_out / sspa_mclk;
 
 	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
 	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
-- 
2.7.0
