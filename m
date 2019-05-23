From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 12/12] ASoC: SOF: Intel: hda-codec: fix
 memory allocation
Date: Thu, 23 May 2019 06:35:05 -0500
Message-ID: <31702c41-aef4-712a-d11b-ee44e446a6cb@linux.intel.com>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
 <20190522162142.11525-13-pierre-louis.bossart@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D195284169B@SHSMSX103.ccr.corp.intel.com>
 <s5hr28pfux1.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19528416F0@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A840EF89625
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 13:35:07 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D19528416F0@SHSMSX103.ccr.corp.intel.com>
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
To: "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 5/23/19 3:24 AM, Yang, Libin wrote:
> Hi Takashi,
> 
> 
>>> -----Original Message-----
>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>> Sent: Thursday, May 23, 2019 4:16 PM
>>> To: Yang, Libin <libin.yang@intel.com>
>>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; alsa-
>>> devel@alsa-project.org; broonie@kernel.org
>>> Subject: Re: [alsa-devel] [PATCH v2 12/12] ASoC: SOF: Intel: hda-codec:
>>> fix memory allocation
>>>
>>> On Thu, 23 May 2019 10:03:03 +0200,
>>> Yang, Libin wrote:
>>>>
>>>> Please let me describe the issue here.
>>>>
>>>> The test case is:
>>>> 1) Unload module with script "sudo ./sof_remove.sh" ,
>>>> 2) reload module with script "sudo ./sof_insert.sh"
>>>>
>>>> After several rounds of removing and inserting kernel modules, system
>>>> will complain like below:
>>>> "BUG: unable to handle kernel paging request at 000000292a282031"
>>>
>>> Did you try some kernel debug options?  It might show what went wrong.
>>
>> No, I haven't. I'm not sure which options I can use for this case. Could you
>> please give me some suggestions?
> 
> BTW: I have enabled DEBUG_DEVRES. Are there any other options I can try?

There are already a set of kconfig fragments for debug, see 
https://github.com/thesofproject/kconfig and select memory-debug-defconfig.

I guess I will need to require this test in the SOF CI, I really don't 
get how this issue was not seen earlier. Gah.
