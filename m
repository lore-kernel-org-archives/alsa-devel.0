From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Thu, 07 May 2015 12:26:01 +0100
Message-ID: <1430997961.17543.38.camel@loki>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C11EA261546
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 13:26:08 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-05-07 at 05:34 +0000, Bard Liao wrote:
> > > > +static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct
> > > > +device_node *np) {
> > > > + rt5645->pdata.in2_diff = of_property_read_bool(np,
> > > > +         "realtek,in2-differential");
> > > > + of_property_read_u32(np,
> > > > +         "realtek,dmic1-data-pin",
> > &rt5645->pdata.dmic1_data_pin);
> > >
> > > We should really be using device_property_() instead of
> of_property_()
> > > APIs since we will have to support both DT and ACPI properties.
> 
> Unfortunately, I can't find a way to test it.

device_property() API calls abstract the device tree calls and ACPI
calls. So testing with your DT based HW will work.

> Is that ok we just replace all of_property_ with device_property_?

Yes, that's the intention.

> Also, is there any corresponding API for of_get_named_gpio?
> Or we can replace it with device_property_read_u32?
> I tried the change above, and it can build. However I don't know
> if it can work.

Oh, I think that's a question for Rafael. I think the intention is to
have a 1:1 mapping between the APIs so that there are no gaps ?

Liam
