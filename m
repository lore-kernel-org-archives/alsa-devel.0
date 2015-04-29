From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 6/7] ASoC: hda: Add support for SSP register
 settings
Date: Wed, 29 Apr 2015 18:50:14 -0500
Message-ID: <55416E36.7090208@linux.intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
 <20150424175532.GD22845@sirena.org.uk> <20150426141831.GS2738@intel.com>
 <20150427141509.GS22845@sirena.org.uk> <55416D07.6060204@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C3A92606E8
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 01:50:17 +0200 (CEST)
In-Reply-To: <55416D07.6060204@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>>> +        /* Dont add odd number of dummy bits, since I2S requires
>>>>> +         * dummy bit after each slot/channel
>>>>> +         */
>>
>>>> It does?
>>
>>> For us unfortuntely yes. We send 24 bit audio to codec and clock divider
>>> doesn't give us 48clocks per frame, so we have to add dummy clocks in
>>> each
>>> slot and send 25 clocks per slot
>>
>> So it's the hardware rather than I2S itself :)
>
> It depends on the clock reference used to drive the SSP. With a 19.2
> reference we typically divide by 50 and pad with a trailing bit.
>
> That said I am not sure how this code would work on SKL. Vinod, isn't
> this for BXT only? how do you get 19.2 on SKL, shouldn't you guys use a
> 24 MHz root frequency to find the divider?

And regardless you should make sure that the actual blck does not exceed 
the maximum serial bit-rate supported by the SOC (AC timing).
