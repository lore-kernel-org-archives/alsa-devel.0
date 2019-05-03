From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Fri, 3 May 2019 09:32:53 -0500
Message-ID: <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
 <20190503043957.GA14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503043957.GA14916@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 5/2/19 11:39 PM, Mark Brown wrote:
> On Fri, Apr 19, 2019 at 02:46:49PM -0500, Pierre-Louis Bossart wrote:
> 
>>   config REGMAP_SOUNDWIRE
>>   	tristate
>> -	depends on SOUNDWIRE_BUS
>> +	select SOUNDWIRE_BUS
> 
> This now makes _SOUNDWIRE different to all the other bus types; if this
> is a good change then surely the same thing should be done for all the
> other bus types.  It's also not clear to me that this actually does
> anything, do selects from symbols that are themselves selected actually
> do anything?

yes, this works, but if you prefer alignment I can follow the SLIMBUS model

config SND_SOC_WCD9335
	tristate "WCD9335 Codec"
	depends on SLIMBUS
	select REGMAP_SLIMBUS
	select REGMAP_IRQ

config REGMAP_SLIMBUS
	tristate
	depends on SLIMBUS

menuconfig SLIMBUS
	tristate "SLIMbus support"
	
if SLIMBUS

# SLIMbus controllers
config SLIM_QCOM_CTRL
...

As I mentioned it'll compile the bus even if there is no user for it, 
but it's your call: alignment or optimization.
