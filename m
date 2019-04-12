From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: soundwire: fix Kconfig
 select/depend issue
Date: Fri, 12 Apr 2019 09:07:41 -0500
Message-ID: <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ho95bpqis.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the reviews

>> The mechanism should be
>>
>> config CODEC_XYX_SDW
>>         depends on SOUNDWIRE
>>         select REGMAP_SOUNDWIRE
>>
>> config REGMAP_SOUNDWIRE
>>         depends on SOUNDWIRE
>>         select SOUNDWIRE_BUS
> 
> To be noted, in general you can't do put both depends-on and select.
> The select always wins.  So the depends-on in REGMAP_SOUNDWIRE is more
> or less moot.


ok. To double-check, the example below would be legit, yes?

  config CODEC_XYX_SDW
	 tristate "XYZ SDW Codec"
          depends on SOUNDWIRE
          select REGMAP_SOUNDWIRE

  config REGMAP_SOUNDWIRE
          select SOUNDWIRE_BUS

it'd follow the typical pattern seen in sound/soc/codecs/Kconfig:

config SND_SOC_CS4265
	tristate "Cirrus Logic CS4265 CODEC"
	depends on I2C
	select REGMAP_I2C

Thanks
-Pierre
