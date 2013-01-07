From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH 1/4] ALSA: pxa2xx: fix ac97 cold reset
Date: Mon, 07 Jan 2013 06:19:47 -0800
Message-ID: <50EAD983.5060801@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-2-git-send-email-mikedunn@newsguy.com>
 <50EA9287.5030304@compulab.co.il> <50EACF4D.4000602@newsguy.com>
 <50EAD43C.2040406@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BD2F2650F2
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 15:19:27 +0100 (CET)
In-Reply-To: <50EAD43C.2040406@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/07/2013 05:57 AM, Igor Grinberg wrote:
> On 01/07/13 15:36, Mike Dunn wrote:
>> On 01/07/2013 01:16 AM, Igor Grinberg wrote:
>>> On 01/06/13 21:13, Mike Dunn wrote:
>>
>>
>> [..]
>>
>>
>>>>  static inline void pxa_ac97_cold_pxa27x(void)
>>>>  {
>>>> +	unsigned int timeout;
>>>> +
>>>>  	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
>>>>  	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
>>>>  
>>>> @@ -157,8 +159,10 @@ static inline void pxa_ac97_cold_pxa27x(void)
>>>>  	clk_enable(ac97conf_clk);
>>>>  	udelay(5);
>>>>  	clk_disable(ac97conf_clk);
>>>> -	GCR = GCR_COLD_RST;
>>>> -	udelay(50);
>>>> +	GCR = GCR_COLD_RST | GCR_WARM_RST;
>>>> +	timeout = 100;     /* wait for the codec-ready bit to be set */
>>>> +	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
>>>> +		mdelay(1);
>>>
>>> Can we use msleep() instead?
>>> May be this will require to change the granularity to 10...
>>
>>
>> Probably.  mdelay() is used by similiar code in the same file, so I just stayed
>> consistent.  The code runs very infrequently, so I didn't worry about it.
> 
> Well, if we can, I think we'd better do, no?


If you feel strongly about it, I'll defer to you.  But again my arguments are
(1) the code runs very infrequently, and (2) very similar code for the other pxa
family siblings uses mdelay().

Thanks,
Mike
