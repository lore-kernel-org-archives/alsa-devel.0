From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: ak4554: add DT support
Date: Fri, 05 Jul 2013 11:13:45 -0600
Message-ID: <51D6FEC9.8090305@wwwdotorg.org>
References: <87wqp5wwuy.wl%kuninori.morimoto.gx@renesas.com>
 <51D693D5.3080307@metafoo.de> <51D6FA9D.30105@wwwdotorg.org>
 <51D6FC8A.1050908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B152A264F24
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 19:13:49 +0200 (CEST)
In-Reply-To: <51D6FC8A.1050908@metafoo.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/05/2013 11:04 AM, Lars-Peter Clausen wrote:
> On 07/05/2013 06:55 PM, Stephen Warren wrote:
>> On 07/05/2013 03:37 AM, Lars-Peter Clausen wrote:
>>>> +  - compatible : "asahi-kasei,ak4554"
>>>
>>> The vendor prefix for Asahi Kasei is documented as "ak" in
>>> Documentation/devicetree/bindings/vendor-prefixes.txt. But it doesn;t seem
>>> to be used in any upstream drivers, Stephen add that prefix maybe he knows
>>> if it is used. If it is unused you should probably send a patch updating the
>>> Documentation.
>>
>> It's used at:
>>
>> arch/arm/boot/dts/tegra20-seaboard.dts:499: compatible = "ak,ak8975";
>>
>> ... although I see that somebody has incorrectly modified
>> ./drivers/iio/magnetometer/ak8975.c to support the "asahi-kasei," vendor
>> prefix:-(
> 
> It looks as if the ak prefix was never in an upstream kernel and the commit
> date that added the dt table predates the commit date for your devicetree.

The usage I quoted above is in the mainline kernel, along with the entry
in vendor-prefixes.txt.

When I fixed vendor-prefixes.txt to define a prefix for AK, and updated
the Tegra DT to use them[1], I guess I didn't even look at the driver,
since all I2C device matching uses the i2c_device_id table rather than
the of_device_id, and the i2c_device_id table doesn't have a concept of
a vendor prefix. Hence, I didn't notice the conflict.

So, even though the asahi-kasei prefix is in the of_device_id table in
the driver, I'd say the ak prefix trumps it, since it's actually in-use
in device trees, and is registered in vendor-prefixes.txt.

[1]:
> commit ae8c4209af2cec065fef15d200a42a04130799f7
> Author:     Stephen Warren <swarren@nvidia.com>
> AuthorDate: Mon Nov 19 15:34:43 2012 -0700
> Commit:     Rob Herring <rob.herring@calxeda.com>
> CommitDate: Tue Nov 20 22:58:54 2012 -0600
> 
>     of: Add vendor prefix for Asahi Kasei Corp.
>     
>     Their stock ticker is 3407.T which wouldn't make a good DT vendor
>     prefix. Use the company name initials instead.
>     
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> 
> commit 9846210b1ec9bbaa30022d6d8af7e55ef67ccb45
> Author:     Stephen Warren <swarren@nvidia.com>
> AuthorDate: Mon Nov 19 15:34:44 2012 -0700
> Commit:     Rob Herring <rob.herring@calxeda.com>
> CommitDate: Tue Nov 20 22:58:54 2012 -0600
> 
>     ARM: tegra: seaboard: add missing DT vendor prefixes
>     
>     A couple devices' DT compatible values only contained the device name
>     without any vendor prefix. Add the missing vendor prefixes.
>     
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Signed-off-by: Rob Herring <rob.herring@calxeda.com>
