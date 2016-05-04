From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 3/6] topology: Use generic pointer to
 realloc buffer for private data
Date: Wed, 4 May 2016 09:29:33 +0800
Message-ID: <5729507D.2010400@linux.intel.com>
References: <cover.1461831763.git.mengdong.lin@linux.intel.com>
 <1dd0f08c152af476e3a5af48ce7de97cd759616a.1461831763.git.mengdong.lin@linux.intel.com>
 <5721CE64.4060803@perex.cz> <s5h7ffhu9bu.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F84BA01739@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9BB2604D6
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 03:26:47 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84BA01739@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: "Shah, Hardik T" <hardik.t.shah@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 04/28/2016 10:30 PM, Lin, Mengdong wrote:
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Thursday, April 28, 2016 9:55 PM
>> To: Jaroslav Kysela
>> Cc: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
>> broonie@kernel.org; Girdwood, Liam R; Lin, Mengdong; Shah, Hardik T; Singh,
>> Guneshwor O
>> Subject: Re: [PATCH 3/6] topology: Use generic pointer to realloc buffer for
>> private data
>>
>> On Thu, 28 Apr 2016 10:48:36 +0200,
>> Jaroslav Kysela wrote:
>>>
>>> Dne 28.4.2016 v 10:41 mengdong.lin@linux.intel.com napsal(a):
>>>>   	priv_data_size = ref->data->size;
>>>> +	elem->obj = realloc(elem->obj,
>>>> +			elem->size + priv_data_size);
>>>> +	if (!elem->obj)
>>>> +		return -ENOMEM;
>>>
>>> This causes a memory leak when realloc fails. You should free the
>>> original pointer when realloc() fails.
>>
>> Right, and the bug (the leak) has been already present before the patch...
>>
>
> Okay, we'll fix this. Thanks for pointing out this.
>

I fixed this issue in v2 series. Would you please have a review?


Thanks again
Mengdong
