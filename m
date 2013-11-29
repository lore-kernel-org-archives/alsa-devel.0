From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: cs42l52: Fix build
Date: Fri, 29 Nov 2013 11:42:18 +0000
Message-ID: <1385725338-18271-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 406BB26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 12:42:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/cs42l52.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 4a47a634f376..0bac6d5a4ac8 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1232,7 +1232,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 
 			if (of_property_read_u32(i2c_client->dev.of_node,
 				"cirrus,chgfreq-divisor", &val32) >= 0)
-				pdata->chgfreq_divisor = val32;
+				pdata->chgfreq = val32;
 
 			pdata->reset_gpio =
 				of_get_named_gpio(i2c_client->dev.of_node,
-- 
1.8.4.4
