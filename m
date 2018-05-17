From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Add default
	jack-detect settings" to the asoc tree
Date: Thu, 17 May 2018 17:39:02 +0100 (BST)
Message-ID: <20180517163902.857D644007E@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-16-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 926A0267681
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:39:05 +0200 (CEST)
In-Reply-To: <20180508153604.23711-16-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5640: Add default jack-detect settings

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

>From 56ff44094501787e5901669d6e880ca2065206fe Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:31 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add default jack-detect settings

Out of the 11 BYTCR devices which I have access to for testing, 6 use
JD1IN4P for jack-detect, 2 use JD1IN4P non-inverted and the other 3 use
JD2IN4N, the ones not using JD1IN4P are all also special in other ways and
need a DMI quirk regardless.

All 5 BYT (non CR) devices which I have access to use JD2IN4N.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 355c241470b5..b00f21ed4357 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -84,6 +84,9 @@ enum {
 
 #define BYTCR_INPUT_DEFAULTS				\
 	(BYT_RT5640_IN3_MAP |				\
+	 BYT_RT5640_JD_SRC_JD1_IN4P |			\
+	 BYT_RT5640_OVCD_TH_2000UA |			\
+	 BYT_RT5640_OVCD_SF_0P75 |			\
 	 BYT_RT5640_DIFF_MIC)
 
 /* in-diff or dmic-pin + jdsrc + ovcd-th + -sf + jd-inv + terminating entry */
@@ -985,7 +988,10 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		/* change defaults for Baytrail-CR capture */
 		byt_rt5640_quirk |= BYTCR_INPUT_DEFAULTS;
 	} else {
-		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
+		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP |
+				    BYT_RT5640_JD_SRC_JD2_IN4N |
+				    BYT_RT5640_OVCD_TH_2000UA |
+				    BYT_RT5640_OVCD_SF_0P75;
 	}
 
 	/* check quirks before creating card */
-- 
2.17.0
