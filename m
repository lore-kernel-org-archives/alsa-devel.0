From: Rong Chen <rong.a.chen@intel.com>
Subject: Re: [kbuild-all] [PATCH] fix odd_ptr_err.cocci warnings
Date: Tue, 20 Aug 2019 16:41:02 +0800
Message-ID: <297e44a8-e08d-ddf2-e5e8-b532965b4a8d@intel.com>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
 <20190809123112.GC3963@sirena.co.uk>
 <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
 <alpine.DEB.2.21.1908091519400.2946@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1908091519400.2946@hadrien>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

We have updated to only send the reports to you, please see 
https://github.com/intel/lkp-tests/blob/master/repo/linux/omap-audio

Best Regards,
Rong Chen

On 8/9/19 9:21 PM, Julia Lawall wrote:
>
> On Fri, 9 Aug 2019, Peter Ujfalusi wrote:
>
>>
>> On 09/08/2019 15.31, Mark Brown wrote:
>>> On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:
>>>
>>>> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/wip
>>>> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
>>>> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machine driver wip
>>>> :::::: branch date: 20 hours ago
>>>> :::::: commit date: 20 hours ago
>>>>
>>>>   j721e-evm.c |    4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> --- a/sound/soc/ti/j721e-evm.c
>>>> +++ b/sound/soc/ti/j721e-evm.c
>>>> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf
>>> This file isn't upstream, it's only in the TI BSP.
>> Yes, it is not upstream, but the fix is valid.
>>
>> Julia: is it possible to direct these notifications only to me from
>> https://github.com/omap-audio/linux-audio.git ?
>>
>> It mostly carries TI BSP stuff and my various for upstream branches nowdays.
> Please discuss it with the kbuild people.  They should be able to set it
> up as you want.
>
> You can try lkp@intel.com
>
> julia
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
