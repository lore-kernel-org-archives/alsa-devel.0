From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: control: add dimension validator
 for userspace element
Date: Sat, 30 May 2015 11:08:36 +0900
Message-ID: <55691BA4.40601@sakamocchi.jp>
References: <1432889937-15413-1-git-send-email-o-takashi@sakamocchi.jp>
 <1432889937-15413-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5h617b7mlm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 1289E2669B8
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 04:08:40 +0200 (CEST)
In-Reply-To: <s5h617b7mlm.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 29 2015 18:35, Takashi Iwai wrote:
> At Fri, 29 May 2015 17:58:56 +0900,
> Takashi Sakamoto wrote:
>>
>> The 'dimen' field in struct snd_ctl_elem_info is used to compose
>> all of channels in the control element as multi-dimensional matrix.
>> The field has four members. Each member represents the number in
>> each dimension level. For example, if the channels consist of typical
>> two dimensional matrix, the dimen[0] represents the number of rows
>> and dimen[1] represents the number of columns, or vise-versa.
>>
>> The total elements in the matrix should be within the number of
>> channels in the control element, while current implementation has
>> no validator of this information. In a view of userspace applications,
>> the information must be valid so that it cannot cause any bugs such as
>> buffer-over-run.
>>
>> This commit adds a validator of dimen information for userspace
>> applications which add new control elements. When they add the elements
>> with wrong dimen information, they receive EINVAL.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/core/control.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/sound/core/control.c b/sound/core/control.c
>> index 196a6fe..9b77afd 100644
>> --- a/sound/core/control.c
>> +++ b/sound/core/control.c
>> @@ -805,6 +805,25 @@ static int snd_ctl_elem_list(struct snd_card *card,
>>  	return 0;
>>  }
>>  
>> +static bool validate_dimen(struct snd_ctl_elem_info *info)
>> +{
>> +	unsigned int elements;
>> +	unsigned int i;
>> +
>> +	/*
>> +	 * When drivers don't use dimen field, this value is zero and pass the
>> +	 * validation. Else, calculated number of elements is validated.
>> +	 */
>> +	elements = info->dimen.d[0];
>> +	for (i = 1; i < ARRAY_SIZE(info->dimen.d); ++i) {
>> +		if (info->dimen.d[i] == 0)
>> +			break;
> 
> It'd be better to have a value sanity check, also for avoiding an
> overflow.  A simple one like below should suffice:
> 
> 	if (info->dimens.d[i] > info->count)
> 		return false;

Indeed, thanks.

>> +		elements *= info->dimen.d[i];
>> +	}
>> +
>> +	return elements <= info->count;
>> +}
>> +
>>  static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
>>  			     struct snd_ctl_elem_info *info)
>>  {
>> @@ -1272,6 +1291,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>>  	if (info->count < 1 ||
>>  	    info->count > max_value_counts[info->type])
>>  		return -EINVAL;
>> +	if (!validate_dimen(info))
>> +		return -EINVAL;
>>  	private_size = value_sizes[info->type] * info->count;
>>  
>>  	/*
>> -- 
>> 2.1.4

Takashi Sakamoto
