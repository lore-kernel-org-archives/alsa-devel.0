From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix possible memory leak in
	hw_params" to the asoc tree
Date: Sun, 21 Feb 2016 02:15:55 +0900
Message-ID: <E1aXB8N-0008Nd-44@finisterre>
References: <1455725047-7303-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 105012651B9
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:02 +0100 (CET)
In-Reply-To: <1455725047-7303-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix possible memory leak in hw_params

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6793a3d70676c6f3d2ec0ce4e1e241617541702c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 17 Feb 2016 21:33:59 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix possible memory leak in hw_params

It's possible for hw_params to be called two times. So add NULL
check to prevent memory leak.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 2884dbf..d2a2e18 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -405,9 +405,13 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 		return -ENODEV;
 	}
 
-	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
-	if (!dd)
-		return -ENOMEM;
+	dd = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dd) {
+		dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+		if (!dd)
+			return -ENOMEM;
+	}
+
 	dd->format = snd_hdac_calc_stream_format(params_rate(hparams),
 			params_channels(hparams), params_format(hparams),
 			24, 0);
@@ -433,9 +437,11 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 				AC_VERB_SET_STREAM_FORMAT, 0);
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
 
-	kfree(dd);
+	if (dd) {
+		snd_soc_dai_set_dma_data(dai, substream, NULL);
+		kfree(dd);
+	}
 
 	return 0;
 }
-- 
2.7.0
