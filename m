From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 32/32] ASoC: Intel: bytcr_rt5651: Select
	RCCLK on init()
Date: Sun, 25 Feb 2018 11:47:13 +0100
Message-ID: <20180225104713.4745-33-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 684FC267972
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:48:02 +0100 (CET)
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

When the BYT_RT5651_MCLK_EN quirk is set, we disable the MCLK from
byt_rt5651_init(), we need to select the RCCLK as sysclk before doing this
to make sure that jack-detect works directly after boot.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c695247341f3..ceb3858a0e41 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -425,6 +425,11 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
+	/* Start with RC clk for jack-detect (we disable MCLK below) */
+	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
+		snd_soc_component_update_bits(codec, RT5651_GLB_CLK,
+			RT5651_SCLK_SRC_MASK, RT5651_SCLK_SRC_RCCLK);
+
 	switch (BYT_RT5651_MAP(byt_rt5651_quirk)) {
 	case BYT_RT5651_IN1_MAP:
 		custom_map = byt_rt5651_intmic_in1_map;
-- 
2.14.3
