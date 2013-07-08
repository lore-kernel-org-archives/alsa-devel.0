From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: ak4554: add DT support
Date: Mon, 08 Jul 2013 10:03:34 -0600
Message-ID: <51DAE2D6.2080707@wwwdotorg.org>
References: <87wqp5wwuy.wl%kuninori.morimoto.gx@renesas.com>
 <51D693D5.3080307@metafoo.de> <51D6FA9D.30105@wwwdotorg.org>
 <51D6FC8A.1050908@metafoo.de> <51D6FEC9.8090305@wwwdotorg.org>
 <51D868CF.5080105@gmail.com> <51D9ABD5.5010601@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id E41DF265456
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 18:03:39 +0200 (CEST)
In-Reply-To: <51D9ABD5.5010601@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/07/2013 11:56 AM, Lars-Peter Clausen wrote:
> On 07/06/2013 08:58 PM, Sylwester Nawrocki wrote:
>> On 07/05/2013 07:13 PM, Stephen Warren wrote:
>>> On 07/05/2013 11:04 AM, Lars-Peter Clausen wrote:
>>>> On 07/05/2013 06:55 PM, Stephen Warren wrote:
>>>>> On 07/05/2013 03:37 AM, Lars-Peter Clausen wrote:
>>>>>>> +  - compatible : "asahi-kasei,ak4554"
>>>>>>
>>>>>> The vendor prefix for Asahi Kasei is documented as "ak" in
>>>>>> Documentation/devicetree/bindings/vendor-prefixes.txt. But it doesn;t seem
>>>>>> to be used in any upstream drivers, Stephen add that prefix maybe he knows
>>>>>> if it is used. If it is unused you should probably send a patch updating the
>>>>>> Documentation.
>>>>>
>>>>> It's used at:
>>>>>
>>>>> arch/arm/boot/dts/tegra20-seaboard.dts:499: compatible = "ak,ak8975";
>>>>>
>>>>> ... although I see that somebody has incorrectly modified
>>>>> ./drivers/iio/magnetometer/ak8975.c to support the "asahi-kasei," vendor
>>>>> prefix:-(
>>>>
>>>> It looks as if the ak prefix was never in an upstream kernel and the commit
>>>> date that added the dt table predates the commit date for your devicetree.
>>>
>>> The usage I quoted above is in the mainline kernel, along with the entry
>>> in vendor-prefixes.txt.
>>>
>>> When I fixed vendor-prefixes.txt to define a prefix for AK, and updated
>>> the Tegra DT to use them[1], I guess I didn't even look at the driver,
>>> since all I2C device matching uses the i2c_device_id table rather than
>>> the of_device_id, and the i2c_device_id table doesn't have a concept of
>>> a vendor prefix. Hence, I didn't notice the conflict.
>>>
>>> So, even though the asahi-kasei prefix is in the of_device_id table in
>>> the driver, I'd say the ak prefix trumps it, since it's actually in-use
>>> in device trees, and is registered in vendor-prefixes.txt.
>>
>> I'm going to update this [2] patch to use "ak,ak8975" compatible string
>> then. Still there are some audio codec drivers that use "asahi-kasei"
>> vendor prefix:
... [examples]
>> It's not in any dts file though, I'm not sure if that makes any
>> difference.
> 
> Well strictly speaking this is all public ABI, so I guess the best is to add a
> ak prefixed compatible string besides the asahi-kasei one and stick to ak only
> fore future drivers.

True. The best thing may be to deprecate the old vendor prefix by
modifying all the DT binding documents that reference it so that they
describe the new prefix. In theory we do indeed still have to support
the old prefix in all the affected drivers though.
