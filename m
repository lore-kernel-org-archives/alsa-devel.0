From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: add a dapm sink widget" to the
	asoc tree
Date: Wed, 25 Nov 2015 12:59:59 +0000
Message-ID: <E1a1Zfz-0002nX-CZ@debutante>
References: <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9265A261548
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:08 +0100 (CET)
In-Reply-To: <1448293951-32071-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: add a dapm sink widget

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

>From 56b4437f15ed2003413b857e08740576332e72d7 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 23 Nov 2015 21:22:30 +0530
Subject: [PATCH] ASoC: dapm: add a dapm sink widget

DAPM models various widgets but lacks a sink widget.
DSPs can have modules which take audio data, process it and are
capable of generating events thus acting as a sink of data.

To make the dapm graph complete for such paths we need a dapm
sink widget for these modules, so add a SND_SOC_DAPM_SINK to
declare such a widget.  This widget will be treated as
SND_SOC_DAPM_EP_SINK endpoint in the dapm graph

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 4 ++++
 sound/soc/soc-dapm.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7855cfe46b69..fe19dd3abb00 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -49,6 +49,9 @@ struct device;
 #define SND_SOC_DAPM_SIGGEN(wname) \
 {	.id = snd_soc_dapm_siggen, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
+#define SND_SOC_DAPM_SINK(wname) \
+{	.id = snd_soc_dapm_sink, .name = wname, .kcontrol_news = NULL, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_INPUT(wname) \
 {	.id = snd_soc_dapm_input, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
@@ -484,6 +487,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
+	snd_soc_dapm_sink,
 	snd_soc_dapm_dai_in,		/* link to DAI structure */
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 016eba10b1ec..6760044f6aae 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3351,6 +3351,11 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->is_ep = SND_SOC_DAPM_EP_SOURCE;
 		w->power_check = dapm_always_on_check_power;
 		break;
+	case snd_soc_dapm_sink:
+		w->is_ep = SND_SOC_DAPM_EP_SINK;
+		w->power_check = dapm_always_on_check_power;
+		break;
+
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_demux:
 	case snd_soc_dapm_switch:
-- 
2.6.2
