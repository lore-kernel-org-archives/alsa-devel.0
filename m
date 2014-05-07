From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Too many snd_pcm_mmap_readi calls
Date: Wed, 07 May 2014 12:29:03 +0200
Message-ID: <536A0AEF.7080908@perex.cz>
References: <5369DE58.30208@janhomann.de> <5369F684.7060502@ladisch.de>
 <536A026D.1070104@janhomann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D26382610B0
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 12:29:03 +0200 (CEST)
In-Reply-To: <536A026D.1070104@janhomann.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Homann <jh@janhomann.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 7.5.2014 11:52, Jan Homann wrote:
> Arg, i am sorry for the enormouse amount of errors in eight lines of
> code. Is there any "Errors per line"-List? Maybe there is a new leader
> by now.
> 
> I added the sleep to see the start of one while-loop in the strace
> output. Not every function appears in the strace. Just to see where the
> loop starts i added a function and sleep came into my mind first.
> In my real function i am checking the return values of snd_pcm_wait and
> snd_pcm_mmap_readi. The return value of snd_pcm_mmap_readi is used to
> encode the amount of captured samples with opus.
> 
> In my opinion mmap_begin just tells the alsa-lib that someone is about
> to access the buffer. With avail_update all buffer states (whatever they
> are) are updated and mmap_readi gets the samples to
> network_data.data_UC. After that, mmap_commit tells the alsa-lib that i
> am ready with the buffer.
> Maybe i am wrong with that. Ok, for sure i am wrong with that.
> 
> I am using mmap because of its good performance. Under normal condition
> with snd_pcm_mmap_readi my program uses about 1% of cpu-time where
> snd_pcm_readi uses about 75%.

The difference should not be so big between MMAP and normal I/O. It
seems like a loop somewhere or you set bad thresholds so kernel wakes up
very often. You may also use a different schedule timer for the
non-block mode.

The ARM architecture does not have coherent caches, so the alsa-lib
tries to sychronize the pointers using ioctl.

> Do you know a good tutorial about using mmap_readi?
> 
> Am 07.05.2014 11:01, schrieb Clemens Ladisch:
>> Jan Homann wrote:
>>> while(1) {
>>>     sleep(1);
>>>     snd_pcm_wait( pcm_handle, REC_BUFFER_ELEMENT_SIZE_MS + 10);
>>>     snd_pcm_mmap_begin(pcm_handle, &my_areas, &offset, &frames);
>>>     snd_pcm_avail_update ( pcm_handle );
>>>     snd_pcm_mmap_readi( pcm_handle, network_data.data_UC, ALSA_READ_FRAMES);
>>>     snd_pcm_mmap_commit(pcm_handle, offset, frames);
>>> }

Remove snd_pcm_mmap_begin(), snd_pcm_mmap_commit() calls.

The snd_pcm_mmap_readi() does this in a loop for you. Only update+readi
is enough.

                                     Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
