From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: intel8x0 has stopped working.
Date: Thu, 05 Feb 2004 22:28:03 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4022C373.7060601@superbug.demon.co.uk>
References: <401E8BAE.6010802@superbug.demon.co.uk>	<s5hn081uztv.wl@alsa2.suse.de>	<401EA82D.3060702@superbug.demon.co.uk>	<s5hwu72aba0.wl@alsa2.suse.de>	<40217A56.2020808@superbug.demon.co.uk> <s5hr7x98ga5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010202080409040203000009"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA10673
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 23:20:52 +0100
In-Reply-To: <s5hr7x98ga5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010202080409040203000009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Wed, 04 Feb 2004 23:03:50 +0000,
> James Courtier-Dutton wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Mon, 02 Feb 2004 19:42:37 +0000,
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>Once thing I have noticed, is that with the alc650, we used to have VRA 
>>>>(alsa 0.9.8), but the 1.0.2 intel8x0 driver ignores the VRA and fixes 
>>>>itself at 48000.
>>>
>>>
>>>yes, the detection of sample rate range seems broken for some codecs.
>>>it was completely rewritten using the generic ac97_pcm.c.
>>>
>>>could you check the debug messages with the attached patch?
>>>
>>>
>>>Takashi
>>>
>>
>>Here is the output as requested.
> 
> 
> thanks, could you try the attached patch again and show the kernel
> messages?
> (this might fix the detection, too, BTW.)
> 
> 
> Takashi
> 
> 

I checked out a new anonymouse cvs of alsa-driver/alsa-kernel, applied 
your patch, and attach the output from doing modprobe snd-intel8x0.

I can only see printf's in the patch, so I don't see how it could have 
fixes the VRA.

I can still only access device "hw" with rate of 48000.

I hope this helps.

Cheers
James


--------------010202080409040203000009
Content-Type: text/plain;
 name="intel8x0-rep2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intel8x0-rep2"

Feb  5 22:22:53 new kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb  5 22:22:53 new kernel: determined VRA rates: 0xfe
Feb  5 22:22:53 new kernel: determined VRA rates: 0xfe
Feb  5 22:22:53 new kernel: determined SPDIF rates: 0xe0
Feb  5 22:22:53 new kernel: determined SDAC rates: 0x80
Feb  5 22:22:53 new kernel: determined LDAC rates: 0x80
Feb  5 22:22:53 new kernel: ALSA /usr/local/alsacvs/alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c:2188: applying quirk type -430154656 failed (-22)
Feb  5 22:22:53 new kernel: get_pslots: rev22 amap emu
Feb  5 22:22:53 new kernel: get_pslots: AMAP: addr=0, scaps=0xd, ext_id=0x5c7
Feb  5 22:22:53 new kernel: checking codec 0, slots = 0x3d8 / 0x58
Feb  5 22:22:53 new kernel: -> capture slots = 0x58
Feb  5 22:22:53 new kernel: probing pcm 0
Feb  5 22:22:53 new kernel: .. probing codec 0, slots = 0x3d8, tmp = 0x3d8
Feb  5 22:22:53 new kernel: .. exclusive tmp = 0x3d8
Feb  5 22:22:53 new kernel: ..... tmp = 0x3d8
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=3, reg=0x2c, rates=0xfe
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=4, reg=0x2c, rates=0xfe
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=6, reg=0x30, rates=0x80
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=7, reg=0x2e, rates=0x80
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=8, reg=0x2e, rates=0x80
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=9, reg=0x30, rates=0x80
Feb  5 22:22:53 new kernel: .. rslots = 0x3d8, rate_table = 0, rates = 0x80
Feb  5 22:22:53 new kernel: --> slots = 0x3d8, rates = 0x80
Feb  5 22:22:53 new kernel: probing pcm 1
Feb  5 22:22:53 new kernel: .. probing codec 0, slots = 0x18, tmp = 0x58
Feb  5 22:22:53 new kernel: .. exclusive tmp = 0x18
Feb  5 22:22:53 new kernel: ..... tmp = 0x18
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=3, reg=0x32, rates=0xfe
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=4, reg=0x32, rates=0xfe
Feb  5 22:22:53 new kernel: .. rslots = 0x18, rate_table = 0, rates = 0xfe
Feb  5 22:22:53 new kernel: --> slots = 0x18, rates = 0xfe
Feb  5 22:22:53 new kernel: probing pcm 2
Feb  5 22:22:53 new kernel: .. probing codec 0, slots = 0x40, tmp = 0x40
Feb  5 22:22:53 new kernel: .. exclusive tmp = 0x40
Feb  5 22:22:53 new kernel: ..... tmp = 0x40
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=6, reg=0x34, rates=0x80
Feb  5 22:22:53 new kernel: .. rslots = 0x40, rate_table = 0, rates = 0x80
Feb  5 22:22:53 new kernel: --> slots = 0x40, rates = 0x80
Feb  5 22:22:53 new kernel: probing pcm 3
Feb  5 22:22:53 new kernel: .. probing codec 0, slots = 0xc00, tmp = 0xc00
Feb  5 22:22:53 new kernel: .. exclusive tmp = 0xc00
Feb  5 22:22:53 new kernel: ..... tmp = 0xc00
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=10, reg=0x3a, rates=0xe0
Feb  5 22:22:53 new kernel: get_rates: cidx=0, slot=11, reg=0x3a, rates=0xe0
Feb  5 22:22:53 new kernel: .. rslots = 0xc00, rate_table = 0, rates = 0xe0
Feb  5 22:22:53 new kernel: --> slots = 0xc00, rates = 0xe0
Feb  5 22:22:53 new kernel: probing pcm 4
Feb  5 22:22:53 new kernel: .. probing codec 0, slots = 0x18, tmp = 0x0
Feb  5 22:22:53 new kernel: .. exclusive tmp = 0x0
Feb  5 22:22:53 new kernel: ..... tmp = 0x0
Feb  5 22:22:53 new kernel: --> slots = 0x0, rates = 0xffffffff
Feb  5 22:22:53 new kernel: probing pcm 5
Feb  5 22:22:53 new kernel: .. probing codec 0, slots = 0x40, tmp = 0x0
Feb  5 22:22:53 new kernel: .. exclusive tmp = 0x0
Feb  5 22:22:53 new kernel: ..... tmp = 0x0
Feb  5 22:22:53 new kernel: --> slots = 0x0, rates = 0xffffffff
Feb  5 22:22:53 new kernel: intel8x0: clocking to 48000


--------------010202080409040203000009--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
