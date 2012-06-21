From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Thu, 21 Jun 2012 15:04:44 +0200
Message-ID: <4FE31BEC.20708@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com>
	<loom.20120619T050139-760@post.gmane.org>
	<4FE02D8B.7050201@canonical.com> <s5htxy6f6tt.wl%tiwai@suse.de>
	<4FE275AF.4080004@canonical.com> <s5hhau4esiu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 356CB10B97A
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 13:43:34 +0200 (CEST)
In-Reply-To: <s5hhau4esiu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

On 06/21/2012 02:52 PM, Takashi Iwai wrote:
> At Thu, 21 Jun 2012 03:15:27 +0200,
> David Henningsson wrote:
>>
>> On 06/20/2012 03:31 PM, Takashi Iwai wrote:
>>> At Tue, 19 Jun 2012 09:43:07 +0200,
>>> David Henningsson wrote:
>>>>
>>>> On 06/19/2012 05:07 AM, Eliot Blennerhassett wrote:
>>>>> David Henningsson<david.henningsson<at>    canonical.com>    writes:
>>>>>> On 02/28/2012 02:22 PM, Takashi Iwai wrote:
>>>>>>> At Tue, 28 Feb 2012 14:07:59 +0100,
>>>>>>> David Henningsson wrote:
>>>>>>> Is there a way we can
>>>>>>>> know the corresponding processing coefficients to set for ALC268 and
>>>>>>>> ALC272X as well?
>>>>>>>
>>>>>>> AFAIK, no, it was specific to the codec model.
>>>>>>
>>>>>> Ok, then we can only hope for Kailang to supply this information if
>>>>>> possible. And if not possible we could attempt the workaround (when/if
>>>>>> we agree on it...) for these devices as well?
>>>>>
>>>>> Greetings,
>>>>>
>>>>> Any chance that there has been any progress on this?
>>>>> I have a machine with dmic and ALC272X (details below) that exhibits this
>>>>> problem, and can test any proposed patch.
>>>>
>>>> We have a patch in for the Thinkpad U300s, but that one had a Conexant
>>>> codec.
>>>> I haven't had time to start working on kernel patches for the Realtek
>>>> ones yet, but meanwhile, I'm tracking known machines here:
>>>>
>>>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1002978
>>>
>>> Looking at the codec, it's not so trivial to port the inverted switch
>>> to Realtek.  In the input path of Realtek codecs, there is no
>>> individual capture volume/switch but only a central ADC volume and a
>>> MUX (or a mixer).
>>
>> Yeah, that's part of why I haven't done it myself yet ;-)
>>
>>   >  I can think of a new boolean switch or an enum to choose whether to
>>   >  shut off the right channel of the input-mux and the loopback volume.
>>   >  But it's feasible only if it make sense to PA.
>>
>> It seems possible that for ALC269 [1], you could switch path entirely
>> (including ADC). I e, the internal mic would go 0x12 ->  0x23 ->  0x08 and
>> the external mic would go 0x18 ->  0x24 ->  0x07. That way you could then
>> label the volume control on 0x08 "Internal Mic Capture Volume" and
>> "Inverted Internal Mic Capture Volume".
>>
>> Do you think this is a good strategy, or would it lead to other problems
>> (i e, what happens when you plug your mic in while actively recording)?
>
> If the i-mic is the only user for ADC 0x08, this would work.
> But when ADC 0x09 has multiple sources like e-mic and line-in,
> ADC 0x09 would be named as "Capture" (because it's not only "Mic"),
> and this becomes exclusive with "Internal Mic Capture".  It's a bit
> confusing, IMO.

Yes, this logic can only be used when there are two inputs - mic and 
internal mic. That is, the same conditions we today have for determining 
when to have auto-switching on plug/unplug.

Then 0x08 would have "Internal Mic Capture Volume|Switch" and 0x09 would 
be "Mic Capture Volume|Switch". "Capture Volume|Switch" cannot be used 
(unless we try to implement some kind of vmaster on the input side, but 
I don't think that would be necessary).

The alsa-info's I've looked at so far all have had one internal mic and 
one external mic on the input side. At least the Realtek ones.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
