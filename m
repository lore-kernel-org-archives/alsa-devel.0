From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs4271: Remove unnecessary additional
	variable definition
Date: Tue, 23 May 2017 16:03:39 +0100
Message-ID: <1495551819-17040-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CF52D2670FD
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 17:02:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, brian.austin@cirrus.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

The function already defines a ret variable at the top and makes
no particular use of the shadowed definition, as such remove the
redundant definition.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4271.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index e78b5f0..d882477 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -674,8 +674,6 @@ static int cs4271_common_probe(struct device *dev,
 		cs4271->gpio_nreset = cs4271plat->gpio_nreset;
 
 	if (gpio_is_valid(cs4271->gpio_nreset)) {
-		int ret;
-
 		ret = devm_gpio_request(dev, cs4271->gpio_nreset,
 					"CS4271 Reset");
 		if (ret < 0)
-- 
2.1.4
