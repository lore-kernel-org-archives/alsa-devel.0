From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH] ASoC: cs35l35: Add use_single_rw to regmap
	config
Date: Fri, 4 May 2018 16:37:41 -0500
Message-ID: <d4041f11-1d80-47cd-9b06-cc3966d7bacd@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B66266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 23:37:45 +0200 (CEST)
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
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>, brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

Add the use_single_rw flag to regmap config since the
device does not support bulk transactions over i2c.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs35l35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index a4a2cb1..bd6226b 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1105,6 +1105,7 @@ static struct regmap_config cs35l35_regmap = {
 	.readable_reg = cs35l35_readable_register,
 	.precious_reg = cs35l35_precious_register,
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_rw = true,
 };
 
 static irqreturn_t cs35l35_irq(int irq, void *data)
-- 
2.7.4
