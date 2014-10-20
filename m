From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Mon, 20 Oct 2014 14:29:01 -0200
Message-ID: <CAOMZO5CU+Y8cGJsn4O1ccFZUSjLM1iH3QN2fAv4UyaLMk5yAEg@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
 <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0052C2673A8
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 18:29:01 +0200 (CEST)
Received: by mail-lb0-f180.google.com with SMTP id n15so4152905lbi.39
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 09:29:01 -0700 (PDT)
In-Reply-To: <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, valentin@compulab.co.il
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2014 at 10:06 AM, Fabio Estevam <festevam@gmail.com> wrote:

>>       clocks = <&clks IMX6QDL_CLK_SSI2>;
>
> This 'clocks' entry does not seem correct.
>
> IMX6QDL_CLK_SSI2 is the clock from SSI2 module, which is turned on by
> the ssi driver.
>
> Who provides the MCLK for wm8731 on utilite board? Isn't it mx6 CLKO pin?
>
> Are you able to monitor this clock with a scope and make sure that it
> is actually being turned on?
>
> We use CLKO output to drive MCLK pins on mx6qdl-sabresd board with
> wm8762 codec. You can use it as a reference.
>
> Adding the Compulab's folks on Cc.

Do the changes below help? (using IMX6QDL_CLK_CKO)

    codec: wm8731@1a {
       #sound-dai-cells = <0>;
       compatible = "wlf,wm8731";
       reg = <0x1a>;
       AVDD-supply = <&reg_3p3v>;
       HPVDD-supply = <&reg_3p3v>;
       DCVDD-supply = <&reg_3p3v>;
       DBVDD-supply = <&reg_3p3v>;
       clocks = <&clks IMX6QDL_CLK_CKO>;

with this one applied:

--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */

+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -46,6 +47,7 @@ struct wm8731_priv {
     struct regmap *regmap;
     struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
     const struct snd_pcm_hw_constraint_list *constraints;
+    struct clk *mclk;
     unsigned int sysclk;
     int sysclk_type;
     int playback_fs;
@@ -742,6 +744,21 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
         return ret;
     }

+    wm8731->mclk = devm_clk_get(&i2c->dev, NULL);
+    if (IS_ERR(wm8731->mclk)) {
+        ret = PTR_ERR(wm8731->mclk);
+        dev_err(&i2c->dev, "Failed to get mclock: %d\n", ret);
+        /* Defer the probe to see if the clk will be provided later */
+        if (ret == -ENOENT)
+            return -EPROBE_DEFER;
+    }
+
+    if (!IS_ERR(wm8731->mclk)) {
+        ret = clk_prepare_enable(wm8731->mclk);
+        if (ret)
+            return ret;
+    }
+
     i2c_set_clientdata(i2c, wm8731);

     ret = snd_soc_register_codec(&i2c->dev,
