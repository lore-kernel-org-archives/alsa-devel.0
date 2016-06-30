From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: control: add dimension validator
 for userspace element
Date: Fri, 1 Jul 2016 06:34:45 +0900
Message-ID: <57759075.4040501@sakamocchi.jp>
References: <1467295485-5335-1-git-send-email-o-takashi@sakamocchi.jp>
 <1467295485-5335-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5hmvm2d8tb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0EC8C2651DB
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 23:34:50 +0200 (CEST)
In-Reply-To: <s5hmvm2d8tb.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 30 2016 23:56, Takashi Iwai wrote:
> On Thu, 30 Jun 2016 16:04:44 +0200,
> Takashi Sakamoto wrote:
>>
>> The 'dimen' field in struct snd_ctl_elem_info is used to compose all of
>> members in the element as multi-dimensional matrix. The field has four
>> members. Each member represents the width in each dimension level by
>> element member unit. For example, if the members consist of typical
>> two dimensional matrix, the dimen[0] represents the number of rows
>> and dimen[1] represents the number of columns (or vise-versa).
>>
>> The total members in the matrix should be within the number of members in
>> the element, while current implementation has no validator of this
>> information. In a view of userspace applications, the information must be
>> valid so that it cannot cause any bugs such as buffer-over-run.
>>
>> This commit adds a validator of dimension information for userspace
>> applications which add new element sets. When they add the element sets
>> with wrong dimension information, they receive -EINVAL.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/core/control.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/sound/core/control.c b/sound/core/control.c
>> index a85d455..af167ff 100644
>> --- a/sound/core/control.c
>> +++ b/sound/core/control.c
>> @@ -805,6 +805,33 @@ static int snd_ctl_elem_list(struct snd_card *card,
>>  	return 0;
>>  }
>>  
>> +static bool validate_dimension(struct snd_ctl_elem_info *info)
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
>> +		if (info->dimen.d[i] < 0)
>> +			return false;
>> +		elements *= info->dimen.d[i];
>> +	}
> 
> Just minor nit-picks:
> 
> - No check for the negative sign of the first element?
> 
> - It'd be clearer to check zero of the first element before the
>   loop.
> 
> - Safer to have an integer overflow check in such calculation.

Indeed. I'll post revised version, later.


Thanks

Takashi Sakamoto
