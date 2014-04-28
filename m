From: Anil Kumar <anilk4.v@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: alc5623: Add device tree binding
Date: Mon, 28 Apr 2014 12:31:57 +0530
Message-ID: <CABYxbz4fM_oEFvxcKCn71kan1HBNv2V+EvE+7CgQE2A8CzUtuw@mail.gmail.com>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D05D26089A
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 09:01:58 +0200 (CEST)
Received: by mail-ig0-f174.google.com with SMTP id h18so4423587igc.13
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 00:01:57 -0700 (PDT)
In-Reply-To: <1397749994-24983-2-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, Alsa Devel List <alsa-devel@alsa-project.org>, broonie@kernel.org, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Andrew,

Please find my comment below.


On Thu, Apr 17, 2014 at 9:23 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Let the ALC5623 codec be instantiated from DT. Add a simple binding
> for the additional control register and the jack detect register.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> I followed the example of the WM8903 binding which allows register
> values to be placed into DT.
> ---
>  .../devicetree/bindings/sound/alc5623.txt          | 23
> ++++++++++++++++++++++
>  sound/soc/codecs/alc5623.c                         | 13 ++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt
> b/Documentation/devicetree/bindings/sound/alc5623.txt
> new file mode 100644
> index 000000000000..f7f71346e338
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/alc5623.txt
> @@ -0,0 +1,23 @@
> +ALC5621/ALC5622/ALC5623 audio Codec
> +
> +Required properties:
> +
> + - compatible: "realtek,alc5623"
> + - reg:                the I2C address of the device.
> +
> +Optional properties:
> +
> +  - add-ctrl:  Default register value for Reg-40h, Additional Control
> Register.
> +               If absent, the default is 0.
> +
> +  - jack-det-ctrl:     Default register value for Reg-5Ah, Jack Detect
> +                       Control Register. If absent, the default is 0.
> +
> +Example:
> +
> +                       alc5621: alc5621@1a {
> +                               compatible = "alc5621";
> +                               reg = <0x1a>;
> +                               add-ctrl = <0x3700>;
> +                               jack-det-ctrl = <0x4810>;
> +                       };
> diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
> index 2acf82f4a08a..1f9273d20b39 100644
> --- a/sound/soc/codecs/alc5623.c
> +++ b/sound/soc/codecs/alc5623.c
> @@ -23,6 +23,7 @@
>  #include <linux/i2c.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -998,8 +999,10 @@ static int alc5623_i2c_probe(struct i2c_client
> *client,
>  {
>         struct alc5623_platform_data *pdata;
>         struct alc5623_priv *alc5623;
> +       struct device_node *np;
>         unsigned int vid1, vid2;
>         int ret;
> +       u32 val32;
>
>         alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
>                                GFP_KERNEL);
> @@ -1040,6 +1043,16 @@ static int alc5623_i2c_probe(struct i2c_client
> *client,
>         if (pdata) {
>                 alc5623->add_ctrl = pdata->add_ctrl;
>                 alc5623->jack_det_ctrl = pdata->jack_det_ctrl;
> +       } else {
> +               if (client->dev.of_node) {
> +                       np = client->dev.of_node;
> +                       ret = of_property_read_u32(np, "add-ctrl", &val32);
> +                       if (ret >= 0)
>
of_property_read_u32 returns 0 on success, why  "if (ret >= 0)" check ?


> +                               alc5623->add_ctrl = val32;
> +                       ret = of_property_read_u32(np, "jack-det-ctrl",
> &val32);
>
+                       if (ret >= 0)
>
 same as above

> +                               alc5623->jack_det_ctrl = val32;
> +               }
>         }
>
>         alc5623->id = vid2;
> --
> 1.9.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
