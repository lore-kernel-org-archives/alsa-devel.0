From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 5/6] ASoC: rt5640: Remove the unnecessary
	parentheses
Date: Fri, 28 Mar 2014 20:28:29 +0800
Message-ID: <1396009710-21324-5-git-send-email-oder_chiou@realtek.com>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A75B02654C1
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:29:39 +0100 (CET)
In-Reply-To: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the unnecessary parentheses.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 096edfe..b5014a2 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2102,7 +2102,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	}
 
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
-	if ((val != RT5640_DEVICE_ID)) {
+	if (val != RT5640_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt5640/39\n", val);
 		return -ENODEV;
-- 
1.8.1.1.439.g50a6b54
