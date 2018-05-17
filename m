From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Change BYTCR
	default input to IN3" to the asoc tree
Date: Thu, 17 May 2018 17:39:10 +0100 (BST)
Message-ID: <20180517163910.36DE044007E@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 86A7D2671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:39:13 +0200 (CEST)
In-Reply-To: <20180508153604.23711-14-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Change BYTCR default input to IN3

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

>From 737c14641a411b2a6bea61203c4aecb62de35d72 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:29 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Change BYTCR default input to IN3

Out of the 11 BYTCR devices which I have access to for testing,
7 use IN3 for the internal mic and only 1 uses IN1 for the internal mic,
the other 3 use DMIC1.

So IN3 clearly is a better default, using IN3 as default avoids the need
to add DMI quirks for some of these devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 3cdaf87480ef..09cdfd57e383 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -979,7 +979,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 
 		/* change defaults for Baytrail-CR capture */
-		byt_rt5640_quirk |= BYT_RT5640_IN1_MAP;
+		byt_rt5640_quirk |= BYT_RT5640_IN3_MAP;
 		byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
 	} else {
 		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
-- 
2.17.0
