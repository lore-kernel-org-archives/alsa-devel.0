From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Help with supporting Emu10k1x  and question
Date: Sun, 22 Feb 2004 14:09:01 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4038B7FD.6000308@superbug.demon.co.uk>
References: <BAY10-F84ueolj8Jecd00000c83@hotmail.com> <40380089.9040806@superbug.demon.co.uk> <4038AD54.5020702@netzero.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4038AD54.5020702@netzero.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Francisco Moraes <fmoraes74@netzero.net>
Cc: Bastien Aracil <findbastien@hotmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Francisco Moraes wrote:
> 
>>
>> From what I can see for the emu10k1x (aka. sb Live 5.1 from Dell) is 
>> almost exactly the same as the Audigy LS.
>>
>> It is a very simple device, and the driver should be based more like 
>> the  snd-intel8x0 driver than the snd-emu10k1 driver.
>> It has no dsp, and no hardware mixing, and is a single open device. 
>> Very similar to the intel8x0 feature wise.
>>
>> If someone will send me a sample sound card, I will get it working.
> 
> 
> 
> I cannot send you my card but I will try a driver on it without a 
> problem as I have already been experimenting. I can also try to send you 
> my changed emu10k1 driver (with almost everything disabled but pcm and 
> ac97).
> 
> Let me know.
> 
> Francisco
> 
> 

I think you would do better basing your driver on the intel8x0.c code, 
and drop the emu10k1 code effort.
The emu10k1x and sb audigy ls are nothing like the emu10k1 or emu10k2.

Send me the code you already have, and I will help correct it.
Just tell me if you have the Dell SB Live (aka. emu10k1x) or the SB 
Audigy LS.

Cheers
James



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
