From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 15/27] ALSA: hda - Use timecounter_initialize
 interface
Date: Fri, 5 Jan 2018 09:43:12 -0600
Message-ID: <8c4dbc50-3e59-e860-6131-99fa10a8313f@linux.intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
 <s5hh8ssgsaw.wl-tiwai@suse.de> <20171215165125.avkz25eek56i5md4@localhost>
 <s5h4lorx6ha.wl-tiwai@suse.de>
 <b0d5ff40-fbfe-e5b3-2844-7d930484e87f@intel.com>
 <20171228164944.crphv46zegvwautk@localhost>
 <1a9a1507-7ca3-459b-c2ce-02fc2afad2ff@intel.com>
 <3c5734a2-8f97-4a8b-26d4-42852cc86352@linux.intel.com>
 <20180102182146.vbfnihz73lhgf6lc@localhost>
 <9f09abee-68b8-4515-131f-0f3e210503b0@linux.intel.com>
 <d3e83230-dc06-fc2b-b507-723d4863fb4e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3e83230-dc06-fc2b-b507-723d4863fb4e@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Arun Kamble <sagar.a.kamble@intel.com>, Richard Cochran <richardcochran@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

On 1/5/18 4:06 AM, Sagar Arun Kamble wrote:
> 
> 
> On 1/3/2018 1:23 AM, Pierre-Louis Bossart wrote:
>> On 1/2/18 12:21 PM, Richard Cochran wrote:
>>> On Tue, Jan 02, 2018 at 11:15:45AM -0600, Pierre-Louis Bossart wrote:
>>>> I wrote the code for HDaudio and I remember wasting time trying to 
>>>> figure
>>>> out the gory details of the cycle counter stuff when all I wanted was a
>>>> conversion from a 24MHz counter to ns values using a 125/3 operation 
>>>> in the
>>>> right order - as explained in the comments
>>>
>>> Would using clocks_calc_mult_shift() work for you?
>>
>> In theory yes, but I'd need to re-check what the results would be.
>> I remember applying the 1/3 factor separately to avoid wrap-around 
>> after 4 hours [1], but I can't remember the details on the analysis. I 
>> can't figure out what the 'maxsec' argument should be either.
>>
> I am not sure if I understood the wrap-around correctly. Is 
> AZX_REG_WALL_CLK 64bit or 32bit and in the comments which 20 bits are 
> being referred.

it's a 32-bit counter.
off the top of my head, the idea was that the integer arithmetic should 
not degrade the precision (42ns) and that means you need to be careful 
with the fractional part, especially if the errors with the fractional 
part accumulate over time (I think this was the case when I looked 
several years ago). That's the main reason why I did the division by 3 
last, after the read, so that the precision is not impacted by the 
interval between two reads.

You also need to be careful with the multiplication factor otherwise you 
will exceed the 64-bit resolution. For example with the 14400 factor, 
you cannot handle a counter larger than 2^64/14400, which gives you 
14826 hours or 1.69 years. It's one of those 'nobody will ever need more 
than 640KB' value. The 125 factor gives you 195 years without saturating.

> 
> Keeping maxsec at lower value will ensure good precision but the mult 
> factor derived then might lead to overflow if the interval of counter 
> read is big.
> Keeping maxsec high will reduce the mult factor and will marginally 
> impact the precision (of the order of 6 decimal places of fraction nano 
> second).
> 
> For 24mhz clock I am getting following scale factors at different maxsec 
> values. I think these are as good as 125/3
> 125/3 gives scale factor of 41.666666666666666666666666666667
> 
> maxsec, mult, shift, scale factor (mult/(2^shift))
> 0, 2796202667, 26,     41.66666667163372039794921875
> 3600, 87381333, 21,   41.666666507720947265625
> 14400, 21845333, 19, 41.6666660308837890625
> 
> I see sound driver uses only timecounter_read so conversions should be 
> fine.
> If there are usages of timecounter_cyc2time then we will have to take 
> care of updating the timecounter often as
> timecounter API internally counts time backwards if counter is spaced 
> more than 1/2 the range.
> 
> Thanks
> Sagar
>> [1] 
>> http://elixir.free-electrons.com/linux/latest/source/sound/hda/hdac_stream.c#L486 
>>
> 
