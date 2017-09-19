From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98090: reduce verbosity on PLL
	unlock" to the asoc tree
Date: Tue, 19 Sep 2017 14:45:50 +0100
Message-ID: <E1duIqU-00087E-OU@debutante>
References: <20170908051309.19028-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A9EDB26739D
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:45:54 +0200 (CEST)
In-Reply-To: <20170908051309.19028-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98090: reduce verbosity on PLL unlock

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

>From d10a7d3e2af98e639e74c64185f910915a560f07 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 00:13:03 -0500
Subject: [PATCH] ASoC: max98090: reduce verbosity on PLL unlock

'commit b8a3ee820f7b ("ASoC: max98090: Add recovery for PLL lock failure")'
enabled a workaround PLL unlocked issues, but generates annoying
dev_info "PLL unlocked" messages at a 10ms rate, usually on startup.

Move to dev_info_ratelimited. This issue doesn't seem to impact audio
functionality.  This trace is commented out in the GalliumOS patches,
it's better to keep it to check on potential quality issues

Tested on Lenovo 100s (Baytrail Chromebook)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 13bcfb1ef9b4..f5075d1f79e6 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2115,7 +2115,7 @@ static void max98090_pll_work(struct work_struct *work)
 	if (!snd_soc_codec_is_active(codec))
 		return;
 
-	dev_info(codec->dev, "PLL unlocked\n");
+	dev_info_ratelimited(codec->dev, "PLL unlocked\n");
 
 	/* Toggle shutdown OFF then ON */
 	snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
-- 
2.14.1
