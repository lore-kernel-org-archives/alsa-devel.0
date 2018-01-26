From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Correct handling of copy callback" to the asoc tree
Date: Fri, 26 Jan 2018 15:23:34 +0000
Message-ID: <E1ef5qo-0006Br-0u@debutante>
References: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
Sender: stable-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, alsa-devel@alsa-project.org, ladis@linux-mips.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, lgirdwood@gmail.com, dan.carpenter@oracle.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Correct handling of copy callback

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

>From 290df4d3ab192821b66857c05346b23056ee9545 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 26 Jan 2018 13:08:43 +0000
Subject: [PATCH] ASoC: compress: Correct handling of copy callback

The soc_compr_copy callback is currently broken. Since the
changes to move the compr_ops over to the component the return
value is not correctly propagated, always returning zero on
success rather than the number of bytes copied. This causes
user-space to stall continuously reading as it does not believe
it has received any data.

Furthermore, the changes to move the compr_ops over to the
component iterate through the list of components and will call
the copy callback for any that have compressed ops. There isn't
currently any consensus on the mechanism to combine the results
of multiple copy callbacks.

To fix this issue for now halt searching the component list when
we locate a copy callback and return the result of that single
callback. Additional work should probably be done to look at the
other ops, tidy things up, and work out if we want to support
multiple components on a single compressed, but this is the only
fix required to get things working again.

Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-compress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d9b1e6417fb9..1507117d1185 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -944,7 +944,7 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -965,10 +965,10 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 		    !component->driver->compr_ops->copy)
 			continue;
 
-		__ret = component->driver->compr_ops->copy(cstream, buf, count);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->copy(cstream, buf, count);
+		break;
 	}
+
 err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
-- 
2.15.1
