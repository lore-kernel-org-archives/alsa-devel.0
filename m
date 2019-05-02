From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: fix kcontrols for effect widgets"
	to the asoc tree
Date: Thu,  2 May 2019 03:18:04 +0100 (BST)
Message-ID: <20190502021804.22810441D3B@finisterre.ee.mobilebroadband>
References: <20190430231134.4471-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 706EEF8971A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:18:10 +0200 (CEST)
In-Reply-To: <20190430231134.4471-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: fix kcontrols for effect widgets

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 882c8b4af315bf921431142c1e9f5f69df99da34 Mon Sep 17 00:00:00 2001
From: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Date: Tue, 30 Apr 2019 18:11:34 -0500
Subject: [PATCH] ASoC: dapm: fix kcontrols for effect widgets

This patch adds the handling of snd_soc_dapm_effect that was missing.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0382a47b30bd..29cdfbf4c888 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -883,6 +883,7 @@ static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 			case snd_soc_dapm_switch:
 			case snd_soc_dapm_mixer:
 			case snd_soc_dapm_pga:
+			case snd_soc_dapm_effect:
 			case snd_soc_dapm_out_drv:
 				wname_in_long_name = true;
 				kcname_in_long_name = true;
@@ -2370,6 +2371,7 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 		case snd_soc_dapm_dac:
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
+		case snd_soc_dapm_effect:
 		case snd_soc_dapm_out_drv:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
@@ -3197,6 +3199,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_pga:
+		case snd_soc_dapm_effect:
 		case snd_soc_dapm_out_drv:
 			dapm_new_pga(w);
 			break;
-- 
2.20.1
