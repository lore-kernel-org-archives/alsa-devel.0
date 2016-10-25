From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 3/3] ASoC: cs42l73: Remove cache bypass for
	read of ID registers
Date: Tue, 25 Oct 2016 16:42:31 +0100
Message-ID: <1477410151-17515-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477410151-17515-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 411EB266F03
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 17:42:27 +0200 (CEST)
In-Reply-To: <1477410151-17515-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Don't manually enable cache_bypass for reading the ID registers they
don't have a default anyway so the first read will always hit the
hardware. The old code worked this is simply the more standard way
to implement this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
---

Changes since v1:
 - Don't mark the ID register as volatile.

Thanks,
Charles

 sound/soc/codecs/cs42l73.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 71ba560..3df2c47 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1337,8 +1337,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 1);
 	}
 
-	regcache_cache_bypass(cs42l73->regmap, true);
-
 	/* initialize codec */
 	ret = regmap_read(cs42l73->regmap, CS42L73_DEVID_AB, &reg);
 	devid = (reg & 0xFF) << 12;
@@ -1366,8 +1364,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev,
 		 "Cirrus Logic CS42L73, Revision: %02X\n", reg & 0xFF);
 
-	regcache_cache_bypass(cs42l73->regmap, false);
-
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_dev_cs42l73, cs42l73_dai,
 			ARRAY_SIZE(cs42l73_dai));
-- 
2.1.4
