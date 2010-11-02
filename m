From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Tue, 2 Nov 2010 09:17:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011020850550.29422@eeebox2.perex-int.cz>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5h8w1c18no.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EFBE2444F
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 09:17:34 +0100 (CET)
In-Reply-To: <s5h8w1c18no.wl%tiwai@suse.de>
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

> At Mon,  1 Nov 2010 17:12:53 -0500,
> Pierre-Louis Bossart wrote:
>>
>> Merged and cleaned patch based on earlier patches posted
>> on alsa-devel by Clemens Ladisch <clemens@ladisch.de> and
>> Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
>>
>> This patch disables period interrupts which are not
>> needed when the application relies on a system timer
>> to wake-up and refill the ring buffer. The behavior of
>> the driver is left unchanged, and interrupts are only
>> disabled if the application requests this configuration.
>> The behavior in case of underruns is slightly different,
>> instead of being detected during the period interrupts the
>> underruns are detected when the application calls
>> snd_pcm_update_avail, which in turns forces a refresh of the
>> hw pointer and shows the buffer is empty.
>
> So, this silently assumes that the applications do call
> snd_pcm_update_avail() appropriately at the right timing?
> If so, any sense to check XRUN in the driver at all...?
>
> And, even more, any sense to report the incremental position by this
> approach?  The only reliable information in this case is the offset in
> the ring buffer.  The linear position as the current ALSA API provides
> isn't guaranteed without the period irq.

We can detect the buffer size crossing using jiffies, but I agree, it's 
something which should be added to the patch to not break hw_ptr in 
case when the application does not call the update function in time.
We have both values in runtime->hw_ptr_jiffies and 
runtime->hw_ptr_buffer_jiffies.

Also, I would remove IRQ or interrupt from the API and use something 
like "no period ack" or so. IRQ is very hardware specific and some drivers 
does not use direct interrupts but another timing sources for period 
acks.

>> +#define SNDRV_PCM_INFO_NO_PERIOD_IRQ    0x00800000      /* period interrupt can be disabled */

#define SNDRV_PCM_INFO_NO_PERIOD_ACK	0x00800000	/* period transfer acknowledge can be disabled */


 				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
