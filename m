From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] ASoC: rt5514: Avoid relying on
	uninitialized "val" value
Date: Fri, 14 Apr 2017 09:40:31 -0700
Message-ID: <20170414164033.11681-2-dianders@chromium.org>
References: <20170414164033.11681-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 0973026696B
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 18:41:02 +0200 (CEST)
Received: by mail-pf0-f176.google.com with SMTP id 194so3293553pfv.3
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:41:02 -0700 (PDT)
In-Reply-To: <20170414164033.11681-1-dianders@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, oder_chiou@realtek.com
Cc: alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

In rt5514_i2c_probe() if the regmap_read(RT5514_VENDOR_ID2) fails then
"val" may be left as uninitialized.  Current code relies on "val" not
being RT5514_DEVICE_ID, but that's potentially unsafe.

Let's check for errors from regmap_read() and also explicitly init the
value do we're not passing a possibly uninitialized int to printk.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 481e77763fe4..969a05620e04 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1090,7 +1090,7 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 	struct rt5514_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5514_priv *rt5514;
 	int ret;
-	unsigned int val;
+	unsigned int val = ~0;
 
 	rt5514 = devm_kzalloc(&i2c->dev, sizeof(struct rt5514_priv),
 				GFP_KERNEL);
@@ -1120,8 +1120,8 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
-	if (val != RT5514_DEVICE_ID) {
+	ret = regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
+	if (ret || val != RT5514_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt5514\n", val);
 		return -ENODEV;
-- 
2.12.2.762.g0e3151a226-goog
