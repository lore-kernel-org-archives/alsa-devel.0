From: Robert Rosengren <robert.rosengren@axis.com>
Subject: Re: [PATCH] ASoC: adau17x1: Implemented safeload
	support
Date: Fri, 10 Aug 2018 13:37:46 +0200
Message-ID: <a402bc95-b051-9202-6e92-399f91bc35cb@axis.com>
References: <20180810060756.15342-1-robertr@axis.com>
 <20180810105555.GD20971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A33E2676A2
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2018 13:37:47 +0200 (CEST)
In-Reply-To: <20180810105555.GD20971@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org


On 08/10/2018 12:55 PM, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 08:07:56AM +0200, Robert Rosengren wrote:
> 
>> +bool adau17x1_has_safeload(struct adau *adau)
>> +{
>> +	switch (adau->type) {
>> +	case ADAU1761:
>> +	case ADAU1781:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(adau17x1_has_safeload);
> 
> Why is this exported - what are the intended users?
> 

Just followed pattern for adau17x1_has_dsp and adau17x1_setup_firmware, but can't find any code using those methods either. So maybe go for static function, and provide another patch making existing two functions also static and not exported?
