From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH v2 1/4] ASoC: tas571x: extend the t_i2c time to
	comply with TAS5721
Date: Wed,  5 Oct 2016 15:51:04 +0200
Message-ID: <1475675467-5575-2-git-send-email-brain@jikos.cz>
References: <1475675467-5575-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep23.mx.upcmail.net (fep23.mx.upcmail.net [62.179.121.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B48382665C3
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 15:51:21 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep23-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20161005135121.LSRI12996.viefep23-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Wed, 5 Oct 2016 15:51:21 +0200
In-Reply-To: <1475675467-5575-1-git-send-email-brain@jikos.cz>
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
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

TAS5721 datasheet recommends to wait at least 13.5ms after deasserting the
RESET signal. For TAS5717 this time is only 12ms, which was the original
value in the code.

Extend the wait time after deasserting RESET from 12 to 13.5ms to comply
with the TAS5721 specification.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index e996313..4d61357 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -748,7 +748,7 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 		/* pulse the active low reset line for ~100us */
 		usleep_range(100, 200);
 		gpiod_set_value(priv->reset_gpio, 0);
-		usleep_range(12000, 20000);
+		usleep_range(13500, 20000);
 	}
 
 	ret = regmap_write(priv->regmap, TAS571X_OSC_TRIM_REG, 0);
-- 
2.7.4
