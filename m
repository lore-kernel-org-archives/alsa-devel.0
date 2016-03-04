From: bsiice <bsiice@msn.com>
Subject: Re: [PATCH - pcm 1/1] pcm: fix "unable to create IPC
 shm instance" in some case
Date: Sat, 5 Mar 2016 00:22:58 +0800
Message-ID: <BLU437-SMTP82BDE731C190D149D05F74D2BE0@phx.gbl>
References: <BLU437-SMTP418A25BEF034BD65DA159BD2BD0@phx.gbl>
 <s5hh9gn6537.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BLU004-OMC3S17.hotmail.com (blu004-omc3s17.hotmail.com
 [65.55.116.92]) by alsa0.perex.cz (Postfix) with ESMTP id 6CB6A260673
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 17:22:27 +0100 (CET)
In-Reply-To: <s5hh9gn6537.wl-tiwai@suse.de>
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

On 03/03/2016 09:53 PM, Takashi Iwai wrote:
> On Thu, 03 Mar 2016 13:40:42 +0100,
> IceBsi wrote:
>>
>> From: Qing Cai <caiqing@neusoft.com>
>>
>> As stated in manpage SHMCTL(2), shm_nattch is "No. of current attaches"
>> (i.e., number of processes attached to the shared memeory). If an
>> application uses alsa-lib and invokes fork() at some point, there should
>> be the following execution sequence:
>>  1. execute the following statement:
>>       pcm_direct.c:110: dmix->shmptr = shmat(dmix->shmid, 0, 0)
>>     (shm_nattch becomes 1)
>>  2. invoke fork() in some thread.
>>     (shm_nattch becomes 2)
>>  3. execute the following statement:
>>       pcm_direct.c:122: if (buf.shm_nattch == 1)
>>  4. execute the following statement:
>>       pcm_direct.c:131: if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC)
>>     (As stated in manpage SHMGET(2), "When a new shared memory segment
>>      is created, its contents are initialized to zero values", so
>>      dmix->shmptr->magic is 0)
>>  5. execute the following statements:
>>       pcm_direct.c:132: snd_pcm_direct_shm_discard(dmix)
>>       pcm_direct.c:133: return -EINVAL
>> The above execution sequence will cause the following error:
>>   unable to create IPC shm instance
>> This error causes multimedia application has no sound. This error rarely
>> occurs, probability is about 1%.
>> Because the first user of the shared memory will get that
>> dmix->shmptr->magic is 0, check dmix->shmptr->magic's value to determine
>> if "we're the first user" is OK.
>> Tests have been made 400+ times after this fix, and the issue no longer
>> exists.
> 
> I think this is still racy.  Multiple users can grab the shmem at the
> very same time.  Maybe it looks as if working just because both users
> behavior as the first user and do clear and initialize.
I think this won't be a race condition. Since
snd_pcm_direct_shm_create_or_connect() is protected by
snd_pcm_direct_semaphore_down() and snd_pcm_direct_semaphore_up(),
multiple processes won't do clear and initialization concurrently.
> 
> The check of bus.shm_nattach=1 should be fine, per se.  The problem is
> the magic key check of the secondary.  In the current code, as you
> pointed out, this may happen before the first client finishes the
> initialization.
I think the check of dmix->shmptr->magic!=SND_PCM_DIRECT_MAGIC is more
robust. Assume there are two clients of shmem and shmem is initialized,
if one of the clients exits, shm_nattach will become 1 and shmem may be
initialized again.
In the current code, because there is semaphore, magic key check won't
happen before initialization of shmem.
In the scenario that I want to tell, there is only one process, and only
one thread doning the clear and initialization of shmem, and the fork()
is invoked in another thread of non alsa-lib context (i.e., the fork()
code is not in alsa-lib). If the fork() is invoked before shmat(), the
problem won't happen; If the fork() is invoked after the check of
bus.shm_nattach=1, the problem won't happen too. Only if the fork() is
invoked just after shmat() and just before the check of
bus.shm_nattach=1, the problem happens.
> 
> One option would be to use some lock like pthread mutex.  Another
> option would be to spin for a while until it gets a non-zero value.
> I guess the latter is more suitable for dmix & co.
There is already semaphore encapsulated by
snd_pcm_direct_semaphore_down() and snd_pcm_direct_semaphore_up(), so
mutex is not needed. In the scenario that I want to tell, it will never
get a non-zero value of dmix->shmptr->magic, because there is no other
thread doing the initialization.

Thanks,
Qing Cai
> 
> Thoughts?
> 
> 
> thanks,
> 
> Takashi
> 
> 
>>
>> Signed-off-by: Qing Cai <bsiice@msn.com>
>> Signed-off-by: Qing Cai <caiqing@neusoft.com>
>>
>> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
>> index fd3877c..93d6f3c 100644
>> --- a/src/pcm/pcm_direct.c
>> +++ b/src/pcm/pcm_direct.c
>> @@ -119,7 +119,7 @@ retryget:
>>  		snd_pcm_direct_shm_discard(dmix);
>>  		return err;
>>  	}
>> -	if (buf.shm_nattch == 1) {	/* we're the first user, clear the segment */
>> +	if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC) {	/* we're the first user, clear the segment */
>>  		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
>>  		if (dmix->ipc_gid >= 0) {
>>  			buf.shm_perm.gid = dmix->ipc_gid;
>> -- 
>> 2.7.2
>>
> 
> 
