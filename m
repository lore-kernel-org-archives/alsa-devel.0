From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ak4554: add DT support
Date: Fri, 05 Jul 2013 19:04:10 +0200
Message-ID: <51D6FC8A.1050908@metafoo.de>
References: <87wqp5wwuy.wl%kuninori.morimoto.gx@renesas.com>
 <51D693D5.3080307@metafoo.de> <51D6FA9D.30105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id B2EAB264F0F
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 19:00:52 +0200 (CEST)
In-Reply-To: <51D6FA9D.30105@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/05/2013 06:55 PM, Stephen Warren wrote:
> On 07/05/2013 03:37 AM, Lars-Peter Clausen wrote:
>>> +  - compatible : "asahi-kasei,ak4554"
>>
>> The vendor prefix for Asahi Kasei is documented as "ak" in
>> Documentation/devicetree/bindings/vendor-prefixes.txt. But it doesn;t seem
>> to be used in any upstream drivers, Stephen add that prefix maybe he knows
>> if it is used. If it is unused you should probably send a patch updating the
>> Documentation.
> 
> It's used at:
> 
> arch/arm/boot/dts/tegra20-seaboard.dts:499: compatible = "ak,ak8975";
> 
> ... although I see that somebody has incorrectly modified
> ./drivers/iio/magnetometer/ak8975.c to support the "asahi-kasei," vendor
> prefix:-(

It looks as if the ak prefix was never in an upstream kernel and the commit
date that added the dt table predates the commit date for your devicetree.

- Lars
