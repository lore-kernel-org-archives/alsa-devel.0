From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] HDA: Generic input jack handling
Date: Fri, 07 Oct 2011 18:04:37 +0200
Message-ID: <4E8F2315.5070309@canonical.com>
References: <4E8EE75A.3050809@canonical.com> <s5hfwj50zsq.wl%tiwai@suse.de>
	<4E8EF48F.4000707@canonical.com> <s5hbott0x8n.wl%tiwai@suse.de>
	<4E8F16AA.7000104@canonical.com> <s5hsjn4zut2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F26B10382B
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 18:04:38 +0200 (CEST)
In-Reply-To: <s5hsjn4zut2.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/07/2011 05:27 PM, Takashi Iwai wrote:
> At Fri, 07 Oct 2011 17:11:38 +0200,
> David Henningsson wrote:
>>
>> On 10/07/2011 03:03 PM, Takashi Iwai wrote:
>>> At Fri, 07 Oct 2011 14:46:07 +0200,
>>> David Henningsson wrote:
>>>>
>>>> On 10/07/2011 02:08 PM, Takashi Iwai wrote:
>>>>> At Fri, 07 Oct 2011 13:49:46 +0200,
>>>>> David Henningsson wrote:
>>>>>>
>>>>>> So, this is what I had in mind for 3.2. Assuming positive feedback from
>>>>>> Takashi I'll go ahead and make a real patch out of this, and to clean up
>>>>>> the Realtek implementation, as well as probably add this method for more
>>>>>> codecs.
>>>>>>
>>>>>> Thoughts:
>>>>>>
>>>>>> 1) The unsol event tags vary wildly between different vendors. How about
>>>>>> standardising that as well?
>>>>>
>>>>> Generalization is good.  But tags aren't always constant.  It'd be
>>>>> better to assign each tag dynamically like in patch_sigmatel.c.
>>>>> The reason is that you'd need to know the pin NID from the unsol
>>>>> event, so the tag has to be unique even for the same purpose.  E.g. if
>>>>> a machine has two headphones, both are the same type but they should
>>>>> issue unsol events with different tags.
>>>>
>>>> One would think that this is an area where it shouldn't differ between
>>>> vendors (after all, they need to do the same things, so this is just
>>>> different implementations), but we can clean that up later, and when
>>>> that is done we could consider standardising on having the nid as the
>>>> unsol tag value.
>>>> Anyway, as the patch below stands, sigmatel would call the function with
>>>> unsol_tags->unsol_tag = 0, and then enable the jack itself.
>>>>
>>>> Did you think the patch looked good otherwise?
>>>
>>> Reporting per jack type isn't necessarily correct, e.g. when multiple
>>> pins for the same type are present.  In that case, only the changed
>>> pin should be reported.  So, in patch_realtek.c, the tag should be
>>> also individual for each pin like in patch_sigmatel.c.
>>> Currently it's using constants because of the model quirks.  Once when
>>> these are removed, we can move to the dynamic allocation.
>>
>> Ok. I was afraid you would consider such a change too big to reach 3.2,
>> and current handling does not make things worse, really - it's just
>> slightly inoptimal to detect one more jack, but does not hurt much.
>> Would you like me to add an associate tag ->  nid array?
>
> Well, the point is that this is a try to move a function into the core
> code although you know it'll need a fix.  And this is no bug fix, but
> a code clean-up.  It's very nice, but still it's to be done not to
> break / worsen things.
>
> That being said, I'm inclined to delay it for 3.3.  Now is so close to
> the merge window and we don't need to rush for a refactoring patch.
> It can be done more safely in the early development cycle.
> Sorry if it disappoints you.

This is much more than a refactoring patch - Realtek has no input jacks 
for everything but headphones (and mics only if autoswitch is enabled), 
so this is a good new feature. And my planned next step was to add it to 
patch_via, which currently does not have input jacks at all.

To give you some background here. As you might know, I've written 
patches for PulseAudio to use these input jacks, that's why they're 
suddenly so much more important. Also, it is not certain whether the 
next release of Ubuntu (12.04, released April next year) will use kernel 
3.2 or 3.3. Should it be 3.3, this is not a problem, but if it is 3.2, 
it would be better if all this was working upstream. Should it not be 
working, I'll need to apply it for Ubuntu only instead.

> And, yes, it'd be nice if you can give a patch for tag->nid
> association, too ;)

Ok, I can do that.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
