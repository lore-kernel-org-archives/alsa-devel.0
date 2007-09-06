From: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Subject: Re: DMA buffer gets played only once
Date: Thu, 06 Sep 2007 11:57:03 +0530
Message-ID: <46DF9DB7.80705@hrz.tu-chemnitz.de>
References: <46DE4AB1.20206@hrz.tu-chemnitz.de>	<1188983079.7844.1208974467@webmail.messagingengine.com>	<46DE7422.5020900@hrz.tu-chemnitz.de>	<s5hbqch8e5o.wl%tiwai@suse.de>	<46DF83C6.1090002@hrz.tu-chemnitz.de>	<Pine.LNX.4.58.0709052207551.31808@shell4.speakeasy.net>
	<46DF99E6.30608@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from john.hrz.tu-chemnitz.de (john.hrz.tu-chemnitz.de
	[134.109.132.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AB551037F5
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 08:25:26 +0200 (CEST)
In-Reply-To: <46DF99E6.30608@hrz.tu-chemnitz.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just found out that the problem of multiple calls of 
TRIGGER_START/TRIGGER_STOP might be caused by using ossplay (oss 
emulation layer) for testing. If I use aplay, TRIGGER_START gets called 
once but then Alsa goes in a loop continuously calling pcm_pointer().
Return values of pcm_pointer() look like the following:

---snip---
pcm_pointer returns 0
pcm_pointer returns 1024
pcm_pointer returns 2048
pcm_pointer returns 3072
pcm_pointer returns 4096
pcm_pointer returns 5120
pcm_pointer returns 6144
pcm_pointer returns 7168
pcm_pointer returns 0
pcm_pointer returns 1024
pcm_pointer returns 2048
pcm_pointer returns 3072
pcm_pointer returns 4096
pcm_pointer returns 5120
pcm_pointer returns 6144
pcm_pointer returns 7168
---snap---

Finally I get a message saying:

---snip---
ALSA sound/core/pcm_native.c:1525: playback drain error (DMA or IRQ 
trouble?)
---snap---

Hope this helps.

Regards,
Markus Franke

Markus Franke wrote:
> Hi,
> 
> Trent Piepho wrote:
>> You need to make sure the buffer size is an integer multiple of the period
>> size if you wrap like this.
> 
> Yeah I have to take care of this but right now my buffersize is 32768 
> bytes and the period size is 4096 bytes which should work I think.
> 
>> I found that ALSA would call TRIGGER_STOP if it detected an overrun.
> 
> Yeah that's right. I guess this is my case because xrun() is getting 
> called somewhere. So how can I fix this underrun problem?
> 
>> Check the value returned for every call of your pointer callback.  I found out
>> that ALSA was calling the pointer callback before the first IRQ, which was
>> something I hadn't planned on and the values confused ALSA.
> 
> That's not my case. pcm_pointer gets called after the first DMA 
> transaction is finished. (DMA transfer finished callback gets called 
> before pcm_pointer) Also the values which are returned by pcm_pointer 
> look quite reasonable. (see also my very first posting in this thread, 
> look for the printk's "pcm_pointer returns <value>")
> 
> 
> Thanks for your effort,
> 
> Markus Franke
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
