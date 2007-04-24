From: Florian <alsa@bome.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Tue, 24 Apr 2007 16:53:20 +0200
Message-ID: <462E19E0.6040206@bome.com>
References: <461FD727.8080400@bome.com>	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E05BB.4000300@bome.com>	<s5h8xch28o2.wl%tiwai@suse.de>	<462E099A.7000702@bome.com>	<s5h7is1284n.wl%tiwai@suse.de>	<462E103A.3080601@bome.com>
	<s5hzm4xzw8w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 16C0524591
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 16:53:23 +0200 (CEST)
In-Reply-To: <s5hzm4xzw8w.wl%tiwai@suse.de>
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

> When the hang-up occurs at the first write, it must be in 
> snd_mpu401_uart_cmd().  At the very beginning, it calls 
> mpu->write(mpu, 0x00, MPU401D(mpu)); Try to comment out this and
> see what happens.

I had tried that - I think that I just commented out the reset
command. It would not crash or reboot, but it did not haver
functionality either.

> Do I understand correctly that this bug happens when you open a 
> rawmidi device for read, e.g. % cat /dev/snd/midiC0D0 > /dev/null
> 
yes. I usually used
amidi -p hw:0 -d

> Perhaps an easiest but foolishest way to trace this is to put
> printk at each io-port access and any other important points, and
> give some sleep at each point, then watch the kernel message.
> You can get rid of spin_lock_*() around that, just for testing.

I've done this until I traced it to the first outb() call, i.e. the
initialization mentioned above. The first outb() will cause the reboot.

Florian


> ??
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
