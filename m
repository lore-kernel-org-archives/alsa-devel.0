From: Chintan Patel <chintan.m.patel@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix jack name format substitution
Date: Mon, 18 Sep 2017 08:43:18 -0700
Message-ID: <1505749403-31346-1-git-send-email-chintan.m.patel@intel.com>
References: <y>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <y>
Sender: linux-kernel-owner@vger.kernel.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, Chintan Patel <chintan.m.patel@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, Hsin-yu Chao <hychao@google.com>, Jeeja KP <jeeja.kp@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Jack name is not getting formatted correctly hence resulting
in invalid name for HDMI/DP input devices.

This was recently exposed due changes brought by MST:
commit 3a13347f05fd ("ASoC: Intel: kbl: Add jack port initialize
in kbl machine drivers")

Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 4689991bcc86..c127b7b0ee3f 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -611,6 +611,8 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		codec = pcm->codec_dai->codec;
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
 				NULL, 0);
-- 
1.9.1
