From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: cs42l73: Show correct revision id
Date: Sat, 19 Nov 2011 10:17:36 +0800
Message-ID: <1321669056.9341.3.camel@phoenix>
References: <1321668953.9341.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A5D6C244F3
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 03:17:42 +0100 (CET)
Received: by yenr9 with SMTP id r9so1207955yen.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 18:17:42 -0800 (PST)
In-Reply-To: <1321668953.9341.1.camel@phoenix>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l73.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 3eed21e..066d869 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1384,7 +1384,7 @@ static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	dev_info(&i2c_client->dev,
-		 "Cirrus Logic CS42L73, Revision: %02X\n", ret & 0xFF);
+		 "Cirrus Logic CS42L73, Revision: %02X\n", reg & 0xFF);
 
 	regcache_cache_only(cs42l73->regmap, true);
 
-- 
1.7.5.4
