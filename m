From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Audigy LS SPDIF output.
Date: Tue, 22 Jun 2004 05:01:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D7AF33.5030405@superbug.demon.co.uk>
References: <40D72EBF.80108@superbug.demon.co.uk> <40D7463C.5090406@ait.nrl.navy.mil> <40D75C54.7010700@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40D75C54.7010700@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Eric Klein <eklein@ait.nrl.navy.mil>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Eric Klein wrote:
> 
>> James Courtier-Dutton wrote:
>>
>>> Hi,
>>>
>>> I cannot test SPDIF output because I cannot find a suitable 4 pole 
>>> mini jack that has 3 phone plugs on the end of it, so that I can test 
>>> spdif out.
>>>
>>> I have tried a few different cables, but none of them even work with 
>>> the 4front drivers. Once I have a cable that works with the 4Front 
>>> drivers, I will then look into getting the ALSA driver working.
>>>
>>> Can anybody help me here?
>>
>>
>>
>> There are two solutions I can offer (assuming when you mention phone 
>> plugs, that you mean 3-pole 3.5mm plugs):
>> 1) Creative UK offers a set of cables that will take the 3 output 
>> lines (two of which are 4-pole lines) and convert them into 4 3-pole 
>> lines (aka stereo lines). These cables are meant for hooking the 
>> Audigy 2 up to a set of creative labs 7.1 speakers. The website to 
>> order the cable is: 
>> http://uk.europe.creative.com/estore/product.asp?prod=598   . I'm not 
>> sure why they don't offer this cable in the US, but I assume you can 
>> order if from the UK.
>> 2) You can make a custom cable (this is what I spent my day doing 
>> today). You can buy a camcorder cable which has a 4-pole 3.5mm plug on 
>> one end, and 3 mono RCA type plugs. If you then buy some mono-phone 
>> plugs (either 3.5mm (aka 1/8") or 1/4" will do), you can cut off the 
>> RCA plugs and do a little wire splicing/soldering to attach the plugs 
>> you want. This solution works very nicely (although it takes a little 
>> time).
>>
>> Good luck,
>>
>> Eric Klein
>> eklein@ait.nrl.navy.mil
>>
>>
> 
> I have a camcorder cable, that has one 4-pole mini-jack connected to 3 
> mono RCA plugs, but the connections are all wrong. i.e. the ground or 
> sheild on the RCA plugs is not connected to the Ground pole of the mini 
> jack as far as the Audigy LS sound card is concerned. It is only correct 
> for use with a camcorder.
> 
> This is all quite annoying, because a simple mono jack to RCA plug does 
> perfectly for SPDIF out to Coax input on the Audigy 2. But this does not 
> work with the Audigy LS.
> 
> So, I will probably have to go with option (1).
> 
> James
> 

I went and put the Audigy LS in a Windows 2000 machine, and found that 
putting a simple mono mini-jack (2 pole) -> RCA did SPDIF out from the 
Audigy LS to my external decoder, just the same as from an Audigy2. I 
only tested PCM Stereo out from the SPDIF in windows, because I don't 
have any windows program that will output AC3 to SPDIF.

After some trial and error, I now have enough info to implement SPDIF 
out from the Audigy LS in ALSA.

Reg: 0x42 holds the AES bits.
Reg: 0x45 = 0 for SPDIF out,  0xf00 for Analogue out.

PCM output works, but AC3 does not yet. There must be some resamplers or 
extra mixing in the way.

I will submit a patch soon for PCM stereo over SPDIF.
I will have to do more tests to get AC3 working.

Cheers
James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
