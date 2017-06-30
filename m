From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: twl6040: fix error return code in
	twl6040_probe()
Date: Fri, 30 Jun 2017 17:26:48 -0500
Message-ID: <20170630222648.GA19310@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F6DE267574
 for <alsa-devel@alsa-project.org>; Sat,  1 Jul 2017 00:26:50 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 9640B2EAAC5
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 17:26:49 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

platform_get_irq() returns an error code, but the twl6040
driver ignores it and always returns -EINVAL. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.
Notice that platform_get_irq() no longer returns 0 on error.

Print and propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 2b6ad09..96cf94a 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1123,8 +1123,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 	priv->plug_irq = platform_get_irq(pdev, 0);
 	if (priv->plug_irq < 0) {
-		dev_err(codec->dev, "invalid irq\n");
-		return -EINVAL;
+		dev_err(codec->dev, "invalid irq: %d\n", priv->plug_irq);
+		return priv->plug_irq;
 	}
 
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
-- 
2.5.0
