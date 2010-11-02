From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Tue, 2 Nov 2010 10:02:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011020957590.29422@eeebox2.perex-int.cz>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5h8w1c18no.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020850550.29422@eeebox2.perex-int.cz>
	<s5h4oc016eq.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020923430.29422@eeebox2.perex-int.cz>
	<s5h1v7415ih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id ED95A1038E5
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 10:02:49 +0100 (CET)
In-Reply-To: <s5h1v7415ih.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Nov 2010, Takashi Iwai wrote:

> At Tue, 2 Nov 2010 09:26:48 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> On Tue, 2 Nov 2010, Takashi Iwai wrote:
>>
>>> At Tue, 2 Nov 2010 09:17:33 +0100 (CET),
>>> Jaroslav Kysela wrote:
>>>>
>>>> On Tue, 2 Nov 2010, Takashi Iwai wrote:
>>>>
>>>>> At Mon,  1 Nov 2010 17:12:53 -0500,
>>>>> Pierre-Louis Bossart wrote:
>>>>>>
>>>>>> Merged and cleaned patch based on earlier patches posted
>>>>>> on alsa-devel by Clemens Ladisch <clemens@ladisch.de> and
>>>>>> Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
>>>>>>
>>>>>> This patch disables period interrupts which are not
>>>>>> needed when the application relies on a system timer
>>>>>> to wake-up and refill the ring buffer. The behavior of
>>>>>> the driver is left unchanged, and interrupts are only
>>>>>> disabled if the application requests this configuration.
>>>>>> The behavior in case of underruns is slightly different,
>>>>>> instead of being detected during the period interrupts the
>>>>>> underruns are detected when the application calls
>>>>>> snd_pcm_update_avail, which in turns forces a refresh of the
>>>>>> hw pointer and shows the buffer is empty.
>>>>>
>>>>> So, this silently assumes that the applications do call
>>>>> snd_pcm_update_avail() appropriately at the right timing?
>>>>> If so, any sense to check XRUN in the driver at all...?
>>>>>
>>>>> And, even more, any sense to report the incremental position by this
>>>>> approach?  The only reliable information in this case is the offset in
>>>>> the ring buffer.  The linear position as the current ALSA API provides
>>>>> isn't guaranteed without the period irq.
>>>>
>>>> We can detect the buffer size crossing using jiffies, but I agree, it's
>>>> something which should be added to the patch to not break hw_ptr in
>>>> case when the application does not call the update function in time.
>>>> We have both values in runtime->hw_ptr_jiffies and
>>>> runtime->hw_ptr_buffer_jiffies.
>>>
>>> But I thought this patch also disabled the jiffies check?
>>
>> These values are not related only to the debug jiffies check. I'm using
>> these values also to detect the double irq acks which were discovered
>> recently.
>
> Ah, OK, I overlooked it.
>
>>> I feel that some bottom-line check is needed if we keep the linear
>>> position over the buffer size even without the period irq.
>>> If the app doesn't care, OK fine, the driver shouldn't care, too.
>>> But then it doesn't make sense to keep the linear position, either.
>>
>> But if we can keep the linear position using the light-weight jiffies
>> check, it's probably OK to keep it rather than changing the hw_ptr
>> behaviour.
>
> Well, but the point of the patch is to avoid wakeups as much as
> possible.  The jiffies-check adds an unconditional wakeup for each
> buffer size, thus it's against the purpose of the patch.

I don't see any wakeup. It's just about to compare the current jiffies 
with last hw_ptr update jiffies. The multiple buffer size crossing can be 
detected.

> So, basically we need to decide whether
> - to check via jiffies as a bottom-line; then no big merit over period=1

No, the difference is that no interrupts are really required.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
