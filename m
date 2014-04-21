From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: alsa-utils aplay/arecord can't be interrupted when
 streaming is not active
Date: Sun, 20 Apr 2014 20:01:48 -0700
Message-ID: <53548A1C.4040407@mentor.com>
References: <534E3736.6070100@mentor.com> <534E39F3.4040200@perex.cz>
 <534E407C.10002@mentor.com> <534E4640.5010102@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id CFDDD260840
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 05:01:52 +0200 (CEST)
In-Reply-To: <534E4640.5010102@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslva


On 04/16/2014 01:58 AM, Jaroslav Kysela wrote:
> Date 16.4.2014 10:34, jiwang wrote:
>> Hi Jaroslav
>>
>> On 04/16/2014 05:06 PM, Jaroslav Kysela wrote:
>>> Date 16.4.2014 09:54, jiwang wrote:
>>>> Hi All
>>>>
>>>> With latest 1.0.27.2 alsa-utils, I am facing problem to interrupt
>>>> aplay/arecord
>>>> when the streaming is not active (no data can be written to or read from
>>>> cards)
>>>> further more, if I start aplay/arecord with "-N" nonblocking option,
>>>> then aplay/arecord can never exit, unless I do a system reset
>>> If I/O stalls it's usually problem in the driver. You don't write any
>>> information about your configuration - post 'aplay -v' to see more.
>> This issue is caught when we were doing some tests,
>> test for both correct and incorrect configuration of driver
>> and we expect SIGINT can interrupt aplay/arecord in both cases
>> (which was the cause with the old version 1.0.26)
>>
>>> You may kill the process using the SIGABRT signal.. No reboot is required.
>>
>> Yes, SIGABRT works,
>> But as in our case:
>> CPU dai device is waiting on a external clock,
>> but isnt provided caused the I/O stall
>> the driver is functioning properly and should still be SIGINT-ed in my
>> opinion
>
> The user space received SIGINT, but the current aplay code tries to
> finish the device close sequence. Could you determine, in which syscall
> is the process after you sent SIGINT? A backtrace would be great.
>
Do you have any update on this?
is more log required? do you think it should be fixed in aplay?

Thanks,
Jiada
>>
>> Thanks,
>> Jiada
>>
>>>> I found if I revert the following patch
>>>>
>>>> /commit 1d0042d7e948815f8015c62bc53143eed3b83206//
>>>> //Author: Jaroslav Kysela <perex@perex.cz>//
>>>> //Date:   Mon Apr 8 13:30:54 2013 +0200//
>>>> //
>>>> //    aplay/arecord: change the interrupt handling using snd_pcm_abort()//
>>>> //    //
>>>> //    It is required (exclude the fatal SIGABRT) to call snd_pcm_close()
>>>> and//
>>>> //    the end of work (outside of the interrupt handler). Use new
>>>> snd_pcm_abort()//
>>>> //    function to inform alsa-lib to not ignore EINTR and move the
>>>> in_aborting//
>>>> //    variable to the global scope to be checked in the i/o loops.//
>>>> //    //
>>>> //    Signed-off-by: Jaroslav Kysela <perex@perex.cz>//
>>>> /
>>>> http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=1d0042d7e948815f8015c62bc53143eed3b83206
>>>>
>>>> then aplay/arecord can be interrupted correctly
>>>>
>>>> Is it a defect in aplay.c or did I miss something?
>>>>
>>>> Thanks,
>>>> Jiada
>>>>
>>>
>
>
