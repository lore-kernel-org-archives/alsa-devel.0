From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs35l32: fix compile warning for
	i2c_probe
Date: Thu, 7 Aug 2014 09:34:38 -0500
Message-ID: <1407422078-3683-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 0353E2650E4
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 16:30:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <briann.austin@cirrus.com>, Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Forgot to add a return for err_disable goto statement.
Causes compile warning of control reaching end of non-void

Signed-off-by: Brian Austin <briann.austin@cirrus.com>
---
 sound/soc/codecs/cs35l32.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 90565d5..9c6b272 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -549,6 +549,7 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 err_disable:
 	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
 			       cs35l32->supplies);
+	return ret;
 }
 
 static int cs35l32_i2c_remove(struct i2c_client *i2c_client)
-- 
1.7.9.5
