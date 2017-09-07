From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ASoC: tas571x: Kill BUG_ON() usage
Date: Thu,  7 Sep 2017 10:59:16 +0200
Message-ID: <20170907085918.4496-2-tiwai@suse.de>
References: <20170907085918.4496-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 014952674B5
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 10:59:29 +0200 (CEST)
In-Reply-To: <20170907085918.4496-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Don't use BUG_ON() for a non-critical sanity check on production
systems.  This patch replaces with a softer WARN_ON() and an error
path.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/tas571x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 810369f687d7..a09499977be4 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -697,7 +697,8 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(priv->mclk);
 	}
 
-	BUG_ON(priv->chip->num_supply_names > TAS571X_MAX_SUPPLIES);
+	if (WARN_ON(priv->chip->num_supply_names > TAS571X_MAX_SUPPLIES))
+		return -EINVAL;
 	for (i = 0; i < priv->chip->num_supply_names; i++)
 		priv->supplies[i].supply = priv->chip->supply_names[i];
 
-- 
2.14.1
