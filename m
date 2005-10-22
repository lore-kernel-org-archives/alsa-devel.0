From: Tilman Kranz <tilman.kranz@tk-sls.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/ca0106 ca_midi.c,...
Date: Sat, 22 Oct 2005 06:48:03 +0200
Message-ID: <4359C483.4010102@tk-sls.de>
References: <E1ESiQD-0008Jo-Eq@sc8-pr-cvs1.sourceforge.net>	<s5hll0ni3ui.wl%tiwai@suse.de>	<4358D4F1.6020602@superbug.co.uk> <s5hhdbbhvcx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.tk-sls.de (linuxfoo.de [83.151.18.109])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 60AF013E
	for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2005 06:48:14 +0200 (MEST)
In-Reply-To: <s5hhdbbhvcx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Fri, 21 Oct 2005 12:45:53 +0100,
>James Courtier-Dutton wrote:
>  
>
>>Takashi Iwai wrote:
>>    
>>
>>>But, what is the reason to call them indirectly via pointers at all?
>>>The routine is just for ca0106, so no complex abstraction is
>>>necessary.
>>>      
>>>
>>The same ca_midi.c file should work with the emu10k1x, sb live, sb 
>>audigy1/2.
>>Once this midi code is tested well, we can then share the code amongst 
>>all the different modules.
>>So the indirection is for that purpose.
>>    
>>
>For such a purpose, we can merge it to mpu401_uart.c, instead.
>Many codes are same, and mpu401_uart has already indirect read/write
>function pointers.  Only additional irq_enable/disable callbacks would
>be required.
>  
>
Hello.

First of all, I just tried ALSA CVS alsa-driver and alsa-kernel with my
Audigy LS model SB0312. MIDI I/O with the card works. Have many thanks
for letting those changes in.

... plays a little tune of gratitude...

I now would like to comment on what I did.

I am perfectly aware of my ca_midi.c being the at least 2nd reimplementation
of an MPU401 driver and I want to apologize for this introduction
of redundancy.

My implementation was result-driven and I wanted to go back to the working
implementation that is most close to my board. It happened to be emu10k1x.
I could reuse the algorithms 1:1.

Function pointers in ca_midi_t were introduced to enable emu10k1x to use
the code as well, if they want to. As opposed to emu10k1x, every read/write
dereferences the ca_midi_t to the hardware specific read_write which, as
Takashi Iwai already pointed out, happens to be the way mpu401 does it 
as well.

Greetings,
Tilman.



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
