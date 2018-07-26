From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm186x: Declare PCM format with
	snd_pcm_format_t" to the asoc tree
Date: Thu, 26 Jul 2018 17:11:20 +0100 (BST)
Message-ID: <20180726161120.DAAFE44007E@finisterre.ee.mobilebroadband>
References: <20180725211722.18944-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9857226779C
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:42 +0200 (CEST)
In-Reply-To: <20180725211722.18944-6-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm186x: Declare PCM format with snd_pcm_format_t

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

>From 79b8a50813a80ac15fdcdc96674098dee15eaaf5 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 23:17:21 +0200
Subject: [PATCH] ASoC: pcm186x: Declare PCM format with snd_pcm_format_t

The PCM format type is with __bitwise, so we should use the dedicated
snd_pcm_format_t instead of int.

This fixes the sparse warning like:
  sound/soc/codecs/pcm186x.c:268:44: warning: incorrect type in initializer (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm186x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 88fde70b1e9e..690c26e7389e 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -265,7 +265,7 @@ static int pcm186x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct pcm186x_priv *priv = snd_soc_component_get_drvdata(component);
 	unsigned int rate = params_rate(params);
-	unsigned int format = params_format(params);
+	snd_pcm_format_t format = params_format(params);
 	unsigned int width = params_width(params);
 	unsigned int channels = params_channels(params);
 	unsigned int div_lrck;
-- 
2.18.0
