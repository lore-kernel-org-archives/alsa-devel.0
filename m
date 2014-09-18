From: Fabio Estevam <festevam@gmail.com>
Subject: Re:
	=?utf-8?q?No_sound_captured_with_SGTL5000_on_i=2EMX6?=
	=?utf-8?q?_in_I=C2=B2S_master_mode?=
Date: Thu, 18 Sep 2014 14:28:29 -0300
Message-ID: <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
References: <CAL8zT=hSCpBZpqVGQ5uBdXJe25hqoNkmiPh_Ge3RCrGALkaoZg@mail.gmail.com>
 <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
 <CAOf5uwmrsuXSCpUXhf3pTCRt0=4pprwfiP5MDDukE=WRzOk2WA@mail.gmail.com>
 <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id C6BEF261ADC
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 19:28:31 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id l4so1632129lbv.30
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 10:28:29 -0700 (PDT)
In-Reply-To: <20140918170524.GA6080@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Thu, Sep 18, 2014 at 2:05 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> The problem here should be the AUDMUX configuration issue. The imx-
> sgtl5000.c driver only supports CODEC in master mode. So if you try
> to switch the CODEC slave mode, you shall also change not only the
> CBM_CFM to CBS_CFS but also swap the ext_port and int_port of AUDMUX
> (a little confusing approach here as the configuration of AUDMUX is
> routing the data and clocks from a source port to a destination port
> while each of side, external or internal, might be a source port --
> When using CBM_CFM, the source port should be external port; while
> using CBS_CFS, the source port should be the internal port.)

Thanks for the hint on audmux swap! I can get ssi in master mode to
work correctly with the change below:


--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -111,8 +111,8 @@
                        "IN3R", "MICBIAS",
                        "DMIC", "MICBIAS",
                        "DMICDAT", "DMIC";
-               mux-int-port = <2>;
-               mux-ext-port = <3>;
+               mux-int-port = <3>;
+               mux-ext-port = <2>;
        };

        backlight {
diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 3a3d17c..09ea6a5 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -247,7 +247,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
        data->dai.platform_of_node = ssi_np;
        data->dai.ops = &imx_hifi_ops;
        data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-                           SND_SOC_DAIFMT_CBM_CFM;
+                           SND_SOC_DAIFMT_CBS_CFS;

        data->card.dev = &pdev->dev;
        ret = snd_soc_of_parse_card_name(&data->card, "model");
