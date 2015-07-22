From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs4349: Fix up setting PWR_DWN bit
Date: Wed, 22 Jul 2015 10:22:33 +0800
Message-ID: <1437531753.3325.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4142605FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 04:22:40 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so132550976pdj.3
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 19:22:39 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The PWR_DWN is Bit 7, so current code does not set the PWR_DWN bit. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4349.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 852be85..0d010c2 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -326,7 +326,7 @@ static int cs4349_runtime_suspend(struct device *dev)
 	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
 	int ret;
 
-	ret = regmap_update_bits(cs4349->regmap, CS4349_MISC, PWR_DWN, 1);
+	ret = regmap_update_bits(cs4349->regmap, CS4349_MISC, PWR_DWN, PWR_DWN);
 	if (ret < 0)
 		return ret;
 
-- 
2.1.0
