From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 6/7] topology: Add support for parsing
 vendor tuples
Date: Wed, 30 Mar 2016 15:15:52 +0800
Message-ID: <56FB7D28.5010504@linux.intel.com>
References: <cover.1458788076.git.mengdong.lin@linux.intel.com>
 <ea484928ce467eb5c4b1b105fa9311b1d42cbbee.1458788076.git.mengdong.lin@linux.intel.com>
 <s5hlh512wzi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 306DB265A6C
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 09:13:39 +0200 (CEST)
In-Reply-To: <s5hlh512wzi.wl-tiwai@suse.de>
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



On 03/29/2016 10:13 PM, Takashi Iwai wrote:
> On Thu, 24 Mar 2016 04:07:36 +0100,
> mengdong.lin@linux.intel.com wrote:
>>
>> +static int parse_tuple_set(snd_tplg_t *tplg, snd_config_t *cfg,
>> +	struct tplg_tuple_set **s)
> ....
>> +		switch (type) {
>> +		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
>> +			memcpy(tuple->uuid, value, 16);
>
> This may become out-of-bound access.  Check the size of value string
> beforehand.

I'll fix this in v2.

>
>> +			tplg_dbg("\t\t%s = %s\n", tuple->token, tuple->uuid);
>> +			break;
>> +
>> +		case SND_SOC_TPLG_TUPLE_TYPE_STRING:
>> +			elem_copy_text(tuple->string, value,
>> +				SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
>> +			tplg_dbg("\t\t%s = %s\n", tuple->token, tuple->string);
>> +			break;
>> +
>> +		case SND_SOC_TPLG_TUPLE_TYPE_BOOL:
>> +			if (strcmp(value, "true") == 0)
>> +				tuple->value = 1;
>> +			tplg_dbg("\t\t%s = %d\n", tuple->token, tuple->value);
>> +			break;
>> +
>> +		case SND_SOC_TPLG_TUPLE_TYPE_BYTE:
>> +		case SND_SOC_TPLG_TUPLE_TYPE_SHORT:
>> +		case SND_SOC_TPLG_TUPLE_TYPE_WORD:
>> +			tuple->value = atoi(value);
>
> atoi() isn't good enough.  It can't handle a hex number, for example,
> and can't give an error.

Sorry. I missed this. I'll use strtol() to handle the data and check on 
the return value.

>> +/* Free handler of tuples */
>> +void tplg_free_tuples(void *obj)
>> +{
>> +	struct tplg_vendor_tuples *tuples = (struct tplg_vendor_tuples *)obj;
>> +	int i;
>> +
>> +	if (!tuples)
>> +		return;
>> +
>> +	for (i = 0; i < tuples->num_sets; i++)
>> +		free(tuples->set[i]);
>> +}
>
> tuples->set itself isn't freed?

This a memory leak. I'll fix this.

Thanks again for your review. I've sent out v2 with the fixes.

Regards
Mengdong
