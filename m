From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm: improve debug output for DPCM BE
	searching." to the asoc tree
Date: Mon, 19 Mar 2018 08:09:02 +0000 (GMT)
Message-ID: <20180319080902.C0C2F44007A@finisterre.ee.mobilebroadband>
References: <20180314204351.13973-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D21B32672C0
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 09:09:05 +0100 (CET)
In-Reply-To: <20180314204351.13973-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm: improve debug output for DPCM BE searching.

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

>From 3c1464658ec642309453db33364e82291d98acc2 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Wed, 14 Mar 2018 20:43:51 +0000
Subject: [PATCH] ASoC: pcm: improve debug output for DPCM BE searching.

Improve the DPCM BE search debug output to make it easier to debug
issues in topologies.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 084125463d10..68d9dc930096 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1392,12 +1392,18 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 	struct snd_soc_pcm_runtime *be;
 	int i;
 
+	dev_dbg(card->dev, "ASoC: find BE for widget %s\n", widget->name);
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		list_for_each_entry(be, &card->rtd_list, list) {
 
 			if (!be->dai_link->no_pcm)
 				continue;
 
+			dev_dbg(card->dev, "ASoC: try BE : %s\n",
+				be->cpu_dai->playback_widget ?
+				be->cpu_dai->playback_widget->name : "(not set)");
+
 			if (be->cpu_dai->playback_widget == widget)
 				return be;
 
@@ -1414,6 +1420,10 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
+			dev_dbg(card->dev, "ASoC: try BE %s\n",
+				be->cpu_dai->capture_widget ?
+				be->cpu_dai->capture_widget->name : "(not set)");
+
 			if (be->cpu_dai->capture_widget == widget)
 				return be;
 
@@ -1425,6 +1435,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	}
 
+	/* dai link name and stream name set correctly ? */
 	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
 		stream ? "capture" : "playback", widget->name);
 	return NULL;
-- 
2.16.2
