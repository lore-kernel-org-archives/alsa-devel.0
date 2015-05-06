From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Wed, 6 May 2015 06:42:54 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70106792F@RTITMBSV03.realtek.com.tw>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EF3A32605B7
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 08:43:05 +0200 (CEST)
In-Reply-To: <1430837158.8043.61.camel@loki>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Tuesday, May 05, 2015 10:46 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; Oder Chiou;
> alsa-devel@alsa-project.org; lars@metafoo.de;
> zhengxing@rock-chips.com; yang.a.fang@intel.com;
> koro.chen@mediatek.com; John Lin; Flove
> Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: rt5645: add device tree
> support
> 
> On Tue, 2015-05-05 at 21:42 +0800, Bard Liao wrote:
> > Modify the RT5645 driver to parse platform data from device tree.
> > Write a DT binding document to describe those properties.
> >
> > Signed-off-by: Bard Liao <bardliao@realtek.com>
> > ---
> >  Documentation/devicetree/bindings/sound/rt5645.txt | 72
> ++++++++++++++++++++++
> >  sound/soc/codecs/rt5645.c                          | 35
> +++++++++++
> >  2 files changed, 107 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/sound/rt5645.txt
> >
> 
> > diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> > index e435680..36e22b6 100644
> > --- a/sound/soc/codecs/rt5645.c
> > +++ b/sound/soc/codecs/rt5645.c
> > @@ -3134,6 +3134,37 @@ static struct dmi_system_id
> dmi_platform_intel_braswell[] = {
> >  	{ }
> >  };
> >
> > +static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct
> > +device_node *np) {
> > +	rt5645->pdata.in2_diff = of_property_read_bool(np,
> > +		"realtek,in2-differential");
> > +	of_property_read_u32(np,
> > +		"realtek,dmic1-data-pin", &rt5645->pdata.dmic1_data_pin);
> 
> We should really be using device_property_() instead of of_property_()
> APIs since we will have to support both DT and ACPI properties.

We will modify it and send a new version patch for it.

Thanks.

> 
> Liam
> 
> 
> ------Please consider the environment before printing this e-mail.
