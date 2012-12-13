From: Bent Bisballe Nyeng <deva@aasimon.org>
Subject: Re: Intel HD: ALC662 noise-bug on FitPC2i
Date: Thu, 13 Dec 2012 08:58:09 +0100
Message-ID: <50C98A91.4040304@aasimon.org>
References: <1355321775-2042-1-git-send-email-mengdong.lin@intel.com>
 <50C83190.7050001@aasimon.org> <50C880FC.20409@ladisch.de>
 <50C88351.3030401@aasimon.org> <s5hmwxjfiu4.wl%tiwai@suse.de>
 <50C8989A.3030804@aasimon.org> <s5hfw3bfhn8.wl%tiwai@suse.de>
 <50C8CD62.3080303@aasimon.org> <s5hip87rsq7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aasimon.org (unknown [78.143.82.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 722042615FC
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 08:58:10 +0100 (CET)
Received: from [192.168.0.10] (deva [192.168.0.10])
 by aasimon.org (Postfix) with ESMTP id A6FB2BC38
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 08:58:09 +0100 (CET)
In-Reply-To: <s5hip87rsq7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/12/12 20:11, Takashi Iwai wrote:
> At Wed, 12 Dec 2012 19:30:58 +0100,
> Bent Bisballe Nyeng wrote:
>>
>> On 12/12/12 15:51, Takashi Iwai wrote:
>>> At Wed, 12 Dec 2012 15:45:46 +0100,
>>> Bent Bisballe Nyeng wrote:
>>>>
>>>> On 12/12/12 15:25, Takashi Iwai wrote:
>>>>> At Wed, 12 Dec 2012 14:14:57 +0100,
>>>>> Bent Bisballe Nyeng wrote:
>>>>>>
>>>>>> On 12/12/12 14:05, Clemens Ladisch wrote:
>>>>>>> Bent Bisballe Nyeng wrote:
>>>>>>>> When recording, audible clicking sounds are present in the resulting
>>>>>>>> audio data.
>>>>>>>>
>>>>>>>> The corruption are composed of approximately 10 samples, and the
>>>>>>>> nature of the corrupted values are such that they could come from an
>>>>>>>> earlier buffer (the corrupted data resemble wav forms).
>>>>>>>
>>>>>>> This looks like a problem with your HDA controller; either the memory
>>>>>>> bus is overloaded so that some writes are dropped, or the hardware is
>>>>>>> just buggy.
>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Clemens
>>>>>>
>>>>>> I tried to record some audio using windows 7 and here the noise was not
>>>>>> present indicating that it is not buggy hardware.
>>>>>>
>>>>>> Also, the system was not under load when the arecord call was made so if
>>>>>> the memory bus was overloaded I need another way to verify this.
>>>>>>
>>>>>> Are there any additional (useful) debugging info I can subtract from the
>>>>>> system that will help aiding the debugging process?
>>>>>
>>>>> Which sound backend are you using at all?  Does the problem appear if
>>>>> you run with -Dhw for arecord?
>>>>>
>>>>> If it's using dsnoop or PulseAudio, the accuracy of DMA position
>>>>> reporting plays a big role.  In that case, changing position_fix
>>>>> option cures often.
>>>>>
>>>>> Takashi
>>>>
>>>> There are no sound servers installed on the pc in question (it is a
>>>> 'lean' pc) so arecord should be using the hardware directly already.
>>>
>>> If you are using alsa-lib as is, it must be using dsnoop as default,
>>> which is pretty different from hw.
>>>
>>>
>>> Takashi
>>
>> Running arecord with -Dhw did not solve the issue.
>>
>> I played around with the buffer-size and have concluded that even with a
>> very large buffer the ticks are still present, precisely one tick per
>> buffer. This results in fever ticks with greater buffer sizes, but ticks
>> non-the-less.
>>
>> Are there any special kernel parameters that I should set in order to
>> make audio smooth?
> 
> As I wrote, check position_fix option.
> 
> 
> Takashi

Setting the position_fix=2 (use the position-buffer) did the trick. It
now records nice and smooth.

Thank you very much for your help Takashi.

In the kernel documentation on the intel hda driver it is described that
the position_fix parameter defaults to using the position_buffer, but
falls back to the LPIB register if the position_buffer appears dead.

Does this mean that on my specific chip the position_buffer seems dead
even though it isn't and the LPIB register doesn't work correctly?

Furthermore it is not clear to me what (if any?) the difference between
the default value 0 and the value 2? Does 2 read the position-buffer
without mmap and are therefore more CPU hungry than 0?

Kind regards
Bent Bisballe Nyeng
