From: Jan Homann <jh@janhomann.de>
Subject: Re: Too many snd_pcm_mmap_readi calls
Date: Wed, 07 May 2014 11:52:45 +0200
Message-ID: <536A026D.1070104@janhomann.de>
References: <5369DE58.30208@janhomann.de> <5369F684.7060502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kunden1.comsitec.de (kunden1.comsitec.de [93.190.93.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3562610B0
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:52:48 +0200 (CEST)
In-Reply-To: <5369F684.7060502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Arg, i am sorry for the enormouse amount of errors in eight lines of
code. Is there any "Errors per line"-List? Maybe there is a new leader
by now.

I added the sleep to see the start of one while-loop in the strace
output. Not every function appears in the strace. Just to see where the
loop starts i added a function and sleep came into my mind first.
In my real function i am checking the return values of snd_pcm_wait and
snd_pcm_mmap_readi. The return value of snd_pcm_mmap_readi is used to
encode the amount of captured samples with opus.

In my opinion mmap_begin just tells the alsa-lib that someone is about
to access the buffer. With avail_update all buffer states (whatever they
are) are updated and mmap_readi gets the samples to
network_data.data_UC. After that, mmap_commit tells the alsa-lib that i
am ready with the buffer.
Maybe i am wrong with that. Ok, for sure i am wrong with that.

I am using mmap because of its good performance. Under normal condition
with snd_pcm_mmap_readi my program uses about 1% of cpu-time where
snd_pcm_readi uses about 75%.

Do you know a good tutorial about using mmap_readi?

Am 07.05.2014 11:01, schrieb Clemens Ladisch:
> Jan Homann wrote:
>> while(1) {
>>     sleep(1);
>>     snd_pcm_wait( pcm_handle, REC_BUFFER_ELEMENT_SIZE_MS + 10);
>>     snd_pcm_mmap_begin(pcm_handle, &my_areas, &offset, &frames);
>>     snd_pcm_avail_update ( pcm_handle );
>>     snd_pcm_mmap_readi( pcm_handle, network_data.data_UC, ALSA_READ_FRAMES);
>>     snd_pcm_mmap_commit(pcm_handle, offset, frames);
>> }
> The sleep will result in an overrun, which will throw off the timing
> of all following calls.
>
> You are not checking the return value of any of these functions.
>
> Why are you calling snd_pcm_avail_update?  And why are you doing this
> _after_ calling mmap_begin?
>
> You are ignoring the number of frames returned by mmap_begin.  This
> value could be smaller or larger than ALSA_READ_FRAMES.
>
> Why are you using mmap in the first place, when you don't even try to
> access the buffer directly?
>
>
> Regards,
> Clemens
>
