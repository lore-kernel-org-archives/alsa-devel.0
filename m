From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH Resend 4/8] ASoC: simple-card: Add snd_card's name parsing from DT node support
Date: Thu, 23 Jan 2014 13:02:46 +0800
Message-ID: <1390453370-29194-5-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

If the DT is used and the CPU DAI device has only one DAI, the card
name will be like :

ALSA device list:
0: 40031000.sai-sgtl5000

And this name maybe a little ugly to some customers, so here the
card name parsing from DT node is supported.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index f38e56e..546b93d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -140,6 +140,9 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	char *name;
 	int ret;
 
+	/* parsing the card name from DT */
+	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
+
 	/* get CPU/CODEC common format via simple-audio-card,format */
 	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
@@ -184,7 +187,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			    GFP_KERNEL);
 	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
 				dai_link->codec_dai_name);
-	priv->snd_card.name = name;
+	if (!priv->snd_card.name)
+		priv->snd_card.name = name;
 	dai_link->name = dai_link->stream_name = name;
 
 	/* simple-card assumes platform == cpu */
-- 
1.8.4
