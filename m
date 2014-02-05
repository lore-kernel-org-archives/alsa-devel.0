From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Wed, 5 Feb 2014 15:47:01 +0000
Message-ID: <CF17B845.8B89%brian.austin@cirrus.com>
References: <52F25761.8090706@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 37C20264FE8
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 16:47:09 +0100 (CET)
In-Reply-To: <52F25761.8090706@metafoo.de>
Content-Language: en-US
Content-ID: <21F7E6CC3DD96744A54EDFD8550AEC11@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 2/5/14, 9:23 AM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

>On 02/05/2014 03:35 PM, Austin, Brian wrote:
>>
>> On Feb 4, 2014, at 3:01 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>> On 02/04/2014 09:30 PM, Austin, Brian wrote:
>>>>> On Feb 4, 2014, at 13:55, "Lars-Peter Clausen" <lars@metafoo.de>
>>>>>wrote:
>>>>>
>>>>> SNDRV_PCM_RATE_KNOT means that the device can support rates that can
>>>>>not be
>>>>> expressed using the rate bits. The driver will provide a list of
>>>>>those rates
>>>>> specified through constraints. Any rate bits that are set in the
>>>>>rates mask will
>>>>> be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT
>>>>>wont have any
>>>>> effect, but might be confusing to the casual reader, so remove them.
>>>>>
>>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>>
>>>> I don't see how this makes it any less confusing to the casual
>>>>reader. I think the
>>>> define works well in the descriptive sense. maybe a comment about
>>>>what KNOT really
>>>> means instead of just using a non-rate define?
>>>
>>> The thing is SNDRV_PCM_RATE_8000_48000 does something if
>>>SNDRV_PCM_RATE_{KNOT,CONTINUOUS} is not set, but does nothing at all if
>>>either of them is set.
>>
>>
>>> While when reading the code it will, in my opinion, give the
>>>impression that the rates that are
>>> specified by SNDRV_PCM_RATE_8000_48000 are definitely among the
>>>supported rates and somewhere else additional rates are specified as
>>>well. But this is not the case all the supported rates need to be
>>>specified somewhere else, e.g. by a rate list constraint. I find this
>>>confusing when casually reading the code. And this is the only driver
>>>that does it.
>> But that is the case is it not? The device supports the rates within
>>8000 and 48000. There are additional rates that need to be specified. If
>>anything I see the issue with having to specify ALL the rates supported
>>in the constraint list. The KNOT is an addition to the .rates member.
>>The KNOT list is added to the .rates member in the dai driver.
>>
>
>Yep, but that's not how it works and why I think it is confusing to keep
>things the SNDRV_PCM_RATE_8000_48000 in there, as it might cause people
>to =

>think that this is how it works.
>
>When a substream is opened the constraints are set to be as permissive as
>possible. E.g. for rates this means any rate is considered valid. Going
>from =

>there the constraints code allows you to further restrict things. This is
>done by attaching rules to the constraint. The result is the intersection
>of =

>all the rules attached to the constraint. E.g. if you have one rule that
>says the rate must be between 16000 and 64000 and another rule that says
>the =

>rate must be one of 8000, 16000, 32000 or 48000, the list of valid rates
>is =

>16000, 32000, 48000. Similar if you have one rule that says the rate must
>be =

>one of 8000, 16000 or 32000 and  another rule that says that the rate
>must =

>be one of 16000, 22500 or 24000, the list of valid rates is 16000. It is
>only possible to further restrict the set of supported rates by one rule,
>it =

>is not possible to make it more permissive.
>
>When you set the rates field (and omit the KNOT or CONTINUOUS flags) the
>ALSA core will install one rule that will limit the supported rates to
>those =

>set in the rates field. When you use snd_pcm_hw_constraint_list() this
>will =

>add a second rule that will only allow rates in the array you specified
>for =

>that constraint. So the result will be that only those rates that are
>allowed by both rules.
>
>That's why you need to specify all supported rates in the constraint.
>Note =

>that ALSA core will do nothing with the rates field if the KNOT or
>CONTINUOUS flag is set. Otherwise you wouldn't be able to specify rates
>outside of what can be specified using the standard rates.
>
>>>
>>> Also there was a bug, which is now fixed, where additionally
>>>specifying rates in the rate bitmap when KNOT or CONTINUOUS was set did
>>>something, but did the wrong thing and caused additional rates which
>>>where outside of the range of the rates set in the bitmap to be
>>>ignored. Better avoid that by not mixing KNOT or CONTINUOUS with other
>>>rate bits.
>>>
>> Shouldn=B9t the rates outside of the range of the rates bitmap be
>>ignored?  Maybe this is a wrong interpretation of how this is supposed
>>to work, but I thought you specify the rates that are available and add
>>a constraint list to add rates that are not defined in ALSA. Not that
>>the KNOT value would mean that you also have rates outside of the values
>>you specified.
>>
>
>If you ignore rates outside the range of what is specified in the rates
>field you wouldn't be able to use rates that are lower or higher than
>what =

>is possible to specify with the default rates.
>
>> example: SNDRV_PCM_RATE_8000_48000 | | SNDRV_PCM_RATE_KNOT means that I
>>support all rates defined between 8 and 48 PLUS addition rates INSIDE of
>>8 and 48.  Is this correct?
>>
>
>It means you support some rates that need to be further specified
>somewhere =

>else. If SNDRV_PCM_RATE_KNOT (or SNDRV_PCM_RATE_CONTINUOUS) is set in the
>rates field all other bits that might be set are fully ignored (And
>that's =

>not a bug, it's a feature).
>
>> Sorry Lars, I just want to have a clear understanding of what the bug
>>is and how this fixes it.
>>
>> Thanks,
>> Brian
>>
>
>There is no bug (anymore). I already fixed things up in the ALSA and ASoC
>core so that if KNOT or CONTINUOUS is set all the other bits are masked
>out =

>from the rates field. Before that was done there was a bug that for some
>drivers rates were ignored that should have been valid. This patch is a
>cleanup that removes a code fragment that on the first look suggests that
>it =

>does something while it actually does nothing. And I think you proved my
>point that this can be confusing and misleading :)
>
>- Lars
>
Thanks for the explanation. I had a reverse understanding of what this
actually does for the dai driver .rates coupled with the constraint list.

Thanks,
Brian
