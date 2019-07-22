From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: pcm3168a: Fix a typo in the name of a constant
Date: Mon, 22 Jul 2019 23:15:28 +0200
Message-ID: <20190722211528.26600-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com, gregkh@linuxfoundation.org, wang@mentor.com, tglx@linutronix.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

There is a typo in PCM1368A_MAX_SYSCLK, it should be PCM3168A_MAX_SYSCLK
(1 and 3 switched in 3168)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/pcm3168a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index ed0b4317c9ae..844602710eee 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -263,7 +263,7 @@ static unsigned int pcm3168a_scki_ratios[] = {
 #define PCM3168A_NUM_SCKI_RATIOS_DAC	ARRAY_SIZE(pcm3168a_scki_ratios)
 #define PCM3168A_NUM_SCKI_RATIOS_ADC	(ARRAY_SIZE(pcm3168a_scki_ratios) - 2)
 
-#define PCM1368A_MAX_SYSCLK		36864000
+#define PCM3168A_MAX_SYSCLK		36864000
 
 static int pcm3168a_reset(struct pcm3168a_priv *pcm3168a)
 {
@@ -296,7 +296,7 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(dai->component);
 	int ret;
 
-	if (freq > PCM1368A_MAX_SYSCLK)
+	if (freq > PCM3168A_MAX_SYSCLK)
 		return -EINVAL;
 
 	ret = clk_set_rate(pcm3168a->scki, freq);
-- 
2.20.1
