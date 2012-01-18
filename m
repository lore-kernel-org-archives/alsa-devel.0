From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: add driver for max9768 amplifier
Date: Wed, 18 Jan 2012 20:40:17 +0100
Message-ID: <4F172021.7020501@metafoo.de>
References: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
	<4F17005C.9000507@metafoo.de>
	<20120118192625.GA13708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 53C831038AB
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 20:40:51 +0100 (CET)
In-Reply-To: <20120118192625.GA13708@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/18/2012 08:26 PM, Wolfram Sang wrote:
>>> +	ret = snd_soc_cache_write(codec, reg, value);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	data = (reg << 6) | value;
>>
>>
>> Adding support for this register type to regmap and use regmap then is the
>> way to go. regmap should also be used for the cache instead of the legacy
>> ASoC cache.
> 
> Okay, are you already at it? Otherwise I'll try adding this tomorrow.

I won't have time for it before the weekend, so go ahead.
