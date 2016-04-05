From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 6/7] topology: Add support for parsing
 vendor tuples
Date: Tue, 5 Apr 2016 16:53:24 +0800
Message-ID: <57037D04.20604@linux.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
 <6ceb0ce804d89c8d9cac5a1c80f1364041a8590f.1459321387.git.mengdong.lin@linux.intel.com>
 <s5hvb44770c.wl-tiwai@suse.de> <5703515C.3070506@linux.intel.com>
 <s5hegakzinu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 49BDC264F02
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 10:51:03 +0200 (CEST)
In-Reply-To: <s5hegakzinu.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


On 04/05/2016 02:14 PM, Takashi Iwai wrote:
> On Tue, 05 Apr 2016 07:47:08 +0200,
> Mengdong Lin wrote:
>>
>>
>>
>> On 03/30/2016 03:35 PM, Takashi Iwai wrote:
>>> On Wed, 30 Mar 2016 09:11:17 +0200,
>>> mengdong.lin@linux.intel.com wrote:
>>>>
>>>> +		switch (type) {
>>>> +		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
>>>> +			len = strlen(value);
>>>> +			if (len > 16 || len == 0) {
>>>> +				SNDERR("error: tuple %s: invalid uuid\n", id);
>>>> +				goto err;
>>>> +			}
>>>> +
>>>> +			memcpy(tuple->uuid, value, 16);
>>>
>>> This may still overflow :)
>>> How about simply using elem_copy_text()?
>>
>> Sorry for the late reply.
>>
>> Would you mind me using uuid_parse() here?
>> It can convert an input UUID string into the binary representation.
>>
>> An UUID string link "1b4e28ba-2fa1-11d2-883f-b9a761bde3fb" is user
>> friendly for the text conf file. But this will add dependency on libuuid.
>
> Additional dependency is no-go, especially when the required change is
> so trivial.  It's just a string copy, after all.
>

Maybe we can just use strncpy(dest, src, 16), assuming the strncpy will 
not try to write a "\0" at dest[16] that may cause overflow?

The user need to define uuid without "-" in the UUID string in the text 
conf file.

Now the uuid value in ABI is 16-character array:

/* vendor tuple for uuid */
struct snd_soc_tplg_vendor_uuid_elem {
	__le32 token;
	char uuid[16];
} __attribute__((packed));

The last byte of UUID may not be zero.

Thanks
Mengdong
