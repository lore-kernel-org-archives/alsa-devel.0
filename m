From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 31/32] ASoC: Intel: bytcr_rt5651: Change
	defaults to enable jack-detect, analog mics
Date: Sun, 25 Feb 2018 11:47:12 +0100
Message-ID: <20180225104713.4745-32-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1604526796D
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:48:01 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/intel/boards/bytcr_rt5651.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e395c9c179a1..c695247341f3 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -84,7 +84,12 @@ struct byt_rt5651_private {
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
@@ -791,14 +796,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
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
2.14.3
