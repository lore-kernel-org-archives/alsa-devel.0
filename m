From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: clean-up compressed DAI
	definition" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:28 +0000
Message-ID: <E1aAG2q-0004d5-8z@debutante>
References: <1450406156-22246-11-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1640C26044E
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:34 +0100 (CET)
In-Reply-To: <1450406156-22246-11-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: clean-up compressed DAI definition

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

>From 77095796ae9cbaf315f80611edb5aa569796e339 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:47 -0600
Subject: [PATCH] ASoC: Intel: Atom: clean-up compressed DAI definition

the fields channels_min, channels_max, rate and formats are
irrelevant for compressed playback, they will depend on the
content. This was probably a copy-paste mistake to have
them in the first place

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index c1f618ed183b..55c33dc76ce4 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -528,10 +528,6 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 	.ops = &sst_compr_dai_ops,
 	.playback = {
 		.stream_name = "Compress Playback",
-		.channels_min = SST_STEREO,
-		.channels_max = SST_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 },
 /* BE CPU  Dais */
-- 
2.6.2
