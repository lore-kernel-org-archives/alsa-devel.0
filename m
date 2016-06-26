From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: fix missing breaks that
	would cause the wrong operation to execute" to the asoc tree
Date: Sun, 26 Jun 2016 13:02:53 +0100
Message-ID: <E1bH8m5-0002UE-U0@debutante>
References: <1466699823-27891-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B8062650FA
 for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2016 14:02:58 +0200 (CEST)
In-Reply-To: <1466699823-27891-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: fix missing breaks that would cause the wrong operation to execute

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

>From 9c4639ec959f3618b5f7a7ea977ed09396c869c3 Mon Sep 17 00:00:00 2001
From: Alan Cox <alan@linux.intel.com>
Date: Thu, 23 Jun 2016 22:07:03 +0530
Subject: [PATCH] ASoC: Intel: atom: fix missing breaks that would cause the
 wrong operation to execute

Now we correctly error an attempt to execute an unsupported operation.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-compress.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-compress.c b/sound/soc/intel/atom/sst-mfld-platform-compress.c
index 395168986462..1bead81bb510 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-compress.c
@@ -182,24 +182,29 @@ static int sst_platform_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 		if (stream->compr_ops->stream_start)
 			return stream->compr_ops->stream_start(sst->dev, stream->id);
+		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (stream->compr_ops->stream_drop)
 			return stream->compr_ops->stream_drop(sst->dev, stream->id);
+		break;
 	case SND_COMPR_TRIGGER_DRAIN:
 		if (stream->compr_ops->stream_drain)
 			return stream->compr_ops->stream_drain(sst->dev, stream->id);
+		break;
 	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
 		if (stream->compr_ops->stream_partial_drain)
 			return stream->compr_ops->stream_partial_drain(sst->dev, stream->id);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (stream->compr_ops->stream_pause)
 			return stream->compr_ops->stream_pause(sst->dev, stream->id);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (stream->compr_ops->stream_pause_release)
 			return stream->compr_ops->stream_pause_release(sst->dev, stream->id);
-	default:
-		return -EINVAL;
+		break;
 	}
+	return -EINVAL;
 }
 
 static int sst_platform_compr_pointer(struct snd_compr_stream *cstream,
-- 
2.8.1
