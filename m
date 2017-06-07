From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: remove unused ratec" to the asoc tree
Date: Wed, 07 Jun 2017 20:31:39 +0100
Message-ID: <E1dIgg7-0003cz-PM@debutante>
References: <87k24o4sr3.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k24o4sr3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: remove unused ratec

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

>From ca3b5ad30c0b32f8d12ddb307b698ff56d56c2aa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Jun 2017 23:16:01 +0000
Subject: [PATCH] ASoC: hdmi-codec: remove unused ratec

struct snd_pcm_hw_constraint_list ratec is not used.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 6d05161b625d..22ed0dc88f0a 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -282,7 +282,6 @@ struct hdmi_codec_priv {
 	struct hdmi_codec_daifmt daifmt[2];
 	struct mutex current_stream_lock;
 	struct snd_pcm_substream *current_stream;
-	struct snd_pcm_hw_constraint_list ratec;
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
-- 
2.11.0
