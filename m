From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: correct 5640's device ID
Date: Mon, 05 May 2014 10:14:07 -0600
Message-ID: <5367B8CF.7020408@wwwdotorg.org>
References: <1398838125-13546-1-git-send-email-bardliao@realtek.com>
 <5361203C.7000503@wwwdotorg.org>
 <ABFD875FF5FB574BA706497D987D48D73D6249@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A4232610D4
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 18:14:12 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73D6249@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 05/04/2014 09:36 PM, Bard Liao wrote:
>> -----Original Message-----
>> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
>> Sent: Thursday, May 01, 2014 12:10 AM
>> To: Bard Liao; broonie@kernel.org; lgirdwood@gmail.com
>> Cc: alsa-devel@alsa-project.org; lars@metafoo.de; Flove; Oder Chiou
>> Subject: Re: [PATCH] ASoC: rt5640: correct 5640's device ID
>>
>> On 04/30/2014 12:08 AM, bardliao@realtek.com wrote:
>>> From: Bard Liao <bardliao@realtek.com>
>>>
>>> This patch correct rt5640's device ID
>>>
>>> Signed-off-by: Bard Liao <bardliao@realtek.com>
>>> ---
>>> We will send another patch to fix the issue about the "Failed to add route"
>>> error.
>>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>>
>> (On NVIDIA Tegra Beaver/RT5640, Dalmore/RT5640, Jetson TK1/RT5639)
>>
>> Note that this patch alone (on top of next-20140429) completely eliminates any of
>> the "failed to add route" errors that I mentioned earlier, although perhaps there's
>> still a need to investigate why they happened.
>>
> 
> The "failed to add route" errors is coming from we didn't handle a default case when
> determining which codec is attached. As a result, no _dapm_new_controls is called.
> That's why once we can determine codecs properly, the errors will be gone.
> Actually, there are only three possible ID values, and all of them are in the switch cases now.
> So, I am thinking if we need to add a default case to handle unexpected cases.

Ah, that makes sense.

It's probably worth adding a default case, so that a meaningful error
message can be printed e.g. if the I2C read of the ID register gets
corrupted, or someone tries to use the driver on a chip that isn't (yet)
supported by it.
