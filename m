From: Florian <alsa@bome.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Tue, 24 Apr 2007 16:12:10 +0200
Message-ID: <462E103A.3080601@bome.com>
References: <461FD727.8080400@bome.com>
	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>
	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E05BB.4000300@bome.com>
	<s5h8xch28o2.wl%tiwai@suse.de>	<462E099A.7000702@bome.com>
	<s5h7is1284n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by alsa0.perex.cz (Postfix) with ESMTP id DD80E24900
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 16:12:12 +0200 (CEST)
In-Reply-To: <s5h7is1284n.wl%tiwai@suse.de>
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

lspci -v shows:

02:01.0 Multimedia audio controller: VIA Technologies Inc. ICE1712
[Envy24] PCI Multi-Channel I/O Controller (rev 02)
        Subsystem: VIA Technologies Inc. M-Audio Delta Audiophile
        Flags: bus master, medium devsel, latency 64, IRQ 20
        I/O ports at 3040 [size=32]
        I/O ports at 3070 [size=16]
        I/O ports at 3060 [size=16]
        I/O ports at 3000 [size=64]
        Capabilities: [80] Power Management version 1

Florian


On 4/24/2007 3:51 PM, Takashi Iwai wrote:
> At Tue, 24 Apr 2007 15:43:54 +0200,
> Florian wrote:
>> Hi Takashi,
>>
>> the ice1712 points to 0x3040.
> 
> Hm...  could you show the output of "lspci -v" (regarding ice1712) ?
> I wonder why 0x3000-0x303f is ignored.
> 
> 
> Takashi
> 
>> Thanks,
>> Florian
>>
>>
>> On 4/24/2007 3:39 PM, Takashi Iwai wrote:
>>> At Tue, 24 Apr 2007 15:27:23 +0200,
>>> Florian wrote:
>>>> Thanks for the reply. The relevant excerpt from /proc/ioports is
>>>>
>>>> 3000-3fff : PCI Bus #02
>>>>   3000-303f : 0000:02:01.0
>>>>     3000-303f : ICE1712
>>>>   3040-305f : 0000:02:01.0
>>>>     3040-305f : ICE1712
>>>>   3060-306f : 0000:02:01.0
>>>>     3060-306f : ICE1712
>>>>   3070-307f : 0000:02:01.0
>>>>     3070-307f : ICE1712
>>>> [full listing at end of message]
>>>>
>>>> so I guess 304C is in range of the M-Audio Audiophile 24/96. Any
>>>> other ideas what I can try, either in ALSA code or elsewhere?
>>> What shows /proc/asound/cards?  Does it point 0x3000 or 0x3040?
>>>
>>>
>>> Takashi
>>>
>>>
>> -- 
>> Florian Bomers
>> bome.com
>>
>> -------------------------------------------------------
>> Music Software, Development Tools:  http://www.bome.com
>> Java Sound extensions, plugins: http://www.tritonus.org
>> The Java Sound Resources:    http://www.jsresources.org
>> -------------------------------------------------------
>> Please quote this email in your reply. Thanks!
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
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
