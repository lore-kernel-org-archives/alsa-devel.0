From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix jack name format substitution" to the asoc tree
Date: Thu, 28 Sep 2017 19:58:43 +0100 (BST)
Message-ID: <20170928185843.E4297440056@finisterre.ee.mobilebroadband>
References: <1505749403-31346-1-git-send-email-chintan.m.patel@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505749403-31346-1-git-send-email-chintan.m.patel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Patel <chintan.m.patel@intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hsin-yu Chao <hychao@google.com>, harshapriya.n@intel.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix jack name format substitution

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

>From d1c4cb447a7efcb5608a33cdfed8ab4234378b0a Mon Sep 17 00:00:00 2001
From: Chintan Patel <chintan.m.patel@intel.com>
Date: Mon, 18 Sep 2017 08:43:18 -0700
Subject: [PATCH] ASoC: Intel: Skylake: Fix jack name format substitution

Jack name is not getting formatted correctly hence resulting
in invalid name for HDMI/DP input devices.

This was recently exposed due changes brought by MST:
commit 3a13347f05fd ("ASoC: Intel: kbl: Add jack port initialize
in kbl machine drivers")

Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 88ff54220007..9cd0769ccd34 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -604,6 +604,8 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		codec = pcm->codec_dai->codec;
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
 				NULL, 0);
-- 
2.14.1
