From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Date: Tue, 30 Apr 2019 08:38:01 -0500
Message-ID: <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190430085153.GS3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430085153.GS3845@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/30/19 3:51 AM, Vinod Koul wrote:
> On 15-04-19, 08:09, Pierre-Louis Bossart wrote:
>>
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    drivers/soundwire/Kconfig          |   2 +-
>>>>    drivers/soundwire/bus.c            |  87 ++++++++--------
>>>>    drivers/soundwire/bus.h            |  16 +--
>>>>    drivers/soundwire/bus_type.c       |   4 +-
>>>>    drivers/soundwire/cadence_master.c |  87 ++++++++--------
>>>>    drivers/soundwire/cadence_master.h |  22 ++--
>>>>    drivers/soundwire/intel.c          |  87 ++++++++--------
>>>>    drivers/soundwire/intel.h          |   4 +-
>>>>    drivers/soundwire/intel_init.c     |  12 +--
>>>>    drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
>>>>    drivers/soundwire/slave.c          |  10 +-
>>>>    drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
>>>
>>> I would prefer this to be a patch per module. It doesnt help to have a
>>> single patch for all the files!
>>>
>>> It would be great to have cleanup done per logical group, for example
>>> typos in a patch, aligns in another etc...
>>
>> You've got to be kidding. I've never seen people ask for this sort of
>> detail.
> 
> Nope this is the way it should be. A patch is patch and which
> should do one thing! Even if it is a cleanup one.
> 
> I dislike a patch which touches everything, core, modules, so please
> split up. As a said in review it takes guesswork to find why a change
> was done, was it whitespace fix, indentation or not, so please split up
> based on type of fixes.

With all due respect, you are not helping here but rather slowing things 
down. I've done dozens of cleanups in the ALSA tree and I didn't go in 
this sort of details. The fact that the series was tagged as Reviewed by 
Takashi on April 11 and we are still discussing trivial changes tells me 
the integration model is broken. It's not just me, the patches related 
to runtime-pm from your own Linaro colleagues posted on March 28 went 
nowhere either.

Moving forward, I suggest we merge SoundWire-related patches through the 
sound tree. There will be dependencies in the coming weeks between SOF 
and SoundWire and it makes no sense to have separate maintainers and 
make the life of early adopters more complicated than it needs to be. If 
we have 3-week delays for trivial stuff, I can't imagine what the pace 
will be when I publish the next 20-odd patches I am still working on, 
and the code needed for the SoundWire audio device class being 
standardized as we speak. Things were fine up to now since no one was 
actually using the code, we are in a different model now.
