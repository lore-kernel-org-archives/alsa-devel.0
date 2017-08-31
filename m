From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ALSA: ac97c: Fix an error handling path in
	'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 06:40:42 +0200
Message-ID: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 159DD26723F
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 06:41:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, arvind.yadav.cs@gmail.com, nicolas.ferre@microchip.com, broonie@kernel.org, garsilva@embeddedor.com, andriy.shevchenko@linux.intel.com, bhumirks@gmail.com
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If 'clk_prepare_enable()' fails, we must release some resources before
returning. Add a new label in the existing error handling path and 'goto'
there.

Fixes: 260ea95cc027 ("ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/atmel/ac97c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 30c64ab210d9..5ffefac2fa8f 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -785,7 +785,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 	}
 	retval = clk_prepare_enable(pclk);
 	if (retval)
-		return retval;
+		goto err_prepare_enable;
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -881,6 +881,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 	snd_card_free(card);
 err_snd_card_new:
 	clk_disable_unprepare(pclk);
+err_prepare_enable:
 	clk_put(pclk);
 	return retval;
 }
-- 
2.11.0
