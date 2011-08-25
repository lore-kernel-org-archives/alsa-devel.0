From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Thu, 25 Aug 2011 23:37:12 +0200
Message-ID: <4E56C088.6080402@canonical.com>
References: <4E53C32E.9020801@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
	<4E5483CD.6070808@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>
	<4E55F634.9070601@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3E7D@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 7F29B245EF
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 23:37:14 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3E7D@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2011-08-25 19:41, Stephen Warren wrote:
> David Henningsson wrote at Thursday, August 25, 2011 1:14 AM:
>> On 08/24/2011 11:21 PM, Stephen Warren wrote:
>>> David Henningsson wrote at Tuesday, August 23, 2011 10:54 PM:
>>>> On 2011-08-23 17:51, Stephen Warren wrote:
>>>>> David Henningsson wrote at Tuesday, August 23, 2011 9:12 AM:
>>>>>> Since modern HDMI cards often have more than one output pin and thus
>>>>>> input device, we need to know which one has actually been plugged in.
>>>>>>
>>>>>> This patch adds a name hint that indicates which PCM device is connected
>>>>>> to which pin.
> ...
>>>>> Structurally, I think this looks OK. The only question I have is the
>>>>> string format:
>>>>>
>>>>> "HDMI/DP (pcm %d)", pcmdev
> ...
>>>>> Thinking about ALSA device numbering, it's
>>>>> like "hw:1,3", so includes the card number too; should that be in the
>>>>> string?
>>>>
>>>> The matchup against the card can be done both in sysfs, and using the
>>>> card name, which is later prefixed to that string. The end result would
>>>> be something like "HDA NVidia HDMI/DP (pcm 3)"
>>>
>>> OK, so if the string that user-space sees already has the card name, that's
>>> probably enough in practice, although it still seems a little free-form.
>>>
>>> One issue with the above string: There's no delimiter that user-space can
>>> use to extract just the card name from the whole string. Perhaps add a
>>> ":" at the start so there's a delimiter?
>>
>> Or a ","
>
> Sure.
>
>>> "HDA NVidia: HDMI/DP (pcm 3)"
>>> "HDA NVidia: pcm 3"
>>>
>>> ?
>>>
>>>> It's possible though, and somewhat simpler than matching against sysfs
>>>> to add the card number as well.
>>>>
>>>>> * Would it be better to make the string completely generic - i.e. not
>>>>> include "HDMI/DP", but rather something like "ALSA PCM %d", or even
>>>>> "ALSA PCM hw:%d,%d" so that the same format could be used for non-HDMI/
>>>>> DP PCMs in the future?
>>>>
>>>> That would probably be bad, as there would be no way to distinguish
>>>> between e g "Headphone" and "Headphone 2".
>>>
>>> Are those two different analog outputs from the same PCM device?
>>
>> Yes.
>>
>>> If so, I don't see a problem with having both those jack's input devices
>>> reporting the same PCM name; user-space will just see 2 matches and know
>>> that the PCM device is useful if either is plugged in.
>>
>> The problem is not that they have the same name, the problem is with
>> removing "HDMI/DP",
>
> Ah, OK. That makes sense now.
>
> ...
>> The jack input devices solve two different problems for HDMI and analog:
>>
>> For HDMI, my problem is that I don't know which PCM device to send the
>> output to (because there are four). The jack input device, with the
>> patch, fixes that problem.
>>
>> For Analog output, my problem is that I don't know which volume controls
>> are affecting the current output path. If the Headphone is plugged in,
>> this might be "Master" and "Headphone" whereas if it is unplugged, it
>> might be "Master" and "Speaker" instead.
>>
>> In theory, analog outputs could show up at both devices 0,2,4 and 5, but
>> in practice, all of them always [1] show up at PCM device 0.
>
> OK. I think those are just two aspects of the same thing; we always need to
> know which PCM to use and which controls to use; it's just that in practice
> sometimes that information is also implied by other means.
>
> So, I don't think a fully general solution hurts.
>
>>>> Up to now, I believe the string in the name has been pretty arbitrarily.
>>>> E g, I have "Headphone" on one machine and "HP Out" on another. Should
>>>> we try to establish a format where various parameters can be added, it
>>>> might be good to try something like ",name=value". Should we add card as
>>>> well, the result would be e g: "HDA NVidia HDMI/DP,card=2,pcm=3"
>>>
>>> That sounds pretty sane to me.
>>
>> Ok, I'm attaching a patch where the only difference is that the format
>> has changed according to the ,name=value syntax.
>
> Just one question: If the core code prefixes the card name onto this string,
> the HDMI code will pass in "HDMI/DP,pcm=3" and the core code will join the
> prefix on the front using a space, yielding "HDA NVidia HDMI/DP,pcm=3". Can
> we make the joining use a comma so that spaces within fields don't confuse
> the comma, i.e. "HDA NVidia,HDMI/DP,pcm=3"? Otherwise, does the card name
> end at the first space, the second, the last? (None of these work in all
> the cases considering that the second field might be "Headphones 2" with a
> space in it.
>

So, I don't mind a "fully general solution" as long as we during a 
transitional period allow for a random string (without commas) before 
the first comma, followed by ",name=value" strings. Value can contain 
anything except commas, including spaces.
So let's work towards ",card=NVidia,type=HDMI/DP,pcm=3" (and maybe add e 
g location or other stuff from pin default config as needed) but for now 
it will be okay with "HDA NVidia HDMI/DP,pcm=3".

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
