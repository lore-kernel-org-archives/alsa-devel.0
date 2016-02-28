From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH v3] ASoC: nau8825: fix issue that pop noise
 when start playback
Date: Mon, 29 Feb 2016 06:50:11 +0800
Message-ID: <56D379A3.8030401@nuvoton.com>
References: <1454383094-6778-1-git-send-email-KCHSU0@nuvoton.com>
 <1454661165-15275-1-git-send-email-KCHSU0@nuvoton.com>
 <20160208165258.GI7265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2E3260564
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2016 23:50:19 +0100 (CET)
In-Reply-To: <20160208165258.GI7265@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 2/9/2016 12:52 AM, Mark Brown wrote:
> On Fri, Feb 05, 2016 at 04:32:45PM +0800, John Hsu wrote:
>
>   
>>  	switch (event) {
>>  	case SND_SOC_DAPM_POST_PMU:
>>  		/* Prevent startup click by letting charge pump to ramp up */
>>  		msleep(10);
>> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_CHARGE_PUMP,
>> +			NAU8825_JAMNODCLOW, NAU8825_JAMNODCLOW);
>> +		break;
>> +	case SND_SOC_DAPM_PRE_PMD:
>> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLASSG_CTRL,
>> +			NAU8825_CLASSG_EN, 0);
>> +		break;
>> +	case SND_SOC_DAPM_POST_PMD:
>> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
>> +			NAU8825_HP_BOOST_DIS, 0);
>>  		break;
>>     
>
> This is really hard to follow, the enables and disables here don't match
> up (I see that at least some of these are handled by other widgets on
> the other path).  I at least need some words explaining what the
> intended effect of the change is.
>   

OK, we can arrange it again to avoid the configuration overlap.
It's no problem to add more explaining.
