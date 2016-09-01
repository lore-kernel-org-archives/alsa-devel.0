From: David Henningsson <diwic@ubuntu.com>
Subject: Re: locking looks odd
Date: Thu, 1 Sep 2016 08:27:07 +0200
Message-ID: <65638e12-e944-328a-b7ec-c025228ce619@ubuntu.com>
References: <20160816210322.GD4466@var.home>
 <0fec7ab2-f72f-a27a-e82b-58642836db88@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.egensajt.se (smtp.egensajt.se [193.42.159.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9A02666DA
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 08:27:03 +0200 (CEST)
In-Reply-To: <0fec7ab2-f72f-a27a-e82b-58642836db88@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
List-Id: alsa-devel@alsa-project.org

(Sorry if this email reaches you twice, had some issues)


On 2016-08-17 19:46, Jaroslav Kysela wrote:
> Dne 16.8.2016 v 23:03 Samuel Thibault napsal(a):
>> Hello,
>>
>> We are having odd issues with libasound 1.1.2 which we didn't have with
>> libasound 1.1.1, more precisely
>>
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=833950
>>
>> so I'm having a look at the locking API introduced in 1.1.2, and there
>> are some oddities:
>>
>> - snd_pcm_new seems to initialize pcm->thread_safe to 0 by default, this
>>    does not seem safe. The attached patch initializes it to 1, which
>>    fixes the bug in our tests.
>>
>> - snd_pcm_hw_open_fd forces it to 1, thus ignoring what snd_pcm_new set.
> The thread_safe has this meaning:
>
> 0  - the pcm plugin is not thread safe
> 1  - the pcm plugin is thread safe (actually only the hw plugin)
> -1 - disable thread safety
>
> Your patch does not look correct. It's necessary to determine where the
> mutex is locked the second time (use gdb and backtrace for all threads
> for that). Note that plugins may be chained.

Still Samuel's point about -1 being ignored is valid, so I just sent a 
patch about that.

But I'm quite sceptic about having that environment variable in the 
first place - it seems to me that new apps will start to rely on 
alsa-lib doing the locking for them, second a blog post comes along that 
tells people to set that environment variable to 0 to maximize 
performance, third those apps will crash and the user doesn't understand 
why.

>
>> - one can find both __snd_pcm_lock and snd_pcm_lock functions, what is
>>    the expected difference between them?
> __snd_pcm_lock/unlock is for forced lock
>
> snd_pcm_lock/unlock skips locking for safe plugins (only hw plugin)



These are quite confusing names, one would expect them to be the same 
(snd_pcm_lock being a compatibility wrapper around some internal 
__snd_pcm_lock).

I'm not sure about better names, but maybe something like 
snd_pcm_lock_all and snd_pcm_lock_ts0 would at least indicate that they 
are different functions.
