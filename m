From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Remove some extraneous blank
	lines" to the asoc tree
Date: Fri, 26 Jan 2018 15:25:45 +0000
Message-ID: <E1ef5sv-0006YX-Qz@debutante>
References: <20180126130845.7122-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D13026721A
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 16:25:53 +0100 (CET)
In-Reply-To: <20180126130845.7122-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, lgirdwood@gmail.com, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Remove some extraneous blank lines

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

>From b2154d729edad549842cdbaae4beda18dbb425ff Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 26 Jan 2018 13:08:44 +0000
Subject: [PATCH] ASoC: compress: Remove some extraneous blank lines

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 7973f92cd40f..b1cf758e3be2 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -145,7 +145,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		}
 	}
 
-
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
@@ -307,7 +306,6 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (!codec_dai->active)
 		codec_dai->rate = 0;
 
-
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
 
@@ -460,7 +458,6 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger)
 		cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
 
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
-- 
2.15.1
