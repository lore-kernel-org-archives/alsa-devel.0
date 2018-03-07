From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Change defaults to
	enable jack-detect, analog mics" to the asoc tree
Date: Wed, 07 Mar 2018 14:21:48 +0000
Message-ID: <E1etZwy-0002gW-TM@debutante>
References: <20180225104713.4745-32-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6960A267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:21:54 +0100 (CET)
In-Reply-To: <20180225104713.4745-32-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Change defaults to enable jack-detect, analog mics

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

>From b4b6377e07727df8292539062d9a56e6bd83ba89 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:09 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Change defaults to enable
 jack-detect, analog mics

Change the default quirk settings to enable jack-detect, analog mics.

The old default input mapping of DMIC for non Bay Trail CR devices seems
like a poor default as I'm not aware of any Intel SST + rt5651 using
devices with a DMIC.

All Cherry Trail devices using the bytcr_rt5651 machine driver seem to be
modelled after BYT-CR devices, And the only non CR Bay Trail devices with
a rt5651 codec I'm aware of are the Minnow boards for which we already have
board specific quirks. So it seems better to me to use the BYT-CR defaults
everywhere.

This e.g. makes the Chuwi Hi8 Pro (CWI513) work ootb without needing a
quirk.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index d5a3d48294d2..6efd7c9e7407 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -85,7 +85,12 @@ struct byt_rt5651_private {
 	struct snd_soc_jack jack;
 };
 
-static unsigned long byt_rt5651_quirk = BYT_RT5651_MCLK_EN;
+/* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
+static unsigned long byt_rt5651_quirk = BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_0P75 |
+					BYT_RT5651_IN2_HS_IN3_MAP;
 
 static void log_quirks(struct device *dev)
 {
@@ -809,14 +814,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 			/* no BIOS indications, assume SSP0-AIF2 connection */
 			byt_rt5651_quirk |= BYT_RT5651_SSP0_AIF2;
 		}
-
-		/* change defaults for Baytrail-CR capture */
-		byt_rt5651_quirk |= BYT_RT5651_JD1_1 |
-				    BYT_RT5651_OVCD_TH_2000UA |
-				    BYT_RT5651_OVCD_SF_0P75 |
-				    BYT_RT5651_IN2_HS_IN3_MAP;
-	} else {
-		byt_rt5651_quirk |= BYT_RT5651_DMIC_MAP;
 	}
 
 	/* check quirks before creating card */
-- 
2.16.2
