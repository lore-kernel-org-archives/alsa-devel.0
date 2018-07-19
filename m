From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Allow up to 8 channels for
	voice control" to the asoc tree
Date: Thu, 19 Jul 2018 17:57:17 +0100
Message-ID: <E1fgCEv-0005V5-1y@debutante>
References: <20180719105039.28312-4-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3DD1267786
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:57:20 +0200 (CEST)
In-Reply-To: <20180719105039.28312-4-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, stuarth@opensource.cirrus.com, rf@opensource.cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Allow up to 8 channels for voice control

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

>From 3bbc2705a3d132b9a86a0e4083f82a2b3c9bfdfd Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Thu, 19 Jul 2018 11:50:38 +0100
Subject: [PATCH] ASoC: wm_adsp: Allow up to 8 channels for voice control

Newer voice control firmwares can capture multiple audio channels.
Allow up to 8 channels for future-proofing.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index eec73c98a141..aeb1b8c27670 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -418,7 +418,7 @@ static const struct wm_adsp_fw_caps ctrl_caps[] = {
 	{
 		.id = SND_AUDIOCODEC_BESPOKE,
 		.desc = {
-			.max_ch = 1,
+			.max_ch = 8,
 			.sample_rates = { 16000 },
 			.num_sample_rates = 1,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
-- 
2.18.0
