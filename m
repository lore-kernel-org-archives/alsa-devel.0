From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 6/7] topology: Add support for parsing
 vendor tuples
Date: Tue, 5 Apr 2016 13:47:08 +0800
Message-ID: <5703515C.3070506@linux.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
 <6ceb0ce804d89c8d9cac5a1c80f1364041a8590f.1459321387.git.mengdong.lin@linux.intel.com>
 <s5hvb44770c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C55C2608CF
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 07:44:47 +0200 (CEST)
In-Reply-To: <s5hvb44770c.wl-tiwai@suse.de>
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



On 03/30/2016 03:35 PM, Takashi Iwai wrote:
> On Wed, 30 Mar 2016 09:11:17 +0200,
> mengdong.lin@linux.intel.com wrote:
>>
>> +		switch (type) {
>> +		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
>> +			len = strlen(value);
>> +			if (len > 16 || len == 0) {
>> +				SNDERR("error: tuple %s: invalid uuid\n", id);
>> +				goto err;
>> +			}
>> +
>> +			memcpy(tuple->uuid, value, 16);
>
> This may still overflow :)
> How about simply using elem_copy_text()?

Sorry for the late reply.

Would you mind me using uuid_parse() here?
It can convert an input UUID string into the binary representation.

An UUID string link "1b4e28ba-2fa1-11d2-883f-b9a761bde3fb" is user 
friendly for the text conf file. But this will add dependency on libuuid.

>
>> +		case SND_SOC_TPLG_TUPLE_TYPE_BYTE:
>> +		case SND_SOC_TPLG_TUPLE_TYPE_SHORT:
>> +		case SND_SOC_TPLG_TUPLE_TYPE_WORD:
>> +			tuple_val = strtol(value, NULL, 0);
>> +			if (tuple_val == LONG_MIN || tuple_val == LONG_MAX
>> +				|| (type == SND_SOC_TPLG_TUPLE_TYPE_WORD
>> +					&& tuple_val > 0xffffffff)
>
> Is the check correct on 32bit architecture?

I'll test on 32 bit machine and will use UINT/USHRT/UCHAR_MAX for range 
here.

>> +				|| (type == SND_SOC_TPLG_TUPLE_TYPE_SHORT
>> +					&& tuple_val > 0xffff)
>> +				|| (type == SND_SOC_TPLG_TUPLE_TYPE_BYTE
>> +					&& tuple_val > 0xff)) {
>
> Also, what about negative values?

I will add check, we don't expect to have negative value here.

Thanks again for your review.

Regards
Mengdong

>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
