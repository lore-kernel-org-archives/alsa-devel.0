From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ALSA: drivers: make array 'names' const, reduces object
 code size
Date: Mon, 27 Nov 2017 17:00:03 +0100
Message-ID: <5A1C3683.7080901@bfs.de>
References: <20171127125851.10076-1-colin.king@canonical.com>         <5A1C2760.1030704@bfs.de> <1511797207.32426.41.camel@perches.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511797207.32426.41.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Colin King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 27.11.2017 16:40, schrieb Joe Perches:
> On Mon, 2017-11-27 at 15:55 +0100, walter harms wrote:
>> Am 27.11.2017 13:58, schrieb Colin King:
>>> From: Colin Ian King <colin.king@canonical.com>
>>> Don't populate array 'names' on the stack but instead make them static.
>>> Makes the object code smaller by 50 bytes:
> []
>>> diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
> []
>>> @@ -830,7 +830,7 @@ static int snd_dummy_capsrc_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
>>>  static int snd_dummy_iobox_info(struct snd_kcontrol *kcontrol,
>>>  				struct snd_ctl_elem_info *info)
>>>  {
>>> -	const char *const names[] = { "None", "CD Player" };
>>> +	static const char *const names[] = { "None", "CD Player" };
>>>  
>>>  	return snd_ctl_enum_info(info, 1, 2, names);
>>>  }
>>
>> nitpick: while here
>>    snd_ctl_enum_info(info, 1, ARRAY_SIZE(names), names);
>>
>> just my 2 cents,
> 
> True, but that seems counter style for most uses of snd_ctl_enum_info
> 
> $ git grep -w snd_ctl_enum_info | grep -v ARRAY_SIZE | wc -l
> 159
> $ git grep -w snd_ctl_enum_info | grep ARRAY_SIZE | wc -l
> 10
> 
> but most of those seem to choose variable amounts of a single
> array.  Here, ARRAY_SIZE seems better to me too.

I will not argue. I was curious about the magic numbers and
int this case it seems an obvious choice in other cases
it may be wrong i did not and i will not investigate.

re,
 wh

> 
> For another real nitpick, please prefer "const *" over "const*"
> 
> $ git grep -P "\*\s+const\b" | wc -l
> 7068
> $ git grep -P "\*const\b" | wc -l
> 1801
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
