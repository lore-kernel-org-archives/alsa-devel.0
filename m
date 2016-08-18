From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Thu, 18 Aug 2016 09:04:12 +0800
Message-ID: <57B5098C.7020102@nuvoton.com>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk> <57B28F1D.8070409@nuvoton.com>
 <20160816103854.GP9347@sirena.org.uk> <57B3B107.9080702@nuvoton.com>
 <20160817094221.GG9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 00D30266021
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 03:04:16 +0200 (CEST)
In-Reply-To: <20160817094221.GG9347@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 8/17/2016 5:42 PM, Mark Brown wrote:
> On Wed, Aug 17, 2016 at 08:34:15AM +0800, John Hsu wrote:
>   
>> On 8/16/2016 6:38 PM, Mark Brown wrote:
>>     
>
>   
>>> You're not open coding this, this is using regmap!
>>>       
>
>   
>> Yes, the regmap raw read will use regmap finally. But it needs
>> format_val to make the value and it is not registered because
>> no such value width, 9 bits. The system will crash if the driver
>> uses regmap_raw_read with 9 bits value.
>>     
>
> The whole point with raw read is that it isn't reformatting the value.
>   

I post the partial function. The format_val is not valid for our
codec driver and we can't use the regmap_raw_read(). It's the reason
that we need to make the function like regmap_raw_read().

int regmap_raw_read(struct regmap *map, unsigned int reg, ... )
{
    ...
    if (regmap_volatile_range(map, reg, val_count) ... ) {
        ...
    } else {
        /* Otherwise go word by word for the cache; should be low
         * cost as we expect to hit the cache.
         */
        for (i = 0; i < val_count; i++) {
            ret = _regmap_read(map, reg + regmap_get_offset(map, i),
                       &v);
            if (ret != 0)
                goto out;

            map->format.format_val(val + (i * val_bytes), v, 0);
        }
    }
