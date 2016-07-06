From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: control: add dimension validator
 for userspace element
Date: Wed, 6 Jul 2016 22:07:41 +0900
Message-ID: <577D029D.9090701@sakamocchi.jp>
References: <1467371413-16895-1-git-send-email-o-takashi@sakamocchi.jp>
 <1467371413-16895-3-git-send-email-o-takashi@sakamocchi.jp>
 <57766231.6060304@sakamocchi.jp> <s5hh9c8qxq3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8CD152608EA
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2016 15:07:47 +0200 (CEST)
In-Reply-To: <s5hh9c8qxq3.wl-tiwai@suse.de>
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

Sorry to be late. I had a short vacation.

On Jul 2 2016 16:56, Takashi Iwai wrote:
> On Fri, 01 Jul 2016 14:29:37 +0200,
> Takashi Sakamoto wrote:
>>
>> On Jul 1 2016 20:10, Takashi Sakamoto wrote:
>>> The 'dimen' field in struct snd_ctl_elem_info is used to compose all of
>>> members in the element as multi-dimensional matrix. The field has four
>>> members. Each member represents the width in each dimension level by
>>> element member unit. For example, if the members consist of typical
>>> two dimensional matrix, the dimen[0] represents the number of rows
>>> and dimen[1] represents the number of columns (or vise-versa).
>>>
>>> The total members in the matrix should be within the number of members in
>>> the element, while current implementation has no validator of this
>>> information. In a view of userspace applications, the information must be
>>> valid so that it cannot cause any bugs such as buffer-over-run.
>>>
>>> This commit adds a validator of dimension information for userspace
>>> applications which add new element sets. When they add the element sets
>>> with wrong dimension information, they receive -EINVAL.
>>>
>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>> ---
>>>  sound/core/control.c | 30 ++++++++++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/sound/core/control.c b/sound/core/control.c
>>> index a85d455..54da910 100644
>>> --- a/sound/core/control.c
>>> +++ b/sound/core/control.c
>>> @@ -805,6 +805,34 @@ static int snd_ctl_elem_list(struct snd_card *card,
>>>  	return 0;
>>>  }
>>>  
>>> +static bool validate_element_member_dimension(struct snd_ctl_elem_info *info)
>>> +{
>>> +	unsigned int members;
>>> +	unsigned int i = 0;
> 
> Unnecessary initialization.
> 
>>> +
>>> +	if (info->dimen.d[0] == 0)
>>> +		return true;
>>> +
>>> +	members = 1;
>>> +	for (i = 0; i < ARRAY_SIZE(info->dimen.d); ++i) {
>>> +		if (info->dimen.d[i] < 0)
>>> +			return false;
>>
>> Mmm... info->dimen.d is declared with 'unsigned short' type. Thus,
>> negative value check is needless...
>>
>> struct snd_ctl_elem_info {
>>     ...
>>     union {
>>         unsigned short d[4];
>>         ..
>>     };
>>     ...
>> };
>>
>> Please abandon this patchset. I'll post new one tomorrow.
> 
> Indeed, somehow I overlooked it, too.
> 
> While we're at it: maybe it's even safer to check more strictly the
> result whether it matches with info->count.  I don't think there is
> any reason to have an unaligned info->count value when the dimen array
> is given.  It must be a bug.
> 
> That is:
>>> +		if (info->dimen.d[i] == 0)
>>> +			break;
>>> +
>>> +		members *= info->dimen.d[i];
>>> +		if (members > info->count)
>>> +			return false;
>>> +	}
>>> +
>>> +	for (++i; i < ARRAY_SIZE(info->dimen.d); ++i) {
>>> +		if (info->dimen.d[i] != 0)
>>> +			return false;
>>> +	}
>>> +
>>> +	return true;
> 
> Here will be
> 	return members == info->count;

I don't mind to be strict here. It's the same as my initial idea (not
posted).


But here, I have a question related to next patch (3rd patch). The
validation logic depends on reliability of info->count. In a case of
user-defined control element set, info->count is validated in advance,
therefore it's reasonable. But in a case of each kernel driver,
info->count is not validated yet, here. Thus, reliability of the
calculation is lost, I think. The result depends on implementation of
each driver and it can bring disadvantages to userspace.

When I think back, this is the main reason that I'm unwilling to use
info->count for prevention of arithmetic overflow. If we apply the same
logic to each kernel drivers, we need more validators for info->count.
For example:
'''
static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
                             struct snd_ctl_elem_info *info)
{
    ...
    if (info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
        info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64) {
        dev_err(card->dev,
            "This module has a bug of invalid element type.\n");
        result = -ENODATA;
        goto end;
    }

    if (info->count < 1 ||
        info->count > max_element_members[info->type]) {
        dev_err(card->dev,
            "This module has a bug of invalid member count.\n");
        result = -ENODATA;
        goto end;
    }

    /* This is a driver bug. */
    if (!validate_element_member_dimension(info)) {
        dev_err(card->dev,
            "This module has a bug of invalid dimention info.\n");
        result = -ENODATA;
        goto end;
    }
    ...
'''

Assume 'max_element_members' is precomputed table about the maximum
number of members in an element, like:
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c#n1209

What do you think about it?


Regards

Takashi Sakamoto
