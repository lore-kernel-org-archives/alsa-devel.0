From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: byt: Introduce new map for dual
	mics" to the asoc tree
Date: Wed, 29 Nov 2017 18:59:52 +0000
Message-ID: <E1eK7aK-0004ey-6D@debutante>
References: <20171121171546.5656-2-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 79F3C26791E
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 19:59:56 +0100 (CET)
In-Reply-To: <20171121171546.5656-2-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: byt: Introduce new map for dual mics

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

>From ea261bd02a671e2dd60380053dddffedab81644d Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Tue, 21 Nov 2017 17:15:45 +0000
Subject: [PATCH] ASoC: intel: byt: Introduce new map for dual mics

The RT5651 codec has 3 analog inputs. Some laptops have two different
internal analog microphones on the external case.
Add a new custom quirk mapping the two internal mics on IN1P / IN2P,
leaving the headset mic on IN3P.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index d955836c6870..e3d5e6ea707f 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -38,6 +38,7 @@ enum {
 	BYT_RT5651_DMIC_MAP,
 	BYT_RT5651_IN1_MAP,
 	BYT_RT5651_IN2_MAP,
+	BYT_RT5651_IN1_IN2_MAP,
 };
 
 #define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
@@ -171,6 +172,13 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
 	{"IN2P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
+};
+
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -281,6 +289,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
 		break;
+	case BYT_RT5651_IN1_IN2_MAP:
+		custom_map = byt_rt5651_intmic_in1_in2_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
+		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
-- 
2.15.0
