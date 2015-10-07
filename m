From: Rick Mann <rmann@latencyzero.com>
Subject: Re: Audio routing in the tlv320aic3104
Date: Wed, 7 Oct 2015 11:15:15 -0700
Message-ID: <21D9BA04-4919-4D3A-99E9-D5E7EC00DB05@latencyzero.com>
References: <18B9FBAF-1EB4-413F-8639-9AC94B50F445@latencyzero.com>
 <0665D4EF-04B7-4930-9921-2BA72CAB7AC9@crome.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 6D4D92612C6
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 20:15:17 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 8FC8C20755
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 14:15:16 -0400 (EDT)
In-Reply-To: <0665D4EF-04B7-4930-9921-2BA72CAB7AC9@crome.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> On Oct 7, 2015, at 05:52, Caleb Crome <caleb@crome.org> wrote:
> 
> 
> 
> Sent from my iPhone
> 
>> On Oct 7, 2015, at 4:12 AM, Rick Mann <rmann@latencyzero.com> wrote:
>> 
>> I've managed to get a hacky, fragile config working, in the sense that it sends my tlv320aic3104 samples from speaker-test, and the clocks and data all look good on the oscilloscope, and it ping-pongs between the left and right channel.
>> 
>> But it's outputting the signal on the HPLOUT/HPROUT pins, not the L&R Line Out pins.
>> 
>> My DTS has this:
>> 
>>   fragment@3 {
>>       target = <&ocp>;
>>       __overlay__ {
>>           sound {
>>               compatible = "ti,da830-evm-audio";
>>               ti,model = "DA830 EVM";
>>               ti,audio-codec = <&tlv320aic3x>;
>>               ti,mcasp-controller = <&mcasp0>;
>>               ti,codec-clock-rate = <12000000>;
>>               ti,audio-routing =
>>                   "Line Out",             "LLOUT",
>>                   "Line Out",             "RLOUT";
>>           };
>>       };
>>   };
>> 
>> The original had:
>> 
>>   "Headphone Jack",       "HPLOUT",
>>   "Headphone Jack",       "HPROUT",
>>   "LINE1L",               "Line In",
>>   "LINE1R",               "Line In";
>> 
>> I also have an asound.state file I got from the Audio Cape:
>> 
>>   https://raw.githubusercontent.com/CircuitCo/BeagleBone-Audio/files/asound.state
>> 
>> I don't really know how to interpret that file. One resource online said it held the current state of the system. I guess that suggests I should play with amixer. But how does the DTS routing come into play?
>> 
>> Thanks,
> 
> Check for the routing in the davinci-evm.c file.  It has other routes,  I kind of recall it says some outputs are not connected.    You might have to edit routs there too. 

Actually I was able to use amixer to switch the DAC muxes to the right setting, and the signal routed to the right place. I think it's the first time in three weeks that the first thing I tried actually worked as expected.

But I had hoped ALSA would enable only that route given the DTS; perhaps it's the asound.state file I downloaded that forced its hand the wrong way; I'll try that experiment later.

At least now I can populate the remaining parts on the board to see if they work, too.

I still am far from complete with the Linux config (need to get it working in 4.x, need to get my enable GPIOs working automatically, etc.), but I can finally make real progress.

Thanks!
