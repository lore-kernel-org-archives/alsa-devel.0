From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] fix for ac97->front speaker routing (was
 Re:	Some Patches for emu10k1)
Date: Sun, 27 Jun 2004 00:57:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DE0D5E.7000204@superbug.demon.co.uk>
References: <200406080807.i58878cb012056@www4.pobox.sk>	 <40CF759E.7050102@jfalk.easynet.de> <1088287234.24275.113.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1088287234.24275.113.camel@mindpipe>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net, pzad@pobox.sk, joachim.falk@gmx.de
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Tue, 2004-06-15 at 18:18, Joachim Falk wrote:
> 
>>|>But some FX buses seam to be connected to outputs even if there is no
>>|>code in the dsp. Is that hardcoded in hardware or configurable and if
>>|>yes where ?
>>|
>>|
>>| This is maybe hardware feature or ld10k1 bug. If you connect FX bus
>>| 0,1 to AC97 PCM output I think it will stop to do this.
>>This seams to be a hardware feature of the EMU10K1 I think because if
>>you clear the dsp code than FX bus channels 0,1 and 8,9 will be
>>forwarded to Output channels 0,1 and 8,9. This I can say for sure.
>>The others (2-7 and 10-15) I can not be sure because I have no speakers
>>on these channels or they are not connected to output on my card. But I
>>assume that to be the case too. As soon as you start driving an output
>>within your DSP code the forwarding seams to vanish. I think this can
>>not be a alsa driver feature because you can verify that the DSP really
>>is empty by catting /proc/asound/Live/fx8010_acode. So the alsa driver
>>has no possibility to magically insert some of its one forwardings if
>>none are programmed by the user.
> 
> 
> I believe I have figured this out.  The following lines are taken from
> 8010.h in the kX Project SDK.  This file is basically the same as
> emu10k1.h in the ALSA driver, with some interesting additions.  The
> following lines are *not* present in the ALSA driver:
> 

Have you actually tested changing those bits? Does it actually stop the 
AC97 output reaching the Front speakers?

I have been working on the AudigyLS driver that uses what I will call a 
P17 chip.

The Audigy 2 card has a P16V chip.
The P17 chip is quite similar to the P16V chip.

I have found that the general layout of the chips is that all inputs go 
into the P17 chip. The P17 chip then has some registers that adjust the 
volume of different routes.
For example. On the AudigyLS, all the input from the MIC or LINE IN goes 
via the PLAYBACK parts(not the CAPTURE) of the AC97 chip and into the 
Philips 24bit ADC.
MIC -> AC97 -> Analog link -> Philips 24bit ADC -> P17 -> P17 register 
volume control -> Front speakers.

The P17 then has a register that sets the volume for the ADC direct to 
Front speakers route. Most people will want the MIC to be recorded, and 
not be sent directly to the speakers, so I have set this route to muted.

I expect the Audigy 2 is much the same.
1) MIC -> AC97 -> Analog link -> Philips ADC -> P16V -> P16V register(a) 
volume control -> Front speakers.
2) CPU -> DMA access for EMU10k2 -> I2S digital link -> P16V -> P16V 
register(b) volume control -> Front speakers.
3) CPU -> DMA access for P16V -> P16V register(c) volume control -> 
Front speakers.

There are actually some special lines of code in the emu10k1_main.c:
/* Hacks for Alice3 to work independent of haP16V driver */
...

Those are setting up the "I2S digital link" for the Audigy2.

P16V register(a),(b) and (c) are probably different registers.

The default volume levels are all set at 0dB, so as the "hacks for 
Alice3" don't include register(a), one will by default get feedback from 
the MIC direct to the front speakers.

I have almost got enough information on the P16V now, in order to make 
use of it.
I have:
1) DMA control registers (They are the same for the P16V and P17).
2) Switching between 48khz and 96khz.
I still need:
1) Which bits to set to get the interrupts working.
2) Setting 24bit output mode.

Work so far on the P17
I still need:
1) Switching between 48khz and 96khz.
2) Setting 24bit output mode.
I already have:
1) DMA control registers.
2) Interrupts working.
3) Volume controls
4) Digital/Analog outputs.

Cheers
James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
