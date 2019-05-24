From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2 12/12] ASoC: SOF: Intel: hda-codec: fix
 memory allocation
Date: Fri, 24 May 2019 01:10:48 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952841DCB@SHSMSX103.ccr.corp.intel.com>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
 <20190522162142.11525-13-pierre-louis.bossart@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D195284169B@SHSMSX103.ccr.corp.intel.com>
 <s5hr28pfux1.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19528416F0@SHSMSX103.ccr.corp.intel.com>
 <31702c41-aef4-712a-d11b-ee44e446a6cb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A17A6F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 03:10:52 +0200 (CEST)
In-Reply-To: <31702c41-aef4-712a-d11b-ee44e446a6cb@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Peirre,

>>>>
>>>> On Thu, 23 May 2019 10:03:03 +0200,
>>>> Yang, Libin wrote:
>>>>>
>>>>> Please let me describe the issue here.
>>>>>
>>>>> The test case is:
>>>>> 1) Unload module with script "sudo ./sof_remove.sh" ,
>>>>> 2) reload module with script "sudo ./sof_insert.sh"
>>>>>
>>>>> After several rounds of removing and inserting kernel modules,
>>>>> system will complain like below:
>>>>> "BUG: unable to handle kernel paging request at 000000292a282031"
>>>>
>>>> Did you try some kernel debug options?  It might show what went wrong.
>>>
>>> No, I haven't. I'm not sure which options I can use for this case.
>>> Could you please give me some suggestions?
>>
>> BTW: I have enabled DEBUG_DEVRES. Are there any other options I can try?
>
>There are already a set of kconfig fragments for debug, see
>https://github.com/thesofproject/kconfig and select memory-debug-defconfig.
>
>I guess I will need to require this test in the SOF CI, I really don't get how this
>issue was not seen earlier. Gah.

This bug can't be reproduced easily sometimes. Sometimes, the bug will be hit 
at the second or third round of the test. And sometimes, we need do more 
rounds to reproduce this bug. This may be the reason we didn't hit this bug before.

Regards,
Libin
