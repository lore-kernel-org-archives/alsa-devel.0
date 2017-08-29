From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Add jack port initialize in
	kbl machine drivers" to the asoc tree
Date: Tue, 29 Aug 2017 20:29:50 +0100 (BST)
Message-ID: <20170829192950.20DEF4400E7@finisterre.ee.mobilebroadband>
References: <1503700450-7964-3-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 537A8267048
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:29:52 +0200 (CEST)
In-Reply-To: <1503700450-7964-3-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Add jack port initialize in kbl machine drivers

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

>From 3a13347f05fdba9d889891245f154816197868f4 Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Sat, 26 Aug 2017 04:04:10 +0530
Subject: [PATCH] ASoC: Intel: kbl: Add jack port initialize in kbl machine
 drivers

After the pcm jack is created, create and initialize the pin switch
widget for each port. For hdmi audio, invoke hdac_hdmi_jack_port_init
func() in rt5663_max98927 & rt5663_rt5514_max98927 to enable the pin,
when monitor is connected.

Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 7 ++++++-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 941480c3e906..3fa85c32b9f8 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -767,10 +767,12 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct kbl_rt5663_private *ctx = snd_soc_card_get_drvdata(card);
 	struct kbl_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
@@ -788,7 +790,10 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	return 0;
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
 }
 
 /* kabylake audio machine driver for SPT + RT5663 */
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index d042255235c1..11bd5ef1e3b2 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -600,10 +600,12 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
 	struct kbl_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
 		err = snd_soc_card_jack_new(card, jack_name,
 				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
 				NULL, 0);
@@ -617,7 +619,10 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	return 0;
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
 }
 
 /*
-- 
2.13.2
