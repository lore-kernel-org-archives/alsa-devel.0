From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: fix incorrect widget name" to
	the asoc tree
Date: Tue, 07 Jul 2015 10:09:21 +0100
Message-ID: <E1ZCOsT-0004aL-0K@debutante>
References: <1436217158-58679-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C7E8261A28
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 11:09:30 +0200 (CEST)
In-Reply-To: <1436217158-58679-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fang Yang A <yang.a.fang@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: fix incorrect widget name

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

>From 8bc76c8bf6e5d96985eb05afe1b94699d580eb68 Mon Sep 17 00:00:00 2001
From: "Fang, Yang A" <yang.a.fang@intel.com>
Date: Mon, 6 Jul 2015 14:12:38 -0700
Subject: [PATCH] ASoC: Intel: fix incorrect widget name

We should use "HiFi Playback" and "HiFi Capture".it will fix below err

cht-bsw-max98090: ASoC: no sink widget found for AIF1 Playback
cht-bsw-max98090: ASoC: Failed to add route ssp2 Tx -> direct ->
AIF1 Playback
cht-bsw-max98090: ASoC: no source widget found for AIF1 Capture
cht-bsw-max98090: ASoC: Failed to add route AIF1 Capture -> direct ->
ssp2 Rx

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index d604ee80eda4..70f832114a5a 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -69,12 +69,12 @@ static const struct snd_soc_dapm_route cht_audio_map[] = {
 	{"Headphone", NULL, "HPR"},
 	{"Ext Spk", NULL, "SPKL"},
 	{"Ext Spk", NULL, "SPKR"},
-	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"HiFi Playback", NULL, "ssp2 Tx"},
 	{"ssp2 Tx", NULL, "codec_out0"},
 	{"ssp2 Tx", NULL, "codec_out1"},
 	{"codec_in0", NULL, "ssp2 Rx" },
 	{"codec_in1", NULL, "ssp2 Rx" },
-	{"ssp2 Rx", NULL, "AIF1 Capture"},
+	{"ssp2 Rx", NULL, "HiFi Capture"},
 };
 
 static const struct snd_kcontrol_new cht_mc_controls[] = {
-- 
2.1.4
