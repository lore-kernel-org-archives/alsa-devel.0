From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/7] Fix Intel audio Kconfig issues
Date: Tue, 21 Nov 2017 15:36:56 -0600
Message-ID: <214d3637-1b5f-caa2-8d36-de451cdb7959@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <s5ho9o07xbr.wl-tiwai@suse.de> <s5hwp2jtv4z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwp2jtv4z.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, vinod.koul@intel.com, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 11/21/17 11:10 AM, Takashi Iwai wrote:
> On Sat, 18 Nov 2017 10:25:28 +0100,
> Takashi Iwai wrote:
>>
>> On Sat, 18 Nov 2017 01:01:55 +0100,
>> Pierre-Louis Bossart wrote:
>>>
>>> At the risk of being scolded for the third time in two days by
>>> Linux overlords (no hard feelings), here's an attempt to clean
>>> things up.
>>>
>>> The first patch *should* implement what Linus, Takashi and Mark
>>> tried to explain by email. There should be no functionality change
>>> and could be merged if deemed ok.
>>>
>>> The rest of the patch series does a more in-depth cleanup and should not
>>> be merged without more testing (hence the RFC).
>>>
>>> The 4th patch is really the most important one, there were nested
>>> configs which made no sense to me. I don't know the history which led
>>> to such complicated stuff but simpler is better.
>>>
>>> The last 3 patches are just clean-ups of the machine driver configs,
>>> for some reason there is no consistency in the settings so I tried to
>>> apply common sense. There might be additional cleanup needed since I
>>> don't really get why we need references to LPSS or DESIGNWARE for things
>>> which are not visible to a machine driver, we should only depend on IC2 or
>>> SPI in my opinion - depending on what the control interface is.
>>>
>>> I tried to keep things to a minimum in each patch to make the reviews
>>> easier, if people want them squashed that's fine by me.
>>>
>>> I'll do some more testing on my side but I could use feedback. Thanks!
>>
>> FYI, I've put these to a test branch, test/asoc-intel-kconfig, so that
>> 0day bot can catch issues.  Let's see.
> 
> No news is a good news, it seems that your patchset doesn't break
> builds, at least.  Let's go ahead!

There is additional testing being done at Intel on Skylake platforms, 
let's see after the Turkey break if additional fixes are needed. I also 
need to spend a bit more time on PCI platforms and SOF - those two were 
the main source of comments.
Thanks for the feedback and comments everyone, much appreciated.
