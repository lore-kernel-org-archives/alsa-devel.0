From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 6/6] ASoC: rt5677: Prefix hexadecimal ID
	register value with 0x in error print
Date: Thu, 25 Jun 2015 13:59:01 +0300
Message-ID: <1435229941-9574-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1435229941-9574-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B9422605CC
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 12:59:49 +0200 (CEST)
In-Reply-To: <1435229941-9574-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make it obvious that unexpected value read from ID register is printed in
hexadecimal.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 31d969ac1192..9048ba7efee1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5209,7 +5209,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	regmap_read(rt5677->regmap, RT5677_VENDOR_ID2, &val);
 	if (val != RT5677_DEVICE_ID) {
 		dev_err(&i2c->dev,
-			"Device with ID register %x is not rt5677\n", val);
+			"Device with ID register %#x is not rt5677\n", val);
 		return -ENODEV;
 	}
 
-- 
2.1.4
