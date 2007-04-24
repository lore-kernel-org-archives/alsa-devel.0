From: Florian <alsa@bome.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Tue, 24 Apr 2007 19:51:50 +0200
Message-ID: <462E43B6.7050401@bome.com>
References: <461FD727.8080400@bome.com>	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E05BB.4000300@bome.com>	<s5h8xch28o2.wl%tiwai@suse.de>	<462E099A.7000702@bome.com>	<s5h7is1284n.wl%tiwai@suse.de>	<462E103A.3080601@bome.com>	<s5hzm4xzw8w.wl%tiwai@suse.de>	<462E19E0.6040206@bome.com>
	<s5hps5tzue1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 4539F2491A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 19:51:54 +0200 (CEST)
In-Reply-To: <s5hps5tzue1.wl%tiwai@suse.de>
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

IT WORKED! I fixed it in this way:

mpu401_uart.c:229

if (mpu->hardware != MPU401_HW_TRID4DWAVE
    && mpu->hardware != MPU401_HW_ICE1712) {
	mpu->write(mpu, 0x00, MPU401D(mpu));
	/*snd_mpu401_uart_clear_rx(mpu);*/
}

I don't know if this will work on non-AMD machines and if it will
work on all ice1712 machines... Next week I can test it with
different M-Audio cards on single-processor machines (Pentium and AMD).

Thanks a lot!
Florian


On 4/24/2007 5:04 PM, Takashi Iwai wrote:
> At Tue, 24 Apr 2007 16:53:20 +0200,
> Florian wrote:
>>> When the hang-up occurs at the first write, it must be in 
>>> snd_mpu401_uart_cmd().  At the very beginning, it calls 
>>> mpu->write(mpu, 0x00, MPU401D(mpu)); Try to comment out this and
>>> see what happens.
>> I had tried that - I think that I just commented out the reset
>> command.
> 
> The reset command contains a series of writes.  The write access (zero
> to 0x304c) is the very first part, and this isn't always necessary.
> For example, trident doesn't like this sequence.  So, just commenting
> out this write should be fairly harmless to the later behavior.
> 
> So, commenting only the first zero write is worth to try (if you
> didn't do yet).
> 
> 
>> It would not crash or reboot, but it did not haver
>> functionality either.
>  
>>> Do I understand correctly that this bug happens when you open a 
>>> rawmidi device for read, e.g. % cat /dev/snd/midiC0D0 > /dev/null
>>>
>> yes. I usually used
>> amidi -p hw:0 -d
>>
>>> Perhaps an easiest but foolishest way to trace this is to put
>>> printk at each io-port access and any other important points, and
>>> give some sleep at each point, then watch the kernel message.
>>> You can get rid of spin_lock_*() around that, just for testing.
>> I've done this until I traced it to the first outb() call, i.e. the
>> initialization mentioned above. The first outb() will cause the reboot.
> 
> And this causes an immediate reboot, not panic or oops, right?
> You shouldn't do this kind of debug on X but on VGA console, BTW.
> 
> 
> Takashi
> 
> 

-- 
Florian Bomers
bome.com

-------------------------------------------------------
Music Software, Development Tools:  http://www.bome.com
Java Sound extensions, plugins: http://www.tritonus.org
The Java Sound Resources:    http://www.jsresources.org
-------------------------------------------------------
Please quote this email in your reply. Thanks!
