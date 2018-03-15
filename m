From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: alsalib and snd_pcm_hw_params_set_rate_minmax
Date: Thu, 15 Mar 2018 14:20:14 +0200
Message-ID: <9cf1073b-97ec-a3f5-a08a-5c54f5d92c4a@gmail.com>
References: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
 <084894a2-8107-05ab-6f6c-7418c505f3c4@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DA82267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 13:20:17 +0100 (CET)
Received: by mail-lf0-f41.google.com with SMTP id t132-v6so9828701lfe.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 05:20:17 -0700 (PDT)
In-Reply-To: <084894a2-8107-05ab-6f6c-7418c505f3c4@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 03/15/2018 01:59 PM, Takashi Sakamoto wrote:
> Hi,
>
> On Mar 15 2018 19:45, Oleksandr Andrushchenko wrote:
>> Is it possible for user-space to reduce configuration space
>> with snd_pcm_hw_params_set_rate_minmax and then change it
>> with another snd_pcm_hw_params_set_rate_minmax with values
>> out of the reduced config?
>>
>> For example, the initial min/max is 44100/48000 and I set 44100
>> first, e.g.
>>
>> snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 44100, 0, 44100, 0)
>>
>> and then want
>>
>> snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 48000, 0, 48000, 0)
>>
>> Obviously, the last call fails as we have already a reduced
>> space of [44100; 44100].
>>
>> Is there a way I can still set the range to [48000; 48000]?
>>
>> Thank you,
>> Oleksandr
>>
>> P.S. This is in context of work done for [1]
>>
>> [1] https://www.spinics.net/lists/alsa-devel/msg75382.html
>
> We can't. Once shrinking available interval of a parameter, we cannot
> expand it again without initializing the parameter on memory object for
> 'struct snd_pcm_hw_params_t', in which actual layout is never disclosed
> to user applications.
So, this effectively means that this is a one way road, if you need to 
change
some parameter you'll need to start all over, so the whole configuration
space remains consistent :(
>
> If you can initialize whole the parameters, snd_pcm_hw_params_any() is
> available for your purpose, then set min/max rate again. 
This is what I do now but...
> But just for
> one of the parameters, in my opinion, we need to open an internal API; 
> snd_pcm_hw_param_any()[1].
IMO, this will lead to the false assumption that configuration is possible.
For example, I set 4 channels and 44100, but then, after 
snd_pcm_hw_params_any,
set 48000 and might assume that the configuration is still possible. But 
this may not
be true: it is true for the configuration returned by snd_pcm_hw_param_any
as we don't know about 4 channels yet. But might not be allowed if we 
want 4 channels
and 48000 at the same time.
>
> [1] 
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_params.c;h=608a2324cb268f84d91f67c53d979521678f4edb;hb=HEAD#l107
>
>
> Regards
>
> Takashi Sakamoto
Thank you very much for explanation,
Oleksandr
