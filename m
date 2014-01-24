From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 3/7] ASoC: simple-card: Add snd_card's name
	parsing from DT node support
Date: Fri, 24 Jan 2014 15:43:02 +0800
Message-ID: <1390549386-4702-4-git-send-email-Li.Xiubo@freescale.com>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 58F992616FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 09:44:15 +0100 (CET)
In-Reply-To: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>, rob@landley.net
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
index 65833fe..0890fcd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -143,6 +143,9 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	char *name;
 	int ret;
 
+	/* parsing the card name from DT */
+	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
+
 	/* get CPU/CODEC common format via simple-audio-card,format */
 	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
@@ -187,7 +190,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
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
