From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove unused function" to the
	asoc tree
Date: Wed, 16 Sep 2015 21:01:48 +0100
Message-ID: <E1ZcIto-0007tK-AT@finisterre>
References: <1441888305-19957-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4B22650E1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:02:03 +0200 (CEST)
In-Reply-To: <1441888305-19957-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: remove unused function

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

>From 2fc171e69e0dc0f5cce805ec40923c4e7ff78e94 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 10 Sep 2015 18:01:45 +0530
Subject: [PATCH] ASoC: Intel: remove unused function

The function get_current_pipe_id() was not being used.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 683e501..5e9c316c 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -368,23 +368,6 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	kfree(stream);
 }
 
-static inline unsigned int get_current_pipe_id(struct snd_soc_dai *dai,
-					       struct snd_pcm_substream *substream)
-{
-	struct sst_data *sst = snd_soc_dai_get_drvdata(dai);
-	struct sst_dev_stream_map *map = sst->pdata->pdev_strm_map;
-	struct sst_runtime_stream *stream =
-			substream->runtime->private_data;
-	u32 str_id = stream->stream_info.str_id;
-	unsigned int pipe_id;
-
-	pipe_id = map[str_id].device_id;
-
-	dev_dbg(dai->dev, "got pipe_id = %#x for str_id = %d\n",
-			pipe_id, str_id);
-	return pipe_id;
-}
-
 static int sst_media_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-- 
2.5.0
