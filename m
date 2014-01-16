From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Add snd_card's name parsing
	from DT node support
Date: Thu, 16 Jan 2014 12:00:01 +0800
Message-ID: <1389844801-29309-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1860E265050
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 05:58:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
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
 sound/soc/generic/simple-card   | 0
 sound/soc/generic/simple-card.  | 0
 sound/soc/generic/simple-card.c | 7 ++++++-
 3 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/generic/simple-card
 create mode 100644 sound/soc/generic/simple-card.

diff --git a/sound/soc/generic/simple-card b/sound/soc/generic/simple-card
new file mode 100644
index 0000000..e69de29
diff --git a/sound/soc/generic/simple-card. b/sound/soc/generic/simple-card.
new file mode 100644
index 0000000..e69de29
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 0e2fbdd..b40b57c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -143,6 +143,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			return ret;
 	}
 
+	/* parsing the card name from DT */
+	snd_soc_of_parse_card_name(&info->snd_card,
+					"simple-audio-card,name");
+
 	/* CPU sub-node */
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
@@ -257,7 +261,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
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
