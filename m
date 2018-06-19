From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl_da7219_max98357a: add fe_ops
	for kbl Audio Capture Port" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:46 +0100
Message-ID: <E1fVIUw-0002SD-EO@debutante>
References: <1529388966-5184-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 75AA72676E3
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:54 +0200 (CEST)
In-Reply-To: <1529388966-5184-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, mac.chiang@intel.com, broonie@kernel.org, louiscollard@google.com, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl_da7219_max98357a: add fe_ops for kbl Audio Capture Port

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

>From 5fd46e649ee63259f2197625662477ac67a69e79 Mon Sep 17 00:00:00 2001
From: Mac Chiang <mac.chiang@intel.com>
Date: Tue, 19 Jun 2018 14:16:06 +0800
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98357a: add fe_ops for kbl Audio
 Capture Port

platform support fixed constraint hw_prams as Stereo, 48KHz, 16 bits.
This fixed the headset mic recorded noise due to mono capturing
request from some apps. e.g. online Voice Recorder

Signed-off-by: Louis Collard <louiscollard@google.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 94294c27d1db..7961f1fd18bd 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -380,6 +380,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
+		.ops = &kabylake_da7219_fe_ops,
 	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
-- 
2.17.1
