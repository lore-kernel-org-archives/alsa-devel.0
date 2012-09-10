From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: am3517evm: Remove unused cpu_dai from
	hw_params
Date: Mon, 10 Sep 2012 15:55:17 +0300
Message-ID: <1347281717-10244-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog128.obsmtp.com (na3sys009aog128.obsmtp.com
 [74.125.149.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 66A4B26508C
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 14:54:54 +0200 (CEST)
Received: by oagl20 with SMTP id l20so457148oag.38
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 05:54:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

cpu_dai is not in use in this function and just generates warning at
compile time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi,

Commit: fca04ae ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR signal muxing
left this line in the code which generates now warning.

This patch is on top of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/omap

Regards,
Peter

 sound/soc/omap/am3517evm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index a997988..77a8701 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -41,7 +41,6 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* Set the codec system clock for DAC and ADC */
-- 
1.7.12
