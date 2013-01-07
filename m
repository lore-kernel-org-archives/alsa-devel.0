From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH 2/4] ALSA: pxa27x: fix ac97 warm reset bug
 work-around code
Date: Mon, 07 Jan 2013 05:40:15 -0800
Message-ID: <50EAD03F.4050507@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-3-git-send-email-mikedunn@newsguy.com>
 <50EA9607.7050408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id B87E62615F1
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 14:39:54 +0100 (CET)
In-Reply-To: <50EA9607.7050408@compulab.co.il>
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

On 01/07/2013 01:31 AM, Igor Grinberg wrote:
> On 01/06/13 21:13, Mike Dunn wrote:


[..]


>> diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
>> index a611ad3..8281e17 100644
>> --- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
>> +++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
>> @@ -463,6 +463,9 @@
>>  	GPIO76_LCD_PCLK,	\
>>  	GPIO77_LCD_BIAS
>>  
>> +/* these enable a work-around for a hw bug in pxa27x during ac97 warm reset */
>> +#define GPIO113_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH)
>> +#define GPIO95_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH)
> 
> Do we really need to change the LPM? Because DRIVE_* only affect LPM.


Oops, no, we don't.  In fact, since you pointed this out to me in your review of
the earlier patch, I meant to remove it.  It does no harm, but should be removed
for clarity.

Thanks,
Mike
