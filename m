From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Tue, 31 Jul 2018 14:36:59 +0530
Message-ID: <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de> <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com> <s5hwotc0y6v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0060.outbound.protection.outlook.com [104.47.37.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 330482676E2
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 11:07:24 +0200 (CEST)
In-Reply-To: <s5hwotc0y6v.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On 7/31/2018 11:00 AM, Takashi Iwai wrote:
> On Tue, 31 Jul 2018 03:25:06 +0200,
> Agrawal, Akshu wrote:
>>
>>
>>
>> On 7/30/2018 9:20 PM, Mark Brown wrote:
>>> On Mon, Jul 30, 2018 at 05:32:21PM +0200, Takashi Iwai wrote:
>>>
>>>> That said, if delay callback of CPU dai provides the additional delay,
>>>> the patch does correct thing.  OTOH, if CPU dai provides the base
>>>> delay instead, we need to clarify that it's rather a must; the delay
>>>> calculation in pointer callback becomes bogus in this scenario.
>>>
>>> Part of the theory here is that every component might have a delay
>>> independently of the rest and we need to add them all together to figure
>>> out what the system as a whole will see.  Personally I'd rather just
>>> have everything use a callack consistently to avoid confusion.
>>>
>>
>> For consistency we can add a delay callback in snd_pcm_ops and modify
>> the drivers which directly assigning runtime->delay to use the callback.
> 
> No, ALSA PCM ops definition is fine.  The delay calculation is
> basically tied with the position, hence it has to be set together, and
> that's the pointer callback.
> 
> Judging from the call pattern, the current design of ASoC delay
> callback implies that the return value is more or less constant, which
> can be accumulated on top of the base value.  So your patch is natural
> from that POV.
> 
> OTOH, if the CPU dai can really provide a dynamic value that is
> strictly tied with pointer, CPU dai itself should provide the pointer
> callback that covers both the pointer and the base delay, and it
> should be used instead of component pointer callback.
> 

Not sure if all cpu dai can provide the base delay and thus require
component pointer callback for it. For example, in case of AMD, it uses
designware cpu dai which is a common code.

>> Apart from the 2 drivers mentioned in commit message I also found
>> sound/usb to be doing the same and its delay getting lost.
> 
> The USB driver hasn't been used in ASoC, no?
> 

Don't know, was looking who all might have been impacted by this.

Thanks,
Akshu
