From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ALSA: control: Add sanity checks for
 user ctl id name string
Date: Fri, 13 Mar 2015 09:43:02 +0900
Message-ID: <55023296.3080504@sakamocchi.jp>
References: <1426142461-16095-1-git-send-email-tiwai@suse.de>
 <550138C1.4060308@sakamocchi.jp> <s5hegoun1k0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 951222658BA
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 01:43:15 +0100 (CET)
In-Reply-To: <s5hegoun1k0.wl-tiwai@suse.de>
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

On Mar 12 2015 15:59, Takashi Iwai wrote:
> At Thu, 12 Mar 2015 15:57:05 +0900,
> Takashi Sakamoto wrote:
>>
>> Iwai-san,
>>
>> On Mar 12 2015 15:41, Takashi Iwai wrote:
>>> There was no check about the id string of user control elements, so we
>>> accepted even a control element with an empty string, which is
>>> obviously bogus.  This patch adds more sanity checks of id strings.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>> v1->v2: fix typos, thinkos
>>>
>>>   sound/core/control.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/sound/core/control.c b/sound/core/control.c
>>> index 35324a8e83c8..eeb691d1911f 100644
>>> --- a/sound/core/control.c
>>> +++ b/sound/core/control.c
>>> @@ -1170,6 +1170,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>>>
>>>   	if (info->count < 1)
>>>   		return -EINVAL;
>>> +	if (!*info->id.name)
>>> +		return -EINVAL;
>>> +	if (strnlen(info->id.name, sizeof(info->id.name)) >= sizeof(info->id.name))
>>> +		return -EINVAL;
>>
>> Over 80 characters.
>>
>> $ ./scripts/checkpatch.pl /tmp/patches/*
>> WARNING: line over 80 characters
>> #25: FILE: sound/core/control.c:1019:
>> +	if (strnlen(info->id.name, sizeof(info->id.name)) >= 
>> sizeof(info->id.name))
>>
>> total: 0 errors, 1 warnings, 10 lines checked
> 
> It's no error, you may ignore it unless it becomes too ugly and
> unreadable.

Hm. OK, I'll do the same thing for my patchsets if it contributes
readability.

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Takashi Sakamoto
