From: Florian <alsa@bome.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Tue, 24 Apr 2007 15:27:23 +0200
Message-ID: <462E05BB.4000300@bome.com>
References: <461FD727.8080400@bome.com>
	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>
	<s5hmz0y0w6m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 79F91248FB
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 15:27:27 +0200 (CEST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 366579822B
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 15:27:27 +0200 (CEST)
Received: from host-82-135-28-137.customer.m-online.net
	(host-82-135-28-137.customer.m-online.net [82.135.28.137])
	by mail.mnet-online.de (Postfix) with ESMTP id 2587B901D5
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 15:27:27 +0200 (CEST)
Received: from [9.2.35.39] (yktgi01e0-s5.watson.ibm.com [129.34.20.19])
	by host-82-135-28-137.customer.m-online.net (Postfix) with ESMTP id
	86F9A1C5B9 for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 15:27:26 +0200 (CEST)
In-Reply-To: <s5hmz0y0w6m.wl%tiwai@suse.de>
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

Thanks for the reply. The relevant excerpt from /proc/ioports is

3000-3fff : PCI Bus #02
  3000-303f : 0000:02:01.0
    3000-303f : ICE1712
  3040-305f : 0000:02:01.0
    3040-305f : ICE1712
  3060-306f : 0000:02:01.0
    3060-306f : ICE1712
  3070-307f : 0000:02:01.0
    3070-307f : ICE1712
[full listing at end of message]

so I guess 304C is in range of the M-Audio Audiophile 24/96. Any
other ideas what I can try, either in ALSA code or elsewhere?

Thanks,
Florian


On 4/24/2007 2:54 PM, Takashi Iwai wrote:
> At Wed, 18 Apr 2007 17:15:41 +0200,
> Florian wrote:
>> thanks for the reply. Some more info:
>> - system is RH Enterprise AS 4 update 4
>> - the soundcard is in a 64-bit PCI-X slot (so few soundcards fit
>>   at all)
>> - pcm with ice1712 is working fine
>> - I disabled /proc/sys/kernel/panic_on_oops, but it still rebooted
>>   the same way. Is there another way to prevent rebooting on panic
>>   or so?
>> - by using printk with serial console, I could trace the reboot to
>>   occur at the very first outb() call in mpu401_uart.c:64
>>   with data 0, addr 0x304C
> 
> The address sounds a bit strange to me, but maybe depending on BIOS.
> Check /proc/ioports whether this really is within the range of the
> corresponding soundcard.
> 


0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f8-03ff : serial
04d0-04d1 : pnp 00:05
1000-10ff : 0000:00:07.5
  1000-10ff : AMD AMD8111
1100-117f : pnp 00:05
1180-11ff : pnp 00:05
1400-143f : 0000:00:07.5
  1400-143f : AMD AMD8111
1440-145f : 0000:00:07.2
  1440-145f : amd8111_smbus2
1460-146f : 0000:00:07.1
  1460-1467 : ide0
  1468-146f : ide1
2000-2fff : PCI Bus #01
  2000-200f : 0000:01:02.0
    2000-200f : sata_sil
  2010-2013 : 0000:01:02.0
    2010-2013 : sata_sil
  2014-2017 : 0000:01:02.0
    2014-2017 : sata_sil
  2018-201f : 0000:01:02.0
    2018-201f : sata_sil
  2020-2027 : 0000:01:02.0
    2020-2027 : sata_sil
3000-3fff : PCI Bus #02
  3000-303f : 0000:02:01.0
    3000-303f : ICE1712
  3040-305f : 0000:02:01.0
    3040-305f : ICE1712
  3060-306f : 0000:02:01.0
    3060-306f : ICE1712
  3070-307f : 0000:02:01.0
    3070-307f : ICE1712
4000-4fff : PCI Bus #81
  4000-4fff : PCI Bus #83
    4000-40ff : 0000:83:04.0
    4400-44ff : 0000:83:04.0
    4800-48ff : 0000:83:04.1
    4c00-4cff : 0000:83:04.1
8000-8003 : PM1a_EVT_BLK
8004-8005 : PM1a_CNT_BLK
8008-800b : PM_TMR
8010-8015 : ACPI CPU throttle
8020-8023 : GPE0_BLK
80b0-80b7 : GPE1_BLK
80e0-80ef : amd756_smbus
