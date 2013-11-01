From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: wm8962: Move register initialisation to I2C
	probe()
Date: Fri, 1 Nov 2013 13:33:48 +0300
Message-ID: <20131101103348.GO29795@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id BF80C2655A0
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 11:36:52 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@linaro.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Mark Brown,

This is a semi-automatic email about new static checker warnings.

The patch 78b78f5c019e: "ASoC: wm8962: Move register initialisation 
to I2C probe()" from Oct 17, 2013, leads to the following Smatch 
complaint:

sound/soc/codecs/wm8962.c:3620 wm8962_i2c_probe()
	 error: we previously assumed 'pdata' could be null (see line 3537)

sound/soc/codecs/wm8962.c
  3531          /* If platform data was supplied, update the default data in priv */
  3532          if (pdata) {
                    ^^^^^
Existing check.

  3533                  memcpy(&wm8962->pdata, pdata, sizeof(struct wm8962_pdata));
  3534          } else if (i2c->dev.of_node) {
  3535                  ret = wm8962_set_pdata_from_of(i2c, &wm8962->pdata);
  3536			if (ret != 0)
  3537				return ret;
  3538		}

[snip]

  3613		/* Ensure that the oscillator and PLLs are disabled */
  3614		regmap_update_bits(wm8962->regmap, WM8962_PLL2,
  3615				   WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
  3616				   0);
  3617	
  3618		/* Apply static configuration for GPIOs */
  3619		for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
  3620			if (pdata->gpio_init[i]) {
                            ^^^^^^^^^^^^^^^^^^
Patch introduces unchecked dereference.

  3621				wm8962_set_gpio_mode(wm8962, i + 1);
  3622				regmap_write(wm8962->regmap, 0x200 + i,

regards,
dan carpenter
