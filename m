From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Deadlock over semaphore issue with aplay while
 using dmix
Date: Fri, 05 Apr 2013 17:43:41 +0200
Message-ID: <515EF12D.8010401@perex.cz>
References: <CADryByGnyH9rUDBuG_JRPrSgCb3LPwhaVdFXXeELiUYQv+ZHwQ@mail.gmail.com>
 <515D64F4.8030903@perex.cz> <s5h38v645ti.wl%tiwai@suse.de>
 <515EEB98.9000809@perex.cz> <s5h38v52e13.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DA6B265FFB
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 17:43:42 +0200 (CEST)
In-Reply-To: <s5h38v52e13.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 5.4.2013 17:27, Takashi Iwai wrote:
> At Fri, 05 Apr 2013 17:19:52 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 4.4.2013 18:30, Takashi Iwai wrote:
>>> At Thu, 04 Apr 2013 13:33:08 +0200,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Date 4.4.2013 11:27, mateen wrote:
>>>>> Hi,
>>>>>
>>>>> I seeing sometimes deadlock issue with dmix when I press CTRL+C.
>>>>>
>>>>> Aplay's signal handler calls snd_pcm_close() if an interrupt occurs.
>>>>> snd_pcm_close() will internally call  pcm->ops->close() which will fall to
>>>>> snd_pcm_dmix_close() in case you are using dmix.
>>>>>
>>>>> snd_pcm_dmix_close() will try to acquire the semaphore with
>>>>> snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT).
>>>>> The same semaphore is acquired in snd_pcm_dmix_sync_area() with
>>>>> dmix_down_sem() in case of non-concurrent access.
>>>>>
>>>>> If semaphore is acquired in snd_pcm_dmix_sync_area() which is in thread
>>>>> context and interrupt comes, which invokes the signal handler which is in
>>>>> ISR context, which calls snd_pcm_close() which in turn calls
>>>>> snd_pcm_dmix_close() then we see a deadlock since semaphore is not released
>>>>> from thread context and ISR is waiting indefinitely on the same semaphore.
>>>>>
>>>>> Please suggest a suitable solution for this.
>>>>
>>>> It seems that also other configurations (alsa-lib plugins) have trouble
>>>> with the closing from the signal handler - I hit mutex issues with the
>>>> PulseAudio plugin, too.
>>>>
>>>> The question is, how we can do a clean path in this case. Looking to the
>>>> current alsa-lib code, I would suggest to add the snd_pcm_abort()
>>>> function (may be called from the interrupt handler) to notify the
>>>> library to not ignore -EINTR return codes from poll() and other i/o ops
>>>> and pass it to the caller (application) to finish the normal close sequence.
>>>>
>>>> Opinions?
>>>
>>> Isn't it only about the direct plugins with the case where no coherent
>>> memory is available?  If so, we may just avoid the deadlock by
>>> checking some internal flag like the patch below (untested)?
>>> It's no perfect but just some proof, of course.
>>
>> It does not seem like a clean solution. It's just a workaround. I see
>> similar locking problems inside the PulseAudio plugin (client library)
>> when it's closed from the interrupt handler.
> 
> OK, that needs a fix.  But, the fix is anyway done to the plugin code
> itself, so the necessary change would be pretty similar, I guess.
> 
>> Also, looking to apps, the
>> best way is to handle the graceful shutdown outside the interrupt
>> handler and remove whole "extra" code from the interrupt handler like
>> the file header fixups (arecord) from it.
> 
> Yeah, agreed.  I would suggest to rewrite the code at first.
> 
> But this won't "fix" the existing code doing that.  It's a bad code,
> but resulting in a silent deadlock just due to snd_pcm_close() doesn't
> sound good, either.

I would just call abort() in this dead-lock case like the PA library
code does. In this way, the problem will be reported. It's better than a
silent acceptance.

>> The "atomic" notification, that alsa-lib should abort all i/o wait
>> operations, is a straigh way to do it. Again, syscalls returns EINTR,
>> so we can detect this case and return to the app immediatelly.
> 
> The abort state handling itself looks useful.

Good.

				Jaroslav

> 
> 
> thanks,
> 
> Takashi
> 
>>
>> 					Jaroslav
>>
>>>
>>>
>>> Takashi
>>>
>>> ---
>>> diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
>>> index 1c35dcb..0ad1475 100644
>>> --- a/src/pcm/pcm_direct.h
>>> +++ b/src/pcm/pcm_direct.h
>>> @@ -123,6 +123,7 @@ struct snd_pcm_direct {
>>>  	int ipc_gid;			/* IPC socket gid */
>>>  	int semid;			/* IPC global semaphore identification */
>>>  	int shmid;			/* IPC global shared memory identification */
>>> +	int locked;
>>>  	snd_pcm_direct_share_t *shmptr;	/* pointer to shared memory area */
>>>  	snd_pcm_t *spcm; 		/* slave PCM handle */
>>>  	snd_pcm_uframes_t appl_ptr;
>>> diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
>>> index 16dba14..1b9aa6a 100644
>>> --- a/src/pcm/pcm_dmix.c
>>> +++ b/src/pcm/pcm_dmix.c
>>> @@ -293,8 +293,17 @@ static void remix_areas(snd_pcm_direct_t *dmix,
>>>   */
>>>  #ifndef DOC_HIDDEN
>>>  #ifdef NO_CONCURRENT_ACCESS
>>> -#define dmix_down_sem(dmix) snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT)
>>> -#define dmix_up_sem(dmix) snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT)
>>> +static void dmix_down_sem(snd_pcm_direct_t *dmix)
>>> +{
>>> +	if (!dmix->locked++)
>>> +		snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
>>> +}
>>> +
>>> +static void dmix_up_sem(snd_pcm_direct_t *dmix)
>>> +{
>>> +	if (!--dmix->locked)
>>> +		snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
>>> +}
>>>  #else
>>>  #define dmix_down_sem(dmix)
>>>  #define dmix_up_sem(dmix)
>>> @@ -772,7 +781,8 @@ static int snd_pcm_dmix_close(snd_pcm_t *pcm)
>>>  
>>>  	if (dmix->timer)
>>>  		snd_timer_close(dmix->timer);
>>> -	snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
>>> +	if (!dmix->locked)
>>> +		snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
>>>  	snd_pcm_close(dmix->spcm);
>>>   	if (dmix->server)
>>>   		snd_pcm_dir

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
