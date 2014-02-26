From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 09/10] ASoC: fsl: eukrea-tlv320: Use snd_soc_dai_set_tdm_slot_xlate()
Date: Wed, 26 Feb 2014 11:59:34 +0800
Message-ID: <1393387175-15539-10-git-send-email-Li.Xiubo@freescale.com>
References: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: timur@tabi.org, tiwai@suse.de, lars@metafoo.de, Guangyu.Chen@freescale.com, fabio.estevam@freescale.com, shawn.guo@linaro.org, denis@eukrea.com, mpa@pengutronix.de, s.hauer@pengutronix.de, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_dai_set_tdm_slot_xlate instead of snd_soc_dai_set_tdm_slot.
This will use the default snd_soc_of_xlate_tdm_slot_mask to generate
the TDM slot TX/RX mask using the slot parameter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/eukrea-tlv320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 5983740..3965023 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -63,7 +63,7 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 			"Failed to set the codec sysclk.\n");
 		return ret;
 	}
-	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
+	snd_soc_dai_set_tdm_slot_xlate(cpu_dai, 2, 0);
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
 				SND_SOC_CLOCK_IN);
-- 
1.8.4
