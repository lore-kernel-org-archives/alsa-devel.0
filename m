From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
Date: Fri, 12 Apr 2019 09:56:21 -0500
Message-ID: <0f6431b2-169e-4146-8f53-1ff2efac4d74@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
 <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
 <20190412142748.GB6235@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412142748.GB6235@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org


>>> Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more
>>> align with others
> 
>> Good point, but no. This is intentional and follows the Kconfig pattern
>> pattern described by Takashi at https://lkml.org/lkml/2017/11/17/47
> 
>> yes, this SOUNDWIRE is overkill for now, but let's assume there is a second
>> non-intel implementation (which I understand as very likely given all the
>> threads on ARM64 support). In that case you'd really want a top-level
>> selector option that has no actual compilation impact - not used in any
>> Makefile or code - but enables the sub-options and let users/distros select
>> the platforms they care about.
> 
> I don't understand what you're saying here - what is the intended
> difference between SOUNDWIRE and SOUNDWIRE_BUS?  Having the separate
> option for _INTEL for your controller makes sense but otherwise the
> normal pattern for a bus would be that you'd have the root config
> option for the bus (which would enable the core code for the bus) and
> then everything else is hidden behind that.

I was thinking of this pattern:

config SOUNDWIRE
	bool "SoundWire support"

if SOUNDWIRE

config SOUNDWIRE_INTEL
	tristate "SoundWire for Intel"
	select SOUNDWIRE_BUS

config SOUNDWIRE_XYZ_ARM64
	tristate "SoundWire for XYZ platform"
	select SOUNDWIRE_BUS

config SOUNDWIRE_BUS
	tristate

endif

One could argue that SOUNDWIRE could select SOUNDWIRE_BUS directly, or 
merge the two, but then you could have a configuration where the bus is 
included with no actual users. Not to mention that the intent of the 
top-level selector is typically to have no impact on compilation as 
recommended by Linus.
