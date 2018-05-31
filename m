From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt6797-mt6351: add hostless phone call
	path" to the asoc tree
Date: Thu, 31 May 2018 12:06:18 +0100
Message-ID: <E1fOLPO-0001wK-7q@debutante>
References: <1527729981-4802-3-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DF216267904
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 13:06:28 +0200 (CEST)
In-Reply-To: <1527729981-4802-3-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt6797-mt6351: add hostless phone call path

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

>From 983333c0f6c4c6b4dab1257d14d16c31912d7561 Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Thu, 31 May 2018 09:26:21 +0800
Subject: [PATCH] ASoC: mt6797-mt6351: add hostless phone call path

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 46 +++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index 9e5866d6819a..b1558c57b9ca 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -89,6 +89,32 @@ static struct snd_soc_dai_link mt6797_mt6351_dai_links[] = {
 		.dynamic = 1,
 		.dpcm_capture = 1,
 	},
+	{
+		.name = "Hostless_LPBK",
+		.stream_name = "Hostless_LPBK",
+		.cpu_dai_name = "Hostless LPBK DAI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
+	{
+		.name = "Hostless_Speech",
+		.stream_name = "Hostless_Speech",
+		.cpu_dai_name = "Hostless Speech DAI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
 	/* BE */
 	{
 		.name = "Primary Codec",
@@ -99,6 +125,26 @@ static struct snd_soc_dai_link mt6797_mt6351_dai_links[] = {
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
 	},
+	{
+		.name = "PCM 1",
+		.cpu_dai_name = "PCM 1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
+	{
+		.name = "PCM 2",
+		.cpu_dai_name = "PCM 2",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
 };
 
 static struct snd_soc_card mt6797_mt6351_card = {
-- 
2.17.0
