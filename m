From: bsiice <bsiice@msn.com>
Subject: Re: [PATCH - pcm 1/1] pcm: fix "unable to create IPC
 shm instance" in some case
Date: Sat, 5 Mar 2016 01:36:46 +0800
Message-ID: <BLU436-SMTP243C74599C81C3BFF7E62E8D2BE0@phx.gbl>
References: <BLU437-SMTP418A25BEF034BD65DA159BD2BD0@phx.gbl>	<s5hh9gn6537.wl-tiwai@suse.de>	<BLU437-SMTP82BDE731C190D149D05F74D2BE0@phx.gbl>
 <s5hd1raci79.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BLU004-OMC3S8.hotmail.com (blu004-omc3s8.hotmail.com
 [65.55.116.83]) by alsa0.perex.cz (Postfix) with ESMTP id 255F1265767
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 18:35:55 +0100 (CET)
In-Reply-To: <s5hd1raci79.wl-tiwai@suse.de>
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
Cc: Qing Cai <caiqing@neusoft.com>, alsa-devel@alsa-project.org, bsiice@msn.com
List-Id: alsa-devel@alsa-project.org

On 03/05/2016 12:37 AM, Takashi Iwai wrote:
> On Fri, 04 Mar 2016 17:22:58 +0100,
> bsiice wrote:
>>
>> On 03/03/2016 09:53 PM, Takashi Iwai wrote:
>>> On Thu, 03 Mar 2016 13:40:42 +0100,
>>> IceBsi wrote:
>>>>
>>>> From: Qing Cai <caiqing@neusoft.com>
>>>>
>>>> As stated in manpage SHMCTL(2), shm_nattch is "No. of current attaches"
>>>> (i.e., number of processes attached to the shared memeory). If an
>>>> application uses alsa-lib and invokes fork() at some point, there should
>>>> be the following execution sequence:
>>>>  1. execute the following statement:
>>>>       pcm_direct.c:110: dmix->shmptr = shmat(dmix->shmid, 0, 0)
>>>>     (shm_nattch becomes 1)
>>>>  2. invoke fork() in some thread.
>>>>     (shm_nattch becomes 2)
>>>>  3. execute the following statement:
>>>>       pcm_direct.c:122: if (buf.shm_nattch == 1)
>>>>  4. execute the following statement:
>>>>       pcm_direct.c:131: if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC)
>>>>     (As stated in manpage SHMGET(2), "When a new shared memory segment
>>>>      is created, its contents are initialized to zero values", so
>>>>      dmix->shmptr->magic is 0)
>>>>  5. execute the following statements:
>>>>       pcm_direct.c:132: snd_pcm_direct_shm_discard(dmix)
>>>>       pcm_direct.c:133: return -EINVAL
>>>> The above execution sequence will cause the following error:
>>>>   unable to create IPC shm instance
>>>> This error causes multimedia application has no sound. This error rarely
>>>> occurs, probability is about 1%.
>>>> Because the first user of the shared memory will get that
>>>> dmix->shmptr->magic is 0, check dmix->shmptr->magic's value to determine
>>>> if "we're the first user" is OK.
>>>> Tests have been made 400+ times after this fix, and the issue no longer
>>>> exists.
>>>
>>> I think this is still racy.  Multiple users can grab the shmem at the
>>> very same time.  Maybe it looks as if working just because both users
>>> behavior as the first user and do clear and initialize.
>> I think this won't be a race condition. Since
>> snd_pcm_direct_shm_create_or_connect() is protected by
>> snd_pcm_direct_semaphore_down() and snd_pcm_direct_semaphore_up(),
>> multiple processes won't do clear and initialization concurrently.
> 
> Hrm, OK, now understood the situation.
> 
>>> The check of bus.shm_nattach=1 should be fine, per se.  The problem is
>>> the magic key check of the secondary.  In the current code, as you
>>> pointed out, this may happen before the first client finishes the
>>> initialization.
>> I think the check of dmix->shmptr->magic!=SND_PCM_DIRECT_MAGIC is more
>> robust. Assume there are two clients of shmem and shmem is initialized,
>> if one of the clients exits, shm_nattach will become 1 and shmem may be
>> initialized again.
> 
> Yeah, in the fork from a thread, the shm_nattch check doesn't work
> reliably, indeed.
> 
>> In the current code, because there is semaphore, magic key check won't
>> happen before initialization of shmem.
>> In the scenario that I want to tell, there is only one process, and only
>> one thread doning the clear and initialization of shmem, and the fork()
>> is invoked in another thread of non alsa-lib context (i.e., the fork()
>> code is not in alsa-lib). If the fork() is invoked before shmat(), the
>> problem won't happen; If the fork() is invoked after the check of
>> bus.shm_nattach=1, the problem won't happen too. Only if the fork() is
>> invoked just after shmat() and just before the check of
>> bus.shm_nattach=1, the problem happens.
> 
> Well, the reason why the magic key check was introduced was about the
> safety.  Since the shmid is given explicitly, it might override some
> shmem usages other than dmix accidentally.  With your patch, it
> forcibly clears the region -- this is quite opposite to the intention 
> of the magic key check.

I just think it clears the region only once at the first time. Could you
please show me the scenario in detail?

thanks,

Qing Cai

> 
> So, this isn't about the race.  But how to not destroy something else
> unexpectedly.
> 
> I'd happily apply a good fix if there is a better alternative...
> 
> 
> thanks,
> 
> Takashi
> 
> 
