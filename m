From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: cs42l51: Don't log if we fail to
	allocate memory
Date: Tue, 11 Feb 2014 19:26:47 +0000
Message-ID: <1392146808-19269-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93DDD2607BB
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 20:27:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The VM subsystem already logs quite loudly if we run out of memory so
don't bother here.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/cs42l51.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 6e9ea8379a91..50c08c8fc9bc 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -574,10 +574,8 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
 
 	cs42l51 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l51_private),
 			       GFP_KERNEL);
-	if (!cs42l51) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
+	if (!cs42l51)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(i2c_client, cs42l51);
 	cs42l51->control_type = SND_SOC_I2C;
-- 
1.9.0.rc3
