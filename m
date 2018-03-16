From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: alsalib and snd_pcm_hw_params_set_rate_minmax
Date: Fri, 16 Mar 2018 14:54:45 +0200
Message-ID: <af96bd7c-895f-97eb-d699-28cfaaf294eb@gmail.com>
References: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
 <084894a2-8107-05ab-6f6c-7418c505f3c4@sakamocchi.jp>
 <9cf1073b-97ec-a3f5-a08a-5c54f5d92c4a@gmail.com>
 <s5ho9jp79s7.wl-tiwai@suse.de>
 <d17e2fdd-d316-8bd7-351c-9e0446adafc1@gmail.com>
 <s5hefkl6q1s.wl-tiwai@suse.de>
 <43fb1d82-60e3-37af-961b-5d8819bf3cef@gmail.com>
 <20180316125002.GA10870@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BF4267380
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 13:54:48 +0100 (CET)
Received: by mail-lf0-f53.google.com with SMTP id e5-v6so11176605lfb.7
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 05:54:48 -0700 (PDT)
In-Reply-To: <20180316125002.GA10870@char.us.oracle.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 03/16/2018 02:50 PM, Konrad Rzeszutek Wilk wrote:
> .snip..
>> All seem to work now when I pass all 5 parameters while querying.
>> The only scary thing is that I had to change the size of
>> requests/responses in the sndif protocol from 32 to 64 bytes :(
> Oh boy. Well, are there any other users beside your code? In which case we could
> just sweep it under the rug and pretend we never had it at 32 bytes.
As far as I know - no other users, so this seems to be the
right time for the change.

At least I heard of nobody using the protocol
and trying to upstream frontend/backend implementations
>> Takashi, could you please have a quick look and tell me if
>> this is what you expect?
>>> thanks,
>>>
>>> Takashi
>> Thank you,
>> Oleksandr
>>
>> [1] https://github.com/andr2000/linux/commits/tiwai_sound_for_next_pv_snd_upstream_v2
>> [2] https://github.com/andr2000/xen/commits/pr_sndif_v3
>> [3] https://github.com/andr2000/snd_be/commits/pr_hw_param
