From: Arun Raghavan <arun@accosted.net>
Subject: Re: [PATCH] control: Allow cset'ing specific values in
 the multi-value case
Date: Wed, 10 Jun 2015 14:26:48 +0530
Message-ID: <CACuU-+jXEyNL1+tXC0zBRRRW+RtsmRgvOwYK=hA3hOXfF9nRVA@mail.gmail.com>
References: <1433847307-26125-1-git-send-email-arun@accosted.net>
 <s5hzj49ozr6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f51.google.com (mail-yh0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A503926071E
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 10:57:09 +0200 (CEST)
Received: by yhan67 with SMTP id n67so17735605yha.3
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 01:57:08 -0700 (PDT)
In-Reply-To: <s5hzj49ozr6.wl-tiwai@suse.de>
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
Cc: Arun Raghavan <git@arunraghavan.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 9 June 2015 at 17:33, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue,  9 Jun 2015 16:25:07 +0530,
> arun@accosted.net wrote:
>>
>> From: Arun Raghavan <git@arunraghavan.net>
>>
>> This works with syntax like ...
>>
>>   amixer cset 'IIR1 Band1'  ,,200
>>
>> ... to set the third value of the control to 200.
>> ---
>>  src/control/ctlparse.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
>> index 8d6c385..64c6480 100644
>> --- a/src/control/ctlparse.c
>> +++ b/src/control/ctlparse.c
>> @@ -48,9 +48,9 @@ static inline long int convert_prange1(long val, long min, long max)
>>  #define check_range(val, min, max) \
>>       ((val < min) ? (min) : ((val > max) ? (max) : (val)))
>>
>> -static long get_integer(const char **ptr, long min, long max)
>> +static long get_integer(const char **ptr, long def, long min, long max)
>>  {
>> -     long val = min;
>> +     long val = def;
>>       char *p = (char *)*ptr, *s;
>>
>>       if (*p == ':')
>> @@ -351,6 +351,8 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
>>                       break;
>>               case SND_CTL_ELEM_TYPE_INTEGER:
>>                       tmp = get_integer(&ptr,
>> +                                       snd_ctl_elem_value_get_integer(dst,
>> +                                                                      idx),
>>                                         snd_ctl_elem_info_get_min(info),
>>                                         snd_ctl_elem_info_get_max(info));
>>                       snd_ctl_elem_value_set_integer(dst, idx, tmp);
>> @@ -364,12 +366,12 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
>>               case SND_CTL_ELEM_TYPE_ENUMERATED:
>>                       tmp = get_ctl_enum_item_index(handle, info, &ptr);
>>                       if (tmp < 0)
>> -                             tmp = get_integer(&ptr, 0,
>> +                             tmp = get_integer(&ptr, 0, 0,
>>                                       snd_ctl_elem_info_get_items(info) - 1);
>>                       snd_ctl_elem_value_set_enumerated(dst, idx, tmp);
>>                       break;
>>               case SND_CTL_ELEM_TYPE_BYTES:
>> -                     tmp = get_integer(&ptr, 0, 255);
>> +                     tmp = get_integer(&ptr, 0, 0, 255);
>>                       snd_ctl_elem_value_set_byte(dst, idx, tmp);
>>                       break;
>
> Hmm, if it's just about skipping the empty element, how about the
> patch below instead?

Thanks, this works and does look better.

Cheers,
Arun

> ---
> diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
> index 8d6c3859bec4..877a05e3a1f1 100644
> --- a/src/control/ctlparse.c
> +++ b/src/control/ctlparse.c
> @@ -325,6 +325,8 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
>         snd_ctl_elem_value_set_id(dst, myid);
>
>         for (idx = 0; idx < count && idx < 128 && ptr && *ptr; idx++) {
> +               if (*ptr == ',')
> +                       goto skip;
>                 switch (type) {
>                 case SND_CTL_ELEM_TYPE_BOOLEAN:
>                         tmp = 0;
> @@ -375,6 +377,7 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
>                 default:
>                         break;
>                 }
> +       skip:
>                 if (!strchr(value, ','))
>                         ptr = value;
>                 else if (*ptr == ',')
