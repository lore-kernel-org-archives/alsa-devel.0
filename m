From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: MIDI on ice1724 -  real-time kernel problem
Date: Thu, 08 May 2008 21:35:51 +0200
Message-ID: <48235617.2070906@insite.cz>
References: <480E495B.20607@insite.cz>	<s5h63u8evih.wl%tiwai@suse.de>	<480F189A.7030500@insite.cz>	<480F99B8.3010408@insite.cz>	<s5hod7zb4j7.wl%tiwai@suse.de>	<4810F1FA.4020300@insite.cz>	<s5hhcdq4fnz.wl%tiwai@suse.de>	<481182EB.1010800@insite.cz>	<s5h63u64dgt.wl%tiwai@suse.de>	<4818D18E.5040409@insite.cz>	<s5htzhgub9a.wl%tiwai@suse.de>	<481CB902.9080905@insite.cz>
	<s5hd4nyh0lz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 295C62451F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 21:36:01 +0200 (CEST)
In-Reply-To: <s5hd4nyh0lz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 03 May 2008 21:12:02 +0200,
> Pavel Hofman wrote:
>>
>>
>> Takashi Iwai wrote:
>>> At Wed, 30 Apr 2008 22:07:42 +0200,
>>> Pavel Hofman wrote:
>>>> Takashi Iwai wrote:
>>>>> At Fri, 25 Apr 2008 09:06:19 +0200,
>>>>> Pavel Hofman wrote:
>>>> The code works fine on standard kernel.
>>>>
>>>> But in the RT kernel of Ubuntu 7.10 (2.6.22-14-rt, 1000HZ compared to
>>>> 250HZ of the -generic kernel), MIDI interrupts get thrown continuously,
>>>> hogging CPU with the IRQXX "process".
>>>>
>>>> When playing 44.1kHz audio with buffer size of 32768,
>>>> snd_vt1724_interrupt is called every 185ms. With the buffer size of 
>>>> 4096, it is every 23ms. So far so good.
>>>>
>>>> But when I try to output some midi, the routine gets called every 24us
>>>> (i.e. 1000 times faster). Comparing the time difference between my
>>>> several debug printk's in snd_vt1724_interrupt (approx. 5us between each
>>>> printk record a few lines of code apart) and between each call of the
>>>> method (24us), I thought there would be a loop somewhere in the
>>>> interrupt handler calling code. But /proc/interrupts really shows over
>>>> 40k interrupts a second for ICE1724.
>>>>
>>>> Changing the watermarks up to 0x1f makes no difference.
>>> That looks bad.
>>>
>>>> Masking the MIDI interrupts works, snd_vt1724_interrupt is called only
>>>> during VT1724_IRQ_MTPCM interrupts, with the MIDI status bits
>>>> MPU_TX/MPU_RX set when reading/writing with amidi.
>>> Hm, is it TX or RX, or in both cases?
>>> Could you check which one (TX or RX) causes this?
>>>
>> Both reading (amidi -p hw:0 -d) and writing (amidi -p hw:0 -S 
>> F0411042110C000000000074FF0411042110C000000) starts the TX interrupt 
>> flood (irq status: 0x20) immediately. Upon opening input as well as 
>> output the method snd_mpu401_do_reset is called - is perhaps the culprit 
>> somewhere there?
> 
> Possibly.  It write 0x00 to data at the beginning in
> snd_mpu401_uart_cmd().  What happens if you remove it?
> 

Unfortunately nothing, no change.

Actually, when does the MPU_TX interrupt get thrown? Upon exhausting 
some output buffer? I understand interrupts for DMA, but mpu uart does 
not use DMA, right?

Thanks a lot for help, I am not giving up :)

Pavel.
