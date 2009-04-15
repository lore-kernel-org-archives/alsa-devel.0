From: Jerry Geis <geisj@pagestation.com>
Subject: Re: Gigabyte ALC889A Function ID: 0x01
Date: Wed, 15 Apr 2009 10:45:43 -0400
Message-ID: <49E5F317.9050505@pagestation.com>
References: <49E5E881.5020507@pagestation.com> <s5h4owq0zot.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com (unknown [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 490AD1038F1
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 16:45:43 +0200 (CEST)
In-Reply-To: <s5h4owq0zot.wl%tiwai@suse.de>
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
> At Wed, 15 Apr 2009 10:00:33 -0400,
> Jerry Geis wrote:
>   
>> I am using the gigabyte MA78GM-US2H motherboard. it has the ALC889A audio.
>>
>> I am trying 1.0.19 and audio works out the analog back port but not over 
>> HDMI.
>>     
>
> Never mind about "Function ID" entry.  It's just a new line that was
> added recently.  function_id=1 means it's an audio codec.
>
> The way HDMI is supported are mainly either through the same audio
> codec (ALC889A) or through a dedicated HDMI codec.  In the former
> case, you'll likely see a word "HDMI" in the digital output pin of the
> codec proc file.  In the latter case, you must have a different codec
> chip connected to the HD-audio bus with a different codec address
> number.
>
>
> Takashi
>
>
>   
>> Codec: Realtek ALC889A
>> Address: 0
>> Function Id: 0x1                                     
>> <--------------------------------- this is different
>> Vendor Id: 0x10ec0885
>> Subsystem Id: 0x1458a002
>> Revision Id: 0x100101
>> No Modem Function Group found
>> Default PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Default Amp-In caps: N/A
>> Default Amp-Out caps: N/A
>> GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
>>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>>   Converter: stream=0, channel=0
>>   PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>> Node 0x03 [Audio Output] wcaps 0x11: Stereo
>>
>> I have been looking but havent found a solution yet. I tried grabbing 
>> the snapshot tar ball for today but I get errors on the compile.
>>
>> I had a similiar motherboard but it does not report Function ID: 01 : - 
>> HDMI audio on this board works correctly.
>> Codec: Realtek ALC889A
>> Address: 0
>> Vendor Id: 0x10ec0885
>> Subsystem Id: 0x1458a002
>> Revision Id: 0x100101
>> No Modem Function Group found
>> Default PCM:
>>     rates [0x560]: 44100 48000 96000 192000
>>
>> Any thoughts????
>>
>> Jerry
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>     
>
>   

I upload alsa-info.sh

for the NOT WORKIng one 
http://www.alsa-project.org/db/?f=7e8bc9485e8bb98bf15dae5a0d5dc038003c3203

for the working on 
http://www.alsa-project.org/db/?f=a18bcb6e87fe33a7365a749d0877a4546e901bf2

I  noticed the subsystem a002 and a022 is different. Can this be why its 
not working?

Any thoughts?

Jerry
