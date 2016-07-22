From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 2/2] topology: Fix the missing
 referenced elem ptr when merging private data
Date: Fri, 22 Jul 2016 12:28:11 +0900
Message-ID: <579192CB.4030505@sakamocchi.jp>
References: <cover.1469151453.git.mengdong.lin@linux.intel.com>
 <7d8df59aab4a6935f4d3c7ca1c6955a2ff0e8d20.1469151453.git.mengdong.lin@linux.intel.com>
 <579181F5.3090206@sakamocchi.jp>
 <F46914AEC2663F4A9BB62374E5EEF8F84BA872AD@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 030D82654B2
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 05:28:13 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84BA872AD@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Jul 22 2016 11:39, Lin, Mengdong wrote:
>> -----Original Message-----
>> From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp]
>> Sent: Friday, July 22, 2016 10:16 AM
>> To: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
>> broonie@kernel.org
>> Cc: tiwai@suse.de; Lin, Mengdong; Girdwood, Liam R; Nc, Shreyas
>> Subject: Re: [PATCH v2 2/2] topology: Fix the missing referenced elem ptr
>> when merging private data
>>
>> On Jul 22 2016 10:47, mengdong.lin@linux.intel.com wrote:
>>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>
>>> tplg_copy_data() should set the valid referenced data element pointer
>>> on success. The caller will double check this pointer for all kinds of
>>> references, including controls and data.
>>>
>>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>
>>> diff --git a/src/topology/data.c b/src/topology/data.c index
>>> 768fc27..e7793b2 100644
>>> --- a/src/topology/data.c
>>> +++ b/src/topology/data.c
>>> @@ -1078,6 +1078,8 @@ int tplg_copy_data(snd_tplg_t *tplg, struct
>> tplg_elem *elem,
>>>    	ref_elem->compound_elem = 1;
>>>    	memcpy(priv->data + old_priv_data_size,
>>>    	       ref_elem->data->data, priv_data_size);
>>> +
>>> +	ref->elem = ref_elem;
>>>    	return 0;
>>>    }
>>
>> Is this really OK when the found topology element has no private data?
>> In this case, ref->elem has no assignment at return.
>
> No. This is my mistake. Thanks for finding this bug.
>
> ref->elem should still be assigned for this case. I will make it like this:
>
> /* overlook empty private data */
> if (!ref_elem->data || !ref_elem->data->size) {
> 		ref->elem = ref_elem;
>           return 0;
> }

Let us split data merging code to an explicit function? Then:

if (ref_elem->data != NULL && ref_elem->data->size > 0) {
     err = merge_private_data(elem, ref_elem);
     if (err < 0)
         return err;
}
ref->elem = ref_elem;
return 0;

(Here, I expect compiler optimization to merge the new function to 
caller implicitly.)


Regards

Takashi Sakamoto
