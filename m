From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re:
 =?iso-8859-1?q?No_sound_captured_with_SGTL5000_on_i?=
 =?iso-8859-1?q?=2EMX6_in_I=B2S_master_mode?=
Date: Thu, 18 Sep 2014 16:50:46 -0700
Message-ID: <20140918235045.GA4148@Asurada>
References: <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada>
 <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
 <20140918174935.GB6432@Asurada>
 <CAOMZO5AXN4p01=oGCydHUm6sPdt5NRNXO+4EOKQ1T7ZKUwVfMw@mail.gmail.com>
 <20140918180742.GC6432@Asurada>
 <CAOMZO5AvWecqimJkZcwysvsmPiq8Fa2Hm_XppCH3E1+vyjVzFQ@mail.gmail.com>
 <20140918183910.GF6432@Asurada>
 <CAOMZO5BJbzizB4r8vvtJEBzv+DhsyRmYMUoQL2D-dQhBorGkzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A30A2265489
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 01:50:52 +0200 (CEST)
Received: by mail-pa0-f42.google.com with SMTP id lj1so2590290pab.29
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 16:50:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5BJbzizB4r8vvtJEBzv+DhsyRmYMUoQL2D-dQhBorGkzA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2014 at 08:35:31PM -0300, Fabio Estevam wrote:
> On Thu, Sep 18, 2014 at 3:39 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> 
> > It actually is merged into broonie/for-next and even linux-next I think.
> > I'll later send a patch to Shawn's tree for imx_v6_v7_defconfig changes
> > after next merge window's done.
> 
> Ok, I see it now, but master/slave configuration is still hardcoded there:
> 
>     } else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
>         priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
>         priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;

It's just a combinational driver and also made to be compatible with
old DTs. Unless we refine the DT binding like simple-card, this hard-
code is inevitable. As long as this dai_fmt has been defined, at least
AUDMUX part will be automatically configured.

I made this driver was initially to support ASRC for imx-cs42888. But
merging the code from imx-sgtl5000 and imx-wm8962 allows us to omit
a branch of duplicated code. And that's it :)

Nicolin
