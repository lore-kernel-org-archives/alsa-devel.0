From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau17x1: Implemented safeload
	support
Date: Fri, 10 Aug 2018 15:45:00 +0200
Message-ID: <1095b9c2-6bd1-f14f-01a8-da52febe2a5a@metafoo.de>
References: <20180810060756.15342-1-robertr@axis.com>
 <20180810105555.GD20971@sirena.org.uk>
 <a402bc95-b051-9202-6e92-399f91bc35cb@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id E500F26770B
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2018 15:45:03 +0200 (CEST)
In-Reply-To: <a402bc95-b051-9202-6e92-399f91bc35cb@axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Rosengren <robert.rosengren@axis.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

On 08/10/2018 01:37 PM, Robert Rosengren wrote:
> 
> On 08/10/2018 12:55 PM, Mark Brown wrote:
>> On Fri, Aug 10, 2018 at 08:07:56AM +0200, Robert Rosengren wrote:
>>
>>> +bool adau17x1_has_safeload(struct adau *adau)
>>> +{
>>> +	switch (adau->type) {
>>> +	case ADAU1761:
>>> +	case ADAU1781:
>>> +		return true;
>>> +	default:
>>> +		return false;
>>> +	}
>>> +}
>>> +EXPORT_SYMBOL_GPL(adau17x1_has_safeload);
>>
>> Why is this exported - what are the intended users?
>>
> 
> Just followed pattern for adau17x1_has_dsp and adau17x1_setup_firmware, but can't find any code using those methods either. So maybe go for static function, and provide another patch making existing two functions also static and not exported?

I believe those might have been used in either adau1761.c or adau1781.c at
some point. But if they are not used any longer they should be made static
and none exported.
