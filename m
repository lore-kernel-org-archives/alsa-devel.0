From: John Spencer <maillist-alsa@barfooze.de>
Subject: Re: horribly wrong code when --with-versioned is active
Date: Tue, 06 Aug 2013 17:51:55 +0200
Message-ID: <52011B9B.4010807@barfooze.de>
References: <52001D21.6060203@barfooze.de> <s5hmwovgy4f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 43BA8260315
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 17:57:54 +0200 (CEST)
In-Reply-To: <s5hmwovgy4f.wl%tiwai@suse.de>
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

On 08/06/2013 07:57 AM, Takashi Iwai wrote:
> At Mon, 05 Aug 2013 23:46:09 +0200,
> John Spencer wrote:
>>
>> if --with-versioned is active (default), a couple of macros in pcm.c
>> start generating some completely broken, __old-prefixed wrapper
>> functions, which then are getting used whenever the actual function is
>> called.
>>
>> for example:
>> snd_pcm_hw_params_set_buffer_time_near
>>
>> __OLD_NEAR1(snd_pcm_hw_params_set_buffer_time_near, unsigned int);
>>
>> ->
>>
>> #define __OLD_NEAR1(name, ret_type) __P_OLD_NEAR1(__old_, name, ret_type)
>>
>> ->
>>
>> #define __P_OLD_NEAR1(pfx, name, ret_type) \
>> ret_type pfx##name(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, ret_type
>> val, int *dir) \
>> { \
>>           if (INTERNAL(name)(pcm, params,&val, dir)<  0) \
>>                   return 0; \
>>           return (ret_type)val; \
>> }
>>
>> this will lead to generating a function
>> __old_snd_pcm_hw_params_set_buffer_time_near which expands to
>>
>> unsigned int __old_snd_pcm_hw_params_set_buffer_time_near(snd_pcm_t
>> *pcm, snd_pcm_hw_params_t *params, ret_type val, int *dir)
>> {
>>           if snd1_pcm_hw_params_set_buffer_time_near(pcm, params,&val,
>> dir)<  0)
>>                   return 0;
>>           return (ret_type)val;
>> }
>>
>> there 2 bugs in there,
>> 1) the real function gets passed a pointer to a pointer of unsigned,
>> which is then happily dereferenced and the original pointer used as an
>> int, and
>
> The pointer cast between signed and unsigned is done normally in C.
>
>> 2) the return type logic is wrong, in case of a non-error, the original
>> pointer will be returned instead of 0 to indicate success.
>
> The val argument is no pointer but a value.

my problem is that the old version is getting called instead of the new one.

so it passes a pointer where an int is expected. maybe that's because 
openal uses dlopen to open the alsa DSO. or it is due to some binutils 
bug or whatever.

anyway, since this all looks very hackish and fragile, and given that 
the change old api -> new api was done 11 years ago, can we agree to 
just remove the old cruft and debloat alsa-lib slightly by doing so ?
i'm pretty sure *nobody* is using the old stuff anymore.
