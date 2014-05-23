From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: hda - Add a new quirk match
 based on default pin configuration
Date: Fri, 23 May 2014 07:17:40 +0200
Message-ID: <537ED9F4.5060801@canonical.com>
References: <1399970206-10269-1-git-send-email-david.henningsson@canonical.com>	<s5hr43yjbdl.wl%tiwai@suse.de>	<5371E836.3010205@canonical.com>	<s5hoaz2j9f0.wl%tiwai@suse.de>	<5375AC17.8000704@canonical.com>
 <s5hd2fep6hp.wl%tiwai@suse.de> <5375EA87.10104@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E79B926564D
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 07:17:42 +0200 (CEST)
In-Reply-To: <5375EA87.10104@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-05-16 12:37, David Henningsson wrote:
>
>
> On 2014-05-16 08:44, Takashi Iwai wrote:
>> At Fri, 16 May 2014 08:11:35 +0200,
>> David Henningsson wrote:
>>>
>>>
>>>
>>> On 2014-05-13 11:49, Takashi Iwai wrote:
>>>> At Tue, 13 May 2014 11:39:02 +0200,
>>>> David Henningsson wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2014-05-13 11:06, Takashi Iwai wrote:
>>>>>> At Tue, 13 May 2014 10:36:46 +0200,
>>>>>> David Henningsson wrote:
>>>>>>>
>>>>>>> Normally, we match on pci ssid only. This works but needs new code
>>>>>>> for every machine. To catch more machines in the same quirk,
>>>>>>> let's add
>>>>>>> a new type of quirk, where we match on
>>>>>>>     1) PCI Subvendor ID (i e, not device, just vendor)
>>>>>>>     2) Codec ID
>>>>>>>     3) Pin configuration default
>>>>>>>
>>>>>>> If all these three match, we could be reasonably certain that the
>>>>>>> quirk should apply to the machine even though it might not be the
>>>>>>> exact same device.
>>>>>>>
>>>>>>> In case a quirk matches both the pci ssid quirk and this type of
>>>>>>> quirk,
>>>>>>> then the pci ssid quirk is chosen.
>>>>>>>
>>>>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Hi Takashi,
>>>>>>>
>>>>>>> Do you think this could be working? If so I'll ask Hui to move
>>>>>>> some machines over
>>>>>>> and come up with a patch for that. Two questions:
>>>>>>>
>>>>>>>     1) I'm unsure if the "name" entry makes sense here - I mean,
>>>>>>> since the same quirk
>>>>>>>        hopefully matches many machines, we can't use the machine
>>>>>>> name here. Should I
>>>>>>>        just skip it?
>>>>>>>
>>>>>>>     2) Should I make a macro (like SND_PCI_QUIRK) to make the
>>>>>>> actual pinquirk tables look
>>>>>>>        more compact?
>>>>>>
>>>>>> I actually thought of checking the condition inside the fixup
>>>>>> callback.  That is,
>>>>>>
>>>>>> static void dell_fixup_headset(struct hda_codec *codec,
>>>>>>         const struct hda_fixup *fix, int action)
>>>>>> {
>>>>>>     if (action != HDA_FIXUP_ACT_PRE_PROBE)
>>>>>>         return;
>>>>>>     if (codec->vendor_id == xxxx &&
>>>>>>         pin_config_match(codec, xxxx_pincfg)
>>>>>>         codec->fixup_id = FIXUP_XXXX;
>>>>>>     else if (...)
>>>>>>         codec->fixup_id = FIXUP_YYYY;
>>>>>>     else
>>>>>>         codec->fixup_id = -1;
>>>>>>     if (codec->fixup_id != -1)
>>>>>>         snd_hda_apply_fixup(codec, action);
>>>>>> }
>>>>>>
>>>>>> Of course, this assumes that this fixup is called at the very first,
>>>>>> not as a chain.  If it may be called as a chain, we need a different
>>>>>> way to apply it.
>>>>>
>>>>> Hmm, still, what do you think about using my solution instead? It's
>>>>> more
>>>>> generic and could become useful in many different contexts in the
>>>>> future, not just matching headsets. And it integrates nicely with the
>>>>> existing quirk system as it is just a new method for matching quirks.
>>>>
>>>> Maybe better not to change snd_hda_pick_fixup(), but add the pincfg
>>>> lookup manually.  The difference is that you know the order of fixup
>>>> lookup in that way while doing it in snd_hda_pick_fixup() hides the
>>>> order; e.g. it can be called even if you want to pick up it before the
>>>> PCI SSID matching.
>>>
>>> I just attempted to rewrite the patch according to this, but I didn't
>>> like the result. I didn't find an elegant way to handle "nofixup" (you
>>> need to check "nofixup" in both pick_fixup functions in order to handle
>>> both orders), and I personally prefer to have one consistent ordering
>>> across all callers instead of letting the caller decide the order.
>>
>> Well, "nofixup" matching is one good point.  But it doesn't mean that
>> it's better to put a style in your patch, but rather it means that
>> it's a generic problem even for the existing scheme.
>>
>> For example, there is already a similar workaround in patch_sigmatel.c
>> for the old iMacs.  Since Apple doesn't give any useful PCI SSID, we
>> need to check codec SSIDs.  But even some machines give bogus codec
>> SSIDs (0000:0100) due to BIOS, so we have to filter out at first with
>> PCI SSID, then apply codec SSID check.
>>
>> What can we do for fixing both cases (iMac and Dell)?  We can't put
>> every logic in a flat way into pick_fixup().  Both tells us:
>> - we need multi-step filtering
>> - some of filters can be reused (e.g. filtering via PCI vendor, some
>>    device SSID mask)
>> - some filter can be arbitrary (e.g. pincfg matching)
>>
>> This implies that the need isn't to extend the current flat fixup
>> parser but redesign somehow to be layered.  Otherwise, we'll see the
>> same trouble once if we need to add another matching method (OF, ACPI,
>> DMI, whatever).
>>
>> So, until this is properly implemented, I'd like not to touch the
>> the helper side, but keep changes inside the codec driver locally.
>
> Ok, so let's do it "layered" then, so it will be more flexible for the
> caller what type of filtering is needed. Will post patches now.
>
> I left the iMac codec SSID stuff up to you to refactor, because I'm not
> sure exactly how you want it done.

Hi Takashi,

Since you want this cleaned up before 3.16 and the merge window will 
soon open, can you please comment on the patches I posted a week ago, 
which makes it possible to use a more layered approach?

These are the two patches I'm talking about:

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076691.html

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076692.html

Thanks,

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
