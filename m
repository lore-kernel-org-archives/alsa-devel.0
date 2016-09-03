From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: fix to spelling mistake: "susupend" -> "suspend"" to the asoc tree
Date: Sat, 03 Sep 2016 12:08:40 +0100
Message-ID: <E1bg8oS-0003e8-IA@finisterre>
References: <20160902084525.8646-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160902084525.8646-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: fix to spelling mistake: "susupend" -> "suspend"

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

>From 0fd67cee29cef1942865bd4375b8a7e5d98343ad Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 2 Sep 2016 09:45:25 +0100
Subject: [PATCH] ASoC: Intel: sst: fix to spelling mistake: "susupend" ->
 "suspend"

trivial fix to spelling mistake in dev_err message and replace "cant"
with "can't"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 498b5f7fba4c..9b6e27385dc9 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -442,7 +442,7 @@ static int intel_sst_suspend(struct device *dev)
 		struct stream_info *stream = &ctx->streams[i];
 
 		if (stream->status == STREAM_RUNNING) {
-			dev_err(dev, "stream %d is running, cant susupend, abort\n", i);
+			dev_err(dev, "stream %d is running, can't suspend, abort\n", i);
 			return -EBUSY;
 		}
 	}
-- 
2.9.3
