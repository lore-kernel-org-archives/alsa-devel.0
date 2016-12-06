From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: update bxt_da7219_max98357a to
	support quad ch dmic capture" to the asoc tree
Date: Tue, 06 Dec 2016 15:13:52 +0000
Message-ID: <E1cEHRI-0004is-EO@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 260FF26704B
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 16:14:06 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: Harsha Priya <harshapriya.n@intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: update bxt_da7219_max98357a to support quad ch dmic capture

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

>From c1aee1d828caa86a663c57a56eead7fd5f22d80f Mon Sep 17 00:00:00 2001
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Date: Tue, 6 Dec 2016 07:08:36 -0800
Subject: [PATCH] ASoC: Intel: update bxt_da7219_max98357a to support quad ch
 dmic capture

This patch updates FE channel constraints & BE fixup to support
quad channel DMIC capture.
DMIC pin's BE fixup is configured based on channel input, i.e.
either stereo or quad.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index bff80b467262..3a8c24a59020 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -30,6 +30,7 @@
 #define BXT_DIALOG_CODEC_DAI	"da7219-hifi"
 #define BXT_MAXIM_CODEC_DAI	"HiFi"
 #define DUAL_CHANNEL		2
+#define QUAD_CHANNEL		4
 
 static struct snd_soc_jack broxton_headset;
 
@@ -182,6 +183,16 @@ static struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
+static unsigned int channels_quad[] = {
+	QUAD_CHANNEL,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_channels_quad = {
+	.count = ARRAY_SIZE(channels_quad),
+	.list = channels_quad,
+	.mask = 0,
+};
+
 static int bxt_fe_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -258,7 +269,10 @@ static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	channels->min = channels->max = DUAL_CHANNEL;
+	if (params_channels(params) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
 
 	return 0;
 }
@@ -267,9 +281,9 @@ static int broxton_dmic_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->hw.channels_max = DUAL_CHANNEL;
+	runtime->hw.channels_min = runtime->hw.channels_max = QUAD_CHANNEL;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			&constraints_channels);
+			&constraints_channels_quad);
 
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
-- 
2.10.2
