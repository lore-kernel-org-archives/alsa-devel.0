From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: Add checks of playback/capture
	before dpcm_get_be" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:31 +0100
Message-ID: <E1ZCTNL-0005Q4-7A@finisterre>
References: <1436148130-22739-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA67E26548E
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:44 +0200 (CEST)
In-Reply-To: <1436148130-22739-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: Add checks of playback/capture before dpcm_get_be

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

>From c5b8540dca22526517f4d96857678466613467d1 Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Mon, 6 Jul 2015 10:02:10 +0800
Subject: [PATCH] ASoC: dpcm: Add checks of playback/capture before dpcm_get_be

In dpcm_get_be(), it looks for a BE rtd that has the DAI widget
according to current stream type. Only playback_widgets are searched
in the case of playback stream and vice versa. However, the DAI widget
itself can be playback or capture.

If the DAI widget is capture, but current stream type is playback,
dpcm_get_be() will always fail to find a rtd, print error messages,
and continue to the next DAI widget in list. We can just skip this
DAI widget to further suppress error messages. This happens in a
special case when 2 codecs are inter-connected, and the 1st codec's
"capture" widget is used to send data to the 2nd codec during "playback":

mtk-rt5650-rt5676 sound: ASoC: can't get playback BE for Sub AIF2 Capture
rt5650_rt5676 Playback: ASoC: no BE found for Sub AIF2 Capture

Add checks to continue to next DAI widget if current DAI widget's
direction does not match the stream type.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 256b9c9..a6d3313 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1306,7 +1306,12 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 
 		switch (list->widgets[i]->id) {
 		case snd_soc_dapm_dai_in:
+			if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+				continue;
+			break;
 		case snd_soc_dapm_dai_out:
+			if (stream != SNDRV_PCM_STREAM_CAPTURE)
+				continue;
 			break;
 		default:
 			continue;
-- 
2.1.4
