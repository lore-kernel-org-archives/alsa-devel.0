From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: my ALS drv gives DMA underrun
Date: Thu, 29 May 2008 16:27:57 +0200
Message-ID: <483EBD6D.5020200@aimvalley.nl>
References: <483D77A5.5020203@aimvalley.nl>
	<75b66ecd0805281710g5852332dw230d30d5995dd279@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr3.xs4all.nl (smtp-vbr3.xs4all.nl [194.109.24.23])
	by alsa0.perex.cz (Postfix) with ESMTP id CD77D2489E
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 16:28:00 +0200 (CEST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id m4TERxwS088491
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 16:28:00 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
Received: from linpc062.aimsys.nl (linpc062.aimsys.nl [10.10.4.142])
	(authenticated bits=0)
	by mail3.aimsys.nl (8.13.4/8.13.4) with ESMTP id m4TERv6l018974
	for <alsa-devel@alsa-project.org>; Thu, 29 May 2008 16:27:57 +0200
In-Reply-To: <75b66ecd0805281710g5852332dw230d30d5995dd279@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, May 28, 2008 at 11:17 AM, Norbert van Bolhuis
> <nvbolhuis@aimvalley.nl> wrote:
>> probably this question is asked many times.
>>
>> Anyway, I hope the experts are willing to help me here.
>> I simply don't know how to avoid the DMA overrun that I'm facing
>> when playing a tone.
> 
> Not calling snd_pcm_period_elapsed at the right time would cause the
> behavior you see.    This function wakes up any apps that are waiting
> to send data to the sound device.
> 
> Where can I find the source code for your driver?
> 
> Lee
> 


thanks for you answer.
I'm a bit reluctant to send the full source code, the driver isn't finished
and will go to a customer first.

snd_pcm_period_elapsed is called many times and of course on every TX DMA irq,
otherwise there wouldn't be calls to snd_pcm_update_hw_ptr_interrupt (see trace).

I noticed that I don't suffer from underruns though, only when doing some
printk's in the kernel the underruns occur. otherwise everything is fine
(DMA keeps running)!

The reason I suspected underrun was because whenever my DMA buffer wraps
back to the start, the sound stops playing and i hear a lot of noise.
When I started to investigate what was going on (with printk's), underruns
occured.

I still wonder what PCM substream->boundary is, it's defined as
"pointer's wrap point".
Does this mean it's the same as nr_of_frames_in_DMA_buffer ?


-- 
This message has been scanned for viruses and is believed to be clean
