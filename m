From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: adau1701: Add adau1702 and
	adau1401(a) device ids
Date: Mon, 22 Jul 2013 18:49:53 +0200
Message-ID: <1374511793-32187-2-git-send-email-lars@metafoo.de>
References: <1374511793-32187-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-057.synserver.de (smtp-out-057.synserver.de
 [212.40.185.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 39258261A78
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 18:49:10 +0200 (CEST)
In-Reply-To: <1374511793-32187-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Both the adau1702 and the adau1401(a) are register compatible to the adau1701,
so add them to adau1701 driver's device id table.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1701.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index d1124a5..44d8a95 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -734,7 +734,10 @@ static int adau1701_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adau1701_i2c_id[] = {
+	{ "adau1401", 0 },
+	{ "adau1401a", 0 },
 	{ "adau1701", 0 },
+	{ "adau1702", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adau1701_i2c_id);
-- 
1.8.0
