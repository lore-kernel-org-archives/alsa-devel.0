From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Thu, 07 May 2015 19:07:27 +0200
Message-ID: <554B9BCF.8040201@intel.com>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>	
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>	
 <1430837158.8043.61.camel@loki>	
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <1430997961.17543.38.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CC1A265176
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 19:07:36 +0200 (CEST)
In-Reply-To: <1430997961.17543.38.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 5/7/2015 1:26 PM, Liam Girdwood wrote:
> On Thu, 2015-05-07 at 05:34 +0000, Bard Liao wrote:
>>>>> +static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct
>>>>> +device_node *np) {
>>>>> + rt5645->pdata.in2_diff = of_property_read_bool(np,
>>>>> +         "realtek,in2-differential");
>>>>> + of_property_read_u32(np,
>>>>> +         "realtek,dmic1-data-pin",
>>> &rt5645->pdata.dmic1_data_pin);
>>>> We should really be using device_property_() instead of
>> of_property_()
>>>> APIs since we will have to support both DT and ACPI properties.
>> Unfortunately, I can't find a way to test it.
> device_property() API calls abstract the device tree calls and ACPI
> calls. So testing with your DT based HW will work.
>
>> Is that ok we just replace all of_property_ with device_property_?
> Yes, that's the intention.
>
>> Also, is there any corresponding API for of_get_named_gpio?
>> Or we can replace it with device_property_read_u32?
>> I tried the change above, and it can build. However I don't know
>> if it can work.
> Oh, I think that's a question for Rafael. I think the intention is to
> have a 1:1 mapping between the APIs so that there are no gaps ?

Yes, that's the idea, but then the GPIO maintainers would like to clean 
up the API too.

Mika is more familiar with the GPIO area than I am.

Mika, can you please help us here?

Rafael
