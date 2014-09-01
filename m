From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3] ASoC: simple-card: Fix bug of wrong
	decrement DT node's refcount
Date: Mon, 1 Sep 2014 14:46:52 +0800
Message-ID: <1409554012-1427-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 by alsa0.perex.cz (Postfix) with ESMTP id EB7C9261B2D
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 09:38:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, moinejf@free.fr, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

DAI links's cpu_of_node's and codec_of_node's refcounts shouldn't
be decremented immediately at the end of the probe() fucntion.
Because we will still use them before the audio card is removed.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
---

Change in v3:
- Follow Jean-Francois Moine's advice.
- Remove the following patch:
  "ASoC: simple-card: Fix bug of forgetting decrement DT node's refcount"




 sound/soc/generic/simple-card.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fd8b045..986d2c7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -481,12 +481,19 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&priv->snd_card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &priv->snd_card);
+	if (ret >= 0)
+		return ret;
 
 err:
 	asoc_simple_card_unref(pdev);
 	return ret;
 }
 
+static int asoc_simple_card_remove(struct platform_device *pdev)
+{
+	return asoc_simple_card_unref(pdev);
+}
+
 static const struct of_device_id asoc_simple_of_match[] = {
 	{ .compatible = "simple-audio-card", },
 	{},
@@ -500,6 +507,7 @@ static struct platform_driver asoc_simple_card = {
 		.of_match_table = asoc_simple_of_match,
 	},
 	.probe = asoc_simple_card_probe,
+	.remove = asoc_simple_card_remove,
 };
 
 module_platform_driver(asoc_simple_card);
-- 
1.8.4
