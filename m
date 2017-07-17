From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: constify snd_soc_dai_ops
	structure" to the asoc tree
Date: Mon, 17 Jul 2017 17:04:26 +0100
Message-ID: <E1dX8VW-0004RL-IG@debutante>
References: <f8993aaa6db0fcd64aab7672da799fe4ef74966e.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE42266FCD
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:04:54 +0200 (CEST)
In-Reply-To: <f8993aaa6db0fcd64aab7672da799fe4ef74966e.1499974826.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: constify snd_soc_dai_ops structure

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

>From 61b3b3cc68c4161ba202f401a6572250360ff18c Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 13 Jul 2017 15:38:38 -0500
Subject: [PATCH] ASoC: hdac_hdmi: constify snd_soc_dai_ops structure

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index bc2e74ff3b2d..e6de50acefd4 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1360,7 +1360,7 @@ static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
 
 }
 
-static struct snd_soc_dai_ops hdmi_dai_ops = {
+static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup = hdac_hdmi_pcm_open,
 	.shutdown = hdac_hdmi_pcm_close,
 	.hw_params = hdac_hdmi_set_hw_params,
-- 
2.13.2
