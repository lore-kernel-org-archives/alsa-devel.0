From: gsantosh@codeaurora.org
Subject: Re: Question on wait_for_avail function
Date: Thu, 6 Jun 2013 18:29:35 -0000
Message-ID: <13274fa9cdffd44c4468449b1cde146e.squirrel@www.codeaurora.org>
References: <1794d77072add642c43309c0a06bfadb.squirrel@www.codeaurora.org>
 <51AF0223.5020901@ladisch.de> <51B02B4B.8080900@codeaurora.org>
 <s5hwqq7rapq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F7F1261AA1
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 20:29:37 +0200 (CEST)
In-Reply-To: <s5hwqq7rapq.wl%tiwai@suse.de>
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
Cc: lgirdwood@gmail.com, Patrick Lai <plai@codeaurora.org>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

> At Wed, 05 Jun 2013 23:25:15 -0700,
> Patrick Lai wrote:
>>
>> + << Jaroslav >>
>> On 6/5/2013 2:17 AM, Clemens Ladisch wrote:
>> > gsantosh@codeaurora.org wrote:
>> >> 2) HAL issues pause in parallel to the write
>> >
>> > This is illegal.
>> > <http://www.alsa-project.org/main/index.php/SMP_Design> says:
>> > | The use of returned handles [such as snd_pcm_t*] must be serialized
>> in
>> > | the application using own locking scheme.
>> >
>> > If you want to issue a pause while waiting for data to be written, use
>> > non-blocking writes.
>> >
>>
>> Based on my understanding of SMP_Design and response above, pause and
>> write to same
>> PCM device are expected to be serialized. However, my interpretation of
>> following patch is that pause and stop are expected to wakes up process
>> waiting in pcm_lib.c wait_for_avail(). It seems to give me the
>> indication that multiple threads acting on same PCM device is expected.
>>
>> ALSA: pcm_core: Fix wake_up() optimization
>>
>> This change fixes the "ALSA: pcm_lib - optimize wake_up() calls for PCM
>> I/O" commit. New sleeping queue is introduced to separate user space
>> and kernel space wake_ups. runtime->nowake is renamed to twake
>> (transfer wake).
>>
>> Jaroslav: Can you share your thought as you are author of this patch?
>
> I don't understand what's the problem in this thread...
>
> The behavior of PAUSED stream in wait_for_avail() is clear.  If it's
> woken up by some events, it simply goes to sleep again without exiting
> the loop.

We are facing the following issue and want to understand how ALSA is
implemented pause, prepare and write if used asynchronously.

for the every seek operation we issue pause and prepare, till now in all
the system the issue of (pause + prepare) commands and write are
serialized.
we are trying to decouple the write and other operation (pause and
prepare) to issue in commands asynchronously.

Assume the case below, write is blocked in wait_for_avail as there is no
space for the buffer, in between user issued seek on the same session this
triggers pause and prepare operations.

pause command will unblock the thread blocked in wait_for_avail, this
unblocked thread once again check if buffer avail and if buffer is not
avail it goes for wait in loop.
after the pause operation is done, HAL issues prepare in prepare we reset
the buffer but never unblock the thread waiting in the wait_for_avail.
this results in write thread blocked forever and it never gets unblocked
as a result the session is blocked.

please help us to know why the implementation of the pause and prepare is
this way and are we allowed to do the pause, prepare and write in
asynchronously on the same session in copy interface.




>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
