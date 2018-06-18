From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4458: make structure
	soc_codec_dev_ak4458 static const" to the asoc tree
Date: Mon, 18 Jun 2018 12:59:58 +0100
Message-ID: <E1fUspC-0008U3-Uz@debutante>
References: <20180606103123.31719-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 50DF02676E6
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:08 +0200 (CEST)
In-Reply-To: <20180606103123.31719-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4458: make structure soc_codec_dev_ak4458 static const

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

>From 62624f72592b1d8e756e699cd6ade2be379f95a9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 6 Jun 2018 11:31:23 +0100
Subject: [PATCH] ASoC: ak4458: make structure soc_codec_dev_ak4458 static
 const

The structure soc_codec_dev_ak4458 is local to the source and do not
need to be in global scope and can be const, make it static const.

Cleans up sparse warnings:
warning: symbol 'soc_codec_dev_ak4458' was not declared. Should it
be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 31ec0ba2e639..299ada4dfaa0 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -558,7 +558,7 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-struct snd_soc_component_driver soc_codec_dev_ak4458 = {
+static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
 	.probe			= ak4458_probe,
 	.remove			= ak4458_remove,
 	.controls		= ak4458_snd_controls,
-- 
2.17.1
