From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: kbl: fix jack name
Date: Tue, 31 Oct 2017 16:47:27 +0530
Message-ID: <1509448647-5182-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B022670B6
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:14:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Commit d1c4cb447a7e ("ASoC: Intel: Skylake: Fix jack name format
substitution") added Jack name but erroneously added a space as well,
so remove the space in Jack name.

Fixes: d1c4cb447a7e ("ASoC: Intel: Skylake: Fix jack name format substitution")
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 9cd0769ccd34..69ab55956492 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -605,7 +605,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
-			"HDMI/DP, pcm=%d Jack", pcm->device);
+			"HDMI/DP,pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
 				NULL, 0);
-- 
2.7.4
