From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add jack port
	initialize in nau88l25_ssm4567 machine" to the asoc tree
Date: Thu, 16 Feb 2017 19:04:09 +0000
Message-ID: <E1ceRLd-0007Sr-8E@debutante>
References: <1484589477-7630-28-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E15A267044
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:17 +0100 (CET)
In-Reply-To: <1484589477-7630-28-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add jack port initialize in nau88l25_ssm4567 machine

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

>From 86b5703158ff39e5efe9480784a7cad1b4baef59 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 7 Feb 2017 19:09:58 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add jack port initialize in
 nau88l25_ssm4567 machine

After the pcm jack is created, create and initialize the pin switch
widget for each port. Pin switch is to enable/disable the pin when
monitor is connected/disconnected.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 5deb68f0c1f0..eb7751b0599b 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -136,9 +136,6 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"DP1", NULL, "hif5-0 Output"},
-	{"DP2", NULL, "hif6-0 Output"},
-
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
@@ -660,10 +657,12 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(card);
 	struct skl_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
@@ -682,7 +681,10 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	return 0;
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
 }
 
 /* skylake audio machine driver for SPT + NAU88L25 */
-- 
2.11.0
