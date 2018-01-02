From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Subject: Re: [alsa-devel] [PATCH 15/27] ALSA: hda - Use timecounter_initialize
 interface
Date: Tue, 2 Jan 2018 11:33:41 +0530
Message-ID: <1a9a1507-7ca3-459b-c2ce-02fc2afad2ff@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
 <s5hh8ssgsaw.wl-tiwai@suse.de> <20171215165125.avkz25eek56i5md4@localhost>
 <s5h4lorx6ha.wl-tiwai@suse.de>
 <b0d5ff40-fbfe-e5b3-2844-7d930484e87f@intel.com>
 <20171228164944.crphv46zegvwautk@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228164944.crphv46zegvwautk@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org



On 12/28/2017 10:19 PM, Richard Cochran wrote:
> On Tue, Dec 26, 2017 at 01:07:35PM +0530, Sagar Arun Kamble wrote:
>>> Or can we provide simpler versions for covering some defaults?  At
>>> least reducing the number of arguments would make things easier.
>> Thought about specifying 1. cyclecounter read func 2. frequency 3. width of
>> counter as parameters here
>> which can get rid of mult, shift params. But this is not easy as most of the
>> drivers do not specify
>> cyclecounter frequency and instead hard-code the mult/shift factors.
> You are talking about using clocks_calc_mult_shift() here, right? (See
> the usage example in drivers/net/ethernet/ti/cpts.c).
Yes
> This is a good idea, and it is worth getting the driver authors' input
> to figure out the correct parameters.
>
> I bet we can use that almost everywhere.  If there are any drivers
> that cannot be converted, then we can leave some sort of low level
> legacy initialization method.
Agree
> Thanks,
> Richard
>
