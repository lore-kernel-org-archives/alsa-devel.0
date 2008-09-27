From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Fix another cs4270 error path
Date: Sat, 27 Sep 2008 20:30:52 +0200
Message-ID: <20080927203052.2a9ed6a1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D0473103849
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 20:31:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@kernel.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Conversion to new-style i2c driver missed the error path of the
probe function. Fix it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- linux-2.6.27-rc7.orig/sound/soc/codecs/cs4270.c	2008-09-27 17:45:47.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/codecs/cs4270.c	2008-09-27 18:10:52.000000000 +0200
@@ -610,17 +610,12 @@ static int cs4270_i2c_probe(struct i2c_c
 	return 0;
 
 error:
-	if (codec->control_data) {
-		i2c_detach_client(i2c_client);
-		codec->control_data = NULL;
-	}
+	codec->control_data = NULL;
 
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
 	codec->reg_cache_size = 0;
 
-	kfree(i2c_client);
-
 	return ret;
 }
 


-- 
Jean Delvare
