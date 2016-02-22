From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix setting of stream rates,
	rate_min and rate_max" to the asoc tree
Date: Mon, 22 Feb 2016 19:51:29 +0900
Message-ID: <E1aXo5R-0005f6-9N@finisterre>
References: <1456129759-24017-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 599C72606FD
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 11:51:42 +0100 (CET)
In-Reply-To: <1456129759-24017-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix setting of stream rates, rate_min and rate_max

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

>From b6b6e4d670c9285225dc826bf69620f69717ade0 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Mon, 22 Feb 2016 16:29:19 +0800
Subject: [PATCH] ASoC: topology: Fix setting of stream rates, rate_min and
 rate_max

Directly set a stream's rates, rate_min and rate_max from the topology
info. Also define set_stream_info to wrap setting of the stream info.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 07f61a67aef6..1cf94d7fb9f4 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1530,6 +1530,18 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	return 0;
 }
 
+static void set_stream_info(struct snd_soc_pcm_stream *stream,
+	struct snd_soc_tplg_stream_caps *caps)
+{
+	stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+	stream->channels_min = caps->channels_min;
+	stream->channels_max = caps->channels_max;
+	stream->rates = caps->rates;
+	stream->rate_min = caps->rate_min;
+	stream->rate_max = caps->rate_max;
+	stream->formats = caps->formats;
+}
+
 static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
@@ -1548,25 +1560,13 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	if (pcm->playback) {
 		stream = &dai_drv->playback;
 		caps = &pcm->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
-
-		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
-		stream->channels_min = caps->channels_min;
-		stream->channels_max = caps->channels_max;
-		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
-							caps->rate_max);
-		stream->formats = caps->formats;
+		set_stream_info(stream, caps);
 	}
 
 	if (pcm->capture) {
 		stream = &dai_drv->capture;
 		caps = &pcm->caps[SND_SOC_TPLG_STREAM_CAPTURE];
-
-		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
-		stream->channels_min = caps->channels_min;
-		stream->channels_max = caps->channels_max;
-		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
-							caps->rate_max);
-		stream->formats = caps->formats;
+		set_stream_info(stream, caps);
 	}
 
 	/* pass control to component driver for optional further init */
-- 
2.7.0
