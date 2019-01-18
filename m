From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove error due to probe
	deferral" to the asoc tree
Date: Fri, 18 Jan 2019 18:38:29 +0000 (GMT)
Message-ID: <20190118183829.1E65F11276E7@debutante.sirena.org.uk>
References: <20190118095504.22397-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9593F266AA9
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 19:38:31 +0100 (CET)
In-Reply-To: <20190118095504.22397-1-stefan@agner.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove error due to probe deferral

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

>From 7c7e2d6a9ca3c74ba7ed4da2a75916b2f9ae38f0 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Fri, 18 Jan 2019 10:55:04 +0100
Subject: [PATCH] ASoC: soc-core: remove error due to probe deferral

Deferred probes shouldn't cause error messages in the boot log, so
change the dev_err() to the more harmless dev_info().

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..98bb05f6ed56 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -903,8 +903,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				codecs[i].dai_name);
+			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
+				 codecs[i].dai_name);
 			goto _err_defer;
 		}
 		snd_soc_rtdcom_add(rtd, codec_dais[i]->component);
-- 
2.20.1
