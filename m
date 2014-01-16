From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2] ASoC: simple-card: Add snd_card's name
	parsing from DT node support
Date: Thu, 16 Jan 2014 14:17:39 +0800
Message-ID: <1389853059-2467-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E85A2608E8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 08:15:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, rientjes@google.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

If the DT is used and the CPU DAI device has only one DAI, the card
name will be like :

ALSA device list:
	0: 40031000.sai-sgtl5000

And this name maybe a little ugly to some customers, so here the
card name parsing from DT node is supported.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---



Resend this patch.



 sound/soc/generic/simple-card.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d437c80..711d6a1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -152,6 +152,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			return ret;
 	}
 
+	/* parsing the card name from DT */
+	snd_soc_of_parse_card_name(&info->snd_card,
+					"simple-audio-card,name");
+
 	/* CPU sub-node */
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
@@ -266,7 +270,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	/*
 	 * init snd_soc_card
 	 */
-	cinfo->snd_card.name		= cinfo->card;
+	if (!cinfo->snd_card.name)
+		cinfo->snd_card.name = cinfo->card;
 	cinfo->snd_card.owner		= THIS_MODULE;
 	cinfo->snd_card.dai_link	= &cinfo->snd_link;
 	cinfo->snd_card.num_links	= 1;
-- 
1.8.4
