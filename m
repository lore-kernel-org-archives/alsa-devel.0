From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: adau1701: Reset codec based on
	sample rate changes
Date: Thu, 24 Mar 2016 17:48:26 +0100
Message-ID: <56F41A5A.6030605@gmail.com>
References: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
 <56F29DCB.2090208@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 97DD8265B5B
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 17:48:27 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id s187so4656864wme.2
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 09:48:27 -0700 (PDT)
In-Reply-To: <56F29DCB.2090208@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 23.03.2016 14:44, Lars-Peter Clausen wrote:
> On 03/23/2016 12:58 PM, pascal.huerst@gmail.com wrote:
>> From: Pascal Huerst <pascal.huerst@gmail.com>
>>
>> Instead of checking if mclk/lrclk ratio has changed, check if
>> sample rate has changed. In certain cases, the mclk might be
>> changed in the machine driver, which can lead to the same
>> mclk/lrclk ration, eventhow the sample rate has changed.
>>
>> Since the codec has to be programmed differently for every
>> sample rate, its better to check for samplerate changes instead
>> of mclk/lrclk ration changes.
> 
> Mark's comment made me give this some additional though. Do we actually
> need to reset the device if the clkdiv did not change. Stopping the DSP,
> uploading the new firmware and then restarting it should be sufficient.
> But on the other hand the time the reset takes should be negligible
> compared to programming the firmware, so it might be ok to always do it.
> Let me know what you think.

Ok, I see your point. So I did some measurements.

On our devices,

a firmware download takes about: 844ms
Resetting the pll settings takes about: 87ms

I'm not sure, if this worth the effort, but certainly it could be done.
I would probably leave it for now, be a bit more precise in the comment
above and add a note to the commit message, as Mark suggested (?)

While at it I also saw, that we should keep the reset line low, while
changing the pll settings. (Which we don't right now)

The datasheet states:

... "The state of the PLL_MODEx pins should be changed while RESET is
held low." ...
