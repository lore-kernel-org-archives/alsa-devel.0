From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: fix spelling mistake: "deteced" -> "detected"" to the asoc tree
Date: Wed, 17 May 2017 10:52:30 +0100
Message-ID: <E1dAvd8-0006t2-0q@debutante>
References: <20170514165321.6615-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170514165321.6615-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vincent Abriou <vincent.abriou@st.com>, Jon Medhurst <tixy@linaro.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: fix spelling mistake: "deteced" -> "detected"

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

>From 0c343a35bfecdf26c7041781815f3b639a45d93a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 14 May 2017 17:53:21 +0100
Subject: [PATCH] ASoC: hdmi-codec: fix spelling mistake: "deteced" ->
 "detected"

Trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 8c5ae1fc23a9..a3f15149afcf 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -819,7 +819,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	mutex_unlock(&hdmi_mutex);
 
 	if (hd->cnt >= ARRAY_SIZE(hdmi_dai_name)) {
-		dev_err(dev, "too many hdmi codec are deteced\n");
+		dev_err(dev, "too many hdmi codec are detected\n");
 		return -EINVAL;
 	}
 
-- 
2.11.0
