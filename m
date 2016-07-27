From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 2/2] topology: Fix the missing
 referenced elem ptr when merging private data
Date: Wed, 27 Jul 2016 16:57:36 +0800
Message-ID: <57987780.9070005@linux.intel.com>
References: <cover.1469151453.git.mengdong.lin@linux.intel.com>
 <7d8df59aab4a6935f4d3c7ca1c6955a2ff0e8d20.1469151453.git.mengdong.lin@linux.intel.com>
 <579181F5.3090206@sakamocchi.jp>
 <F46914AEC2663F4A9BB62374E5EEF8F84BA872AD@shsmsx102.ccr.corp.intel.com>
 <579192CB.4030505@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AE21265312
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 10:52:33 +0200 (CEST)
In-Reply-To: <579192CB.4030505@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I submitted a new v4 patch to solve this issue, which will return 
-EINVAL right after a failure to find an element's reference. I hope 
will make the code more clear to read. So there is no need to modify 
tplg_copy_data() now, checking its return value is enough.

The new patch name is [PATCH v4] topology: Return -EINVAL at once on 
failure to find a reference. Please review.

Thanks
Mengdong

On 07/22/2016 11:28 AM, Takashi Sakamoto wrote:
> On Jul 22 2016 11:39, Lin, Mengdong wrote:
>>> -----Original Message-----
>>> From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp]
>>> Sent: Friday, July 22, 2016 10:16 AM
>>> To: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
>>> broonie@kernel.org
>>> Cc: tiwai@suse.de; Lin, Mengdong; Girdwood, Liam R; Nc, Shreyas
>>> Subject: Re: [PATCH v2 2/2] topology: Fix the missing referenced elem
>>> ptr
>>> when merging private data
>>>
>>> On Jul 22 2016 10:47, mengdong.lin@linux.intel.com wrote:
>>>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>>
>>>> tplg_copy_data() should set the valid referenced data element pointer
>>>> on success. The caller will double check this pointer for all kinds of
>>>> references, including controls and data.
>>>>
>>>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>>
>>>> diff --git a/src/topology/data.c b/src/topology/data.c index
>>>> 768fc27..e7793b2 100644
>>>> --- a/src/topology/data.c
>>>> +++ b/src/topology/data.c
>>>> @@ -1078,6 +1078,8 @@ int tplg_copy_data(snd_tplg_t *tplg, struct
>>> tplg_elem *elem,
>>>>        ref_elem->compound_elem = 1;
>>>>        memcpy(priv->data + old_priv_data_size,
>>>>               ref_elem->data->data, priv_data_size);
>>>> +
>>>> +    ref->elem = ref_elem;
>>>>        return 0;
>>>>    }
>>>
>>> Is this really OK when the found topology element has no private data?
>>> In this case, ref->elem has no assignment at return.
>>
>> No. This is my mistake. Thanks for finding this bug.
>>
>> ref->elem should still be assigned for this case. I will make it like
>> this:
>>
>> /* overlook empty private data */
>> if (!ref_elem->data || !ref_elem->data->size) {
>>         ref->elem = ref_elem;
>>           return 0;
>> }
>
> Let us split data merging code to an explicit function? Then:
>
> if (ref_elem->data != NULL && ref_elem->data->size > 0) {
>      err = merge_private_data(elem, ref_elem);
>      if (err < 0)
>          return err;
> }
> ref->elem = ref_elem;
> return 0;
>
> (Here, I expect compiler optimization to merge the new function to
> caller implicitly.)
>
>
> Regards
>
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
