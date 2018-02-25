From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 26/32] ASoC: Intel: bytcr_rt5651: Drop
	snd_soc_dai_set_bclk_ratio() call
Date: Sun, 25 Feb 2018 11:47:07 +0100
Message-ID: <20180225104713.4745-27-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D462674EC
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:54 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Drop the snd_soc_dai_set_bclk_ratio() call, the rt5651 dai does not have a
set_bclk_ratio() op, so it is a nop (and returns -EINVAL).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 28219945912a..0c024e38cf47 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -283,8 +283,6 @@ static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int rate = params_rate(params);
 
-	snd_soc_dai_set_bclk_ratio(codec_dai, 50);
-
 	return byt_rt5651_prepare_and_enable_pll1(codec_dai, rate, 50);
 }
 
-- 
2.14.3
