From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak5558: make two structures static" to
	the asoc tree
Date: Mon, 18 Jun 2018 13:00:01 +0100
Message-ID: <E1fUspF-0008VA-60@debutante>
References: <20180606095719.30831-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 852B92675D5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:07 +0200 (CEST)
In-Reply-To: <20180606095719.30831-1-colin.king@canonical.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak5558: make two structures static

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

>From e380be7c557c4ddb1cb71404c10e0bfb3daf4644 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 6 Jun 2018 10:57:19 +0100
Subject: [PATCH] ASoC: ak5558: make two structures static

The structure ak5558_pm and soc_codec_dev_ak5558 are local to the
source and do not need to be in global scope, so make them static.
Also make soc_codec_dev_ak5558 static.

Cleans up sparse warnings:
warning: symbol 'ak5558_pm' was not declared. Should it be static?
warning: symbol 'soc_codec_dev_ak5558' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak5558.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f4ed5cc40661..448bb90c9c8e 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -322,13 +322,13 @@ static int __maybe_unused ak5558_runtime_resume(struct device *dev)
 	return regcache_sync(ak5558->regmap);
 }
 
-const struct dev_pm_ops ak5558_pm = {
+static const struct dev_pm_ops ak5558_pm = {
 	SET_RUNTIME_PM_OPS(ak5558_runtime_suspend, ak5558_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 };
 
-struct snd_soc_component_driver soc_codec_dev_ak5558 = {
+static const struct snd_soc_component_driver soc_codec_dev_ak5558 = {
 	.probe			= ak5558_probe,
 	.remove			= ak5558_remove,
 	.controls		= ak5558_snd_controls,
-- 
2.17.1
