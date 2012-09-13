From: Timur Tabi <timur@freescale.com>
Subject: Re: Need help with WM8960
Date: Thu, 13 Sep 2012 10:44:51 -0500
Message-ID: <5051FF73.2030504@freescale.com>
References: <5051160C.2010802@freescale.com>
 <20120913024245.GA4467@opensource.wolfsonmicro.com>
 <5051F0F4.5090205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E65C2625E5
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 17:44:57 +0200 (CEST)
In-Reply-To: <5051F0F4.5090205@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Also, how do I get the platform data to the codec driver?  Do I need to
> create some arch code that reads the device tree properties and parses
> them into a wm8960_data object, and then (somehow) injects that into the
> wm8960 driver?

So, I'm guessing that there is no magical way to inject platform data into
an OF-initialized driver.  What do you think about this patch:

@@ -1029,6 +1030,7 @@ static const struct regmap_config wm8960_regmap = {
 static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
                                      const struct i2c_device_id *id)
 {
+       struct device_node *np = i2c->dev.of_node;
        struct wm8960_data *pdata = dev_get_platdata(&i2c->dev);
        struct wm8960_priv *wm8960;
        int ret;
@@ -1038,6 +1040,31 @@ static __devinit int wm8960_i2c_probe(struct
i2c_client *i2c,
        if (wm8960 == NULL)
                return -ENOMEM;

+       /*
+        * Are we running on an OF platform?  If so, then parse the device
+        * tree node for properties and create the platform data object
+        * ourselves.
+        */
+       if (np && !pdata) {
+               const __be32 *iprop;
+               int len;
+
+               pdata = devm_kzalloc(&i2c->dev, sizeof(struct wm8960_data),
+                                    GFP_KERNEL);
+               if (!pdata)
+                       return -ENOMEM;
+
+               if (of_find_property(np, "wlf,capless", NULL))
+                       pdata->capless = true;
+
+               iprop = of_get_property(np, "wlf,discharge-resistance", &len);
+               if (iprop && len == sizeof(uint32_t))
+                       pdata->dres = be32_to_cpup(iprop);
+
+               if (of_find_property(np, "wlf,shared-lrclk", NULL))
+                       pdata->shared_lrclk = true;
+
+               i2c->dev.platform_data = pdata;
+       }
+
        wm8960->regmap = regmap_init_i2c(i2c, &wm8960_regmap);
        if (IS_ERR(wm8960->regmap))
                return PTR_ERR(wm8960->regmap);


-- 
Timur Tabi
Linux kernel developer at Freescale
