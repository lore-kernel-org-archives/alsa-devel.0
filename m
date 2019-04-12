From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
Date: Fri, 12 Apr 2019 09:17:35 -0500
Message-ID: <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org



On 4/12/19 5:06 AM, Srinivas Kandagatla wrote:
> 
> 
> On 11/04/2019 20:28, Pierre-Louis Bossart wrote:
>> 0-day/Kbuild starts complaining about missed module dependencies and
>> compilation issues. Since codecs and soc drivers need to be compilable
>> independently, let's fix this using the following model:
>>
>> SOUNDWIRE_INTEL ---- select -----------
>>                                        |
>>                       v
>> REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS
>>
> 
> Last time when I looked at this, Kconfig symbols SOUNDWIRE_BUS and 
> SOUNDWIRE looked totally redundant and bit over done.
> 
> Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more 
> align with others

Good point, but no. This is intentional and follows the Kconfig pattern 
pattern described by Takashi at https://lkml.org/lkml/2017/11/17/47

yes, this SOUNDWIRE is overkill for now, but let's assume there is a 
second non-intel implementation (which I understand as very likely given 
all the threads on ARM64 support). In that case you'd really want a 
top-level selector option that has no actual compilation impact - not 
used in any Makefile or code - but enables the sub-options and let 
users/distros select the platforms they care about.

SOUNDWIRE_BUS is really the lowest-common denominator that will be used 
by all drivers at the end.

> regarding REGMAP_SOUNDWIRE, It should be selected by the codec/soundwire 
> slave drivers isn't it?

yes, that was the intent.
Thanks
-Pierre
