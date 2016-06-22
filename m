From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Pass error out of
	soc_compr_pointer" to the asoc tree
Date: Wed, 22 Jun 2016 16:29:25 +0100
Message-ID: <E1bFk5l-0002dU-Qf@debutante>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56582268054
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:29:34 +0200 (CEST)
In-Reply-To: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Pass error out of soc_compr_pointer

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

>From 7c9190f7e7428487cd67839f9a547efcc9ec3b9b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 20 Jun 2016 09:51:32 +0100
Subject: [PATCH] ASoC: compress: Pass error out of soc_compr_pointer

Both soc_compr_pointer and the platform driver pointer callback return
ints but current soc_compr_pointer always returns 0. Update this so we
return the actual value from the platform driver callback. This doesn't
fix any issues simply makes the code more consistent.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 875733c52953..d2df46c14c68 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -530,14 +530,15 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
-		 platform->driver->compr_ops->pointer(cstream, tstamp);
+		ret = platform->driver->compr_ops->pointer(cstream, tstamp);
 
 	mutex_unlock(&rtd->pcm_mutex);
-	return 0;
+	return ret;
 }
 
 static int soc_compr_copy(struct snd_compr_stream *cstream,
-- 
2.8.1
