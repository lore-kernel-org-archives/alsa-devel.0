From: Rob Duncan <rduncan@tesla.com>
Subject: Re: Thread spinning in kernel
	snd_pcm_link()/snd_pcm_unlink()
Date: Tue, 2 Oct 2018 09:55:34 -0700
Message-ID: <dw77emh8i45lvd.fsf@tesla.com>
References: <dw77emy3bl4mmb.fsf@tesla.com> <s5h5zyks7m9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0019bd01.pphosted.com (mx0a-0019bd01.pphosted.com
 [148.163.151.57])
 by alsa0.perex.cz (Postfix) with ESMTP id CF47D2676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 18:55:38 +0200 (CEST)
In-Reply-To: <s5h5zyks7m9.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for taking a look at this.

> I'm not sure whether that's the case.  Do you mean that one thread
> gets stuck at pcm_release_private() which calls snd_pcm_unlink()?
> Or do you really use the PCM linkage?

We're not explicitly using the link/unlink APIs, so I think it must be
pcm_release_private().

I'll try out your suggestion over the next couple of days.  In the
meantime we've avoided the issue by arranging for the realtime threads
to have the same priority (which I think they should have anyway).

Rob.

At 08:14 on Tue, Oct 02 2018, Takashi wrote:
> On Fri, 28 Sep 2018 18:23:24 +0200,
> Rob Duncan wrote:
>>
>> I'm trying to address a bug where we end up with a thread spinning and
>> consuming an entire cpu.  The issue seems to be this code in
>> sound/core/pcm_native.c:
>>
>>     /* Writer in rwsem may block readers even during its waiting in queue,
>>      * and this may lead to a deadlock when the code path takes read sem
>>      * twice (e.g. one in snd_pcm_action_nonatomic() and another in
>>      * snd_pcm_stream_lock()).  As a (suboptimal) workaround, let writer to
>>      * spin until it gets the lock.
>>      */
>>     static inline void down_write_nonblock(struct rw_semaphore *lock)
>>     {
>>             while (!down_write_trylock(lock))
>>                     cond_resched();
>>     }
>>
>> The original commit for this is 67ec1072b053c15564e6090ab30127895dc77a89
>>
>> What we're suspecting is that a normal thread (SCHED_OTHER) has a reader
>> lock and a real-time thread using SCHED_RR or SCHED_FIFO is trying to
>> take the writer lock.  If both threads are pinned to the same CPU for
>> some reason then the reader thread will never get scheduled (because the
>> real-time writer thread is still runnable), and we will never make
>> progress.
>>
>> Does this sound right?  What can we do to fix this?
>
> I'm not sure whether that's the case.  Do you mean that one thread
> gets stuck at pcm_release_private() which calls snd_pcm_unlink()?
> Or do you really use the PCM linkage?
>
> In the former case, we may loosen it by optimizing like the patch
> below (totally untested).  I guess it won't be a problem about racy
> access, but need double-checks afterward.
>
>
> thanks,
>
> Takashi
>
>
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2369,7 +2369,8 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
>
>  static void pcm_release_private(struct snd_pcm_substream *substream)
>  {
> -	snd_pcm_unlink(substream);
> +	if (snd_pcm_stream_linked(substream))
> +		snd_pcm_unlink(substream);
>  }
>
>  void snd_pcm_release_substream(struct snd_pcm_substream *substream)
