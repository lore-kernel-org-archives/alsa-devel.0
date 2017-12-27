From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2200: don't use
	snd_soc_dai::symmetric_rates" to the asoc tree
Date: Wed, 27 Dec 2017 10:39:37 +0000 (GMT)
Message-ID: <20171227103937.531E944006B@finisterre.ee.mobilebroadband>
References: <87zi6exk5i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3405C267396
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 11:39:38 +0100 (CET)
In-Reply-To: <87zi6exk5i.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2200: don't use snd_soc_dai::symmetric_rates

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0e2d95aadd5c3bddfa4145b964527df12d89ec6a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 01:37:54 +0000
Subject: [PATCH] ASoC: wm2200: don't use snd_soc_dai::symmetric_rates

wm2200 is the only user of snd_soc_dai::symmetric_rates.
Now, wm2200 is using single DAI on Component.
Thus, wm2200_priv : snd_soc_dai : snd_soc_component are 1 : 1 : 1.
We can replace snd_soc_dai::symmetric_rates on wm2200_priv.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2200.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 2d03db6efb79..5c2f5727244d 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -98,6 +98,8 @@ struct wm2200_priv {
 
 	int rev;
 	int sysclk;
+
+	unsigned int symmetric_rates:1;
 };
 
 #define WM2200_DSP_RANGE_BASE (WM2200_MAX_REGISTER + 1)
@@ -1758,7 +1760,7 @@ static int wm2200_hw_params(struct snd_pcm_substream *substream,
 	lrclk = bclk_rates[bclk] / params_rate(params);
 	dev_dbg(codec->dev, "Setting %dHz LRCLK\n", bclk_rates[bclk] / lrclk);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
-	    dai->symmetric_rates)
+	    wm2200->symmetric_rates)
 		snd_soc_update_bits(codec, WM2200_AUDIO_IF_1_7,
 				    WM2200_AIF1RX_BCPF_MASK, lrclk);
 	else
@@ -2059,13 +2061,14 @@ static int wm2200_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 static int wm2200_dai_probe(struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct wm2200_priv *wm2200 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val = 0;
 	int ret;
 
 	ret = snd_soc_read(codec, WM2200_GPIO_CTRL_1);
 	if (ret >= 0) {
 		if ((ret & WM2200_GP1_FN_MASK) != 0) {
-			dai->symmetric_rates = true;
+			wm2200->symmetric_rates = true;
 			val = WM2200_AIF1TX_LRCLK_SRC;
 		}
 	} else {
-- 
2.15.0
