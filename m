From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxt: Add jack port initialize in
	bxt_rt298 machine" to the asoc tree
Date: Fri, 17 Feb 2017 13:22:18 +0000
Message-ID: <E1ceiUM-0003or-7l@debutante>
References: <1484589477-7630-29-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0785D2671B4
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 14:22:33 +0100 (CET)
In-Reply-To: <1484589477-7630-29-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxt: Add jack port initialize in bxt_rt298 machine

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

>From 7ba8ba3f4f9604ce776475e3b501e41c762af797 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 17 Feb 2017 15:04:46 +0530
Subject: [PATCH] ASoC: Intel: bxt: Add jack port initialize in bxt_rt298
 machine

After the pcm jack is created, create and initialize the pin switch
widget for each port. Pin switch is to enable/disable the pin when
monitor is connected/disconnected.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index d5f53a6de041..176c080a9818 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -459,10 +459,12 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 {
 	struct bxt_rt286_private *ctx = snd_soc_card_get_drvdata(card);
 	struct bxt_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
@@ -480,7 +482,10 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	return 0;
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
 }
 
 
-- 
2.11.0
