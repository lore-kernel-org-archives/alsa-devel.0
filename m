From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs43130: Fix unused compiler warnings
	for PM runtime" to the asoc tree
Date: Mon, 04 Sep 2017 15:49:38 +0100
Message-ID: <E1dosh0-0006UC-Ln@debutante>
References: <20170904135448.26314-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3877080399091689101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BDD6F26704E
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 16:49:40 +0200 (CEST)
In-Reply-To: <20170904135448.26314-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============3877080399091689101==
Content-Type: text/plain

The patch

   ASoC: cs43130: Fix unused compiler warnings for PM runtime

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

>From 7051334672e54fae67e02d5d3296fb62b3343be7 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 4 Sep 2017 15:54:48 +0200
Subject: [PATCH] ASoC: cs43130: Fix unused compiler warnings for PM runtime
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add __maybe_unused prefix for addressing the following warnings:
  sound/soc/codecs/cs43130.c:2615:12: warning: ‘cs43130_runtime_resume’ defined but not used [-Wunused-function]
  sound/soc/codecs/cs43130.c:2596:12: warning: ‘cs43130_runtime_suspend’ defined but not used [-Wunused-function]

Fixes: 8f1e5bf9b440 ("ASoC: cs43130: Add support for CS43130 codec")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs43130.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 4229a95e2859..643e37fc218e 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2597,7 +2597,7 @@ static int cs43130_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int cs43130_runtime_suspend(struct device *dev)
+static int __maybe_unused cs43130_runtime_suspend(struct device *dev)
 {
 	struct cs43130_private *cs43130 = dev_get_drvdata(dev);
 
@@ -2616,7 +2616,7 @@ static int cs43130_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cs43130_runtime_resume(struct device *dev)
+static int __maybe_unused cs43130_runtime_resume(struct device *dev)
 {
 	struct cs43130_private *cs43130 = dev_get_drvdata(dev);
 	int ret;
-- 
2.14.1


--===============3877080399091689101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3877080399091689101==--
