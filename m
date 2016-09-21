From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Thu, 22 Sep 2016 00:18:54 +0200
Message-ID: <57E3074E.4070601@maciej.szmigiero.name>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
 <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id D5DC3266930
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2016 00:18:59 +0200 (CEST)
In-Reply-To: <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 21.09.2016 21:32, Marek Vasut wrote:
> On 09/21/2016 06:28 PM, Maciej S. Szmigiero wrote:
>> Hi Marek,
> 
> Hi!
> 
>> On 19.09.2016 21:30, Marek Vasut wrote:
(..)
>>> The RB-tree regmap cache needs to allocate new space on first
>>> writes.
>>
>> That's why SSI driver had .num_reg_defaults_raw set in regmap config.
>> With this set and .reg_defaults_raw unset regcache_hw_init() will read
>> existing register content which then will be used to populate cache
>> (and so allocate RB tree nodes) at regcache initialization time.
> 
> OK
> 
>> This means that allocation of new cache RB tree nodes should never happen
>> during actual write.
>> If you get a warning that it happened then maybe there is a write to
>> some register not covered by .num_reg_defaults_raw - this should be
>> fixed.
> 
> I might be blind, but I really don't see that. I just discussed it with
> Mark and he thinks the same. I will revisit this one more time.

Maybe it would be possible to get a backtrace when that warning was
generated so we know which register write or update triggers new cache
allocation?

>> The problem with flat cache is that it is zero-initialized, that is,
>> all registers are assumed to contain zeros by default.
>> This is generally not true in case of SSI so reads from and bit updates
>> in non-volatile registers will corrupt their value.
> 
> This will let the driver init the hardware into a well-defined state.
> Are there any bits in the SSI config registers which we must preserve?

Hard to tell, this would need to be checked, but when datasheet values
were used as cache defaults the SoC locked up when the fsl_ssi module
was reloaded, at least in AC'97 mode.

I guess with zeros as defaults similar problems could occur.

Maciej
