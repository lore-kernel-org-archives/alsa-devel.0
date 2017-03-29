From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Update sig_bits based on
	converter capability" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:32 +0100
Message-ID: <E1ctCBM-0001aV-Vs@debutante>
References: <1490275926-2270-4-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F10D266F92
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:41 +0200 (CEST)
In-Reply-To: <1490275926-2270-4-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Update sig_bits based on converter capability

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

>From 66d6bbc6c0beb04c1dfeb0107d4d828f3e1959ee Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 24 Mar 2017 23:10:26 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Update sig_bits based on converter
 capability

When creating the codec dai, use sig_bits to update the max bps based
on the codec capability. So both the link DMA and codec format will be
calculated based on DAI sig_bits.

So update the sig_bits with converter capability and use the sig_bits
for HDA format calculation.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 78fca8acd3ec..5b7694721ef7 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -469,7 +469,7 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 
 	format = snd_hdac_calc_stream_format(params_rate(hparams),
 			params_channels(hparams), params_format(hparams),
-			24, 0);
+			dai->driver->playback.sig_bits, 0);
 
 	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, dai_map->cvt);
 	if (!pcm)
@@ -1419,8 +1419,8 @@ static int hdac_hdmi_create_dais(struct hdac_device *hdac,
 		hdmi_dais[i].playback.rate_min = rate_min;
 		hdmi_dais[i].playback.channels_min = 2;
 		hdmi_dais[i].playback.channels_max = 2;
+		hdmi_dais[i].playback.sig_bits = bps;
 		hdmi_dais[i].ops = &hdmi_dai_ops;
-
 		i++;
 	}
 
-- 
2.11.0
