From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: intel: filter SoundWire
 controller device search
Date: Wed, 8 May 2019 11:20:10 -0500
Message-ID: <a6b3f1d1-c815-3c6b-7f35-ac5cc98960b2@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
 <20190507122651.GO16052@vkoul-mobl>
 <47fd3ca6-6910-f101-9b63-f653cd1443f9@linux.intel.com>
 <20190508050853.GT16052@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81465F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 18:20:14 +0200 (CEST)
In-Reply-To: <20190508050853.GT16052@vkoul-mobl>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> +	/*
>>>> +	 * On some Intel platforms, multiple children of the HDAS
>>>> +	 * device can be found, but only one of them is the SoundWire
>>>> +	 * controller. The SNDW device is always exposed with
>>>> +	 * Name(_ADR, 0x40000000) so filter accordingly
>>>> +	 */
>>>> +	if (adr != 0x40000000)
>>>
>>> I do not recall if 4 corresponds to the links you have or soundwire
>>> device type, is this number documented somewhere is HDA specs?
>>
>> I thought it was a magic number, but I did check and for once it's
>> documented and the values match the spec :-)
>> I see in the ACPI docs bits 31..28 set to 4 indicate a SoundWire Link Type
>> and bits 3..0 indicate the SoundWire controller instance, the rest is
>> reserved to zero.
> 
> So in that case we should mask with bits 31..28 and match, who knows you
> may have multiple controller instances in future

yes, I was planning on only using the link type.

> I had a vague recollection that this was documented in the spec, glad
> that in turned out to be the case.
> 
> Btw was the update to HDA spec made public?

Not that I know of. The previous NHLT public doc has actually 
disappeared from the Intel site and I can't find it any longer, so 
currently the amount of public documentation is trending to zero :-(

> 
>>> Also it might good to create a define for this
>>
>> I will respin this one to add the documentation above, and only filter on
>> the 4 ms-bits. Thanks for forcing me to RTFM :-)
> 
