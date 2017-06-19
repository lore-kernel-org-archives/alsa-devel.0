From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: skl_rt286: Add deepbuffer dai link" to
	the asoc tree
Date: Mon, 19 Jun 2017 17:23:55 +0100
Message-ID: <E1dMzT1-0002Og-Ba@debutante>
References: <1497267657-20359-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07540267131
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 18:24:08 +0200 (CEST)
In-Reply-To: <1497267657-20359-4-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: skl_rt286: Add deepbuffer dai link

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

>From 1f0f8bde45a7ea843bb2e7a8f45f255b23cdc2e7 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 19 Jun 2017 11:59:21 +0530
Subject: [PATCH] ASoC: skl_rt286: Add deepbuffer dai link

This patch adds the deepbuffer device which can be opened with a bigger
buffer size. The application can disable interrupts and sleep for longer
duration.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index e08c71625fd0..2bc4cfca594e 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -43,6 +43,7 @@ struct skl_rt286_private {
 
 enum {
 	SKL_DPCM_AUDIO_PB = 0,
+	SKL_DPCM_AUDIO_DB_PB,
 	SKL_DPCM_AUDIO_CP,
 	SKL_DPCM_AUDIO_REF_CP,
 	SKL_DPCM_AUDIO_DMIC_CP,
@@ -310,6 +311,23 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &skylake_rt286_fe_ops,
 	},
+	[SKL_DPCM_AUDIO_DB_PB] = {
+		.name = "Skl Deepbuffer Port",
+		.stream_name = "Deep Buffer Audio",
+		.cpu_dai_name = "Deepbuffer Pin",
+		.platform_name = "0000:00:1f.3",
+		.nonatomic = 1,
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST
+		},
+		.dpcm_playback = 1,
+		.ops = &skylake_rt286_fe_ops,
+
+	},
 	[SKL_DPCM_AUDIO_CP] = {
 		.name = "Skl Audio Capture Port",
 		.stream_name = "Audio Record",
-- 
2.11.0
