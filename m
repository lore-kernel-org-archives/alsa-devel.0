From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] HDA: Generic input jack handling
Date: Sun, 09 Oct 2011 10:38:57 +0200
Message-ID: <4E915DA1.5040405@canonical.com>
References: <4E8EE75A.3050809@canonical.com> <s5hfwj50zsq.wl%tiwai@suse.de>
	<4E8EF48F.4000707@canonical.com> <s5hbott0x8n.wl%tiwai@suse.de>
	<4E8F16AA.7000104@canonical.com> <s5hsjn4zut2.wl%tiwai@suse.de>
	<4E8F2315.5070309@canonical.com> <s5hpqi8t0tv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9B0492457F
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 10:38:59 +0200 (CEST)
In-Reply-To: <s5hpqi8t0tv.wl%tiwai@suse.de>
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

On 10/08/2011 09:11 AM, Takashi Iwai wrote:
> At Fri, 07 Oct 2011 18:04:37 +0200,
> David Henningsson wrote:
>>
>> On 10/07/2011 05:27 PM, Takashi Iwai wrote:
>>> That being said, I'm inclined to delay it for 3.3.  Now is so close to
>>> the merge window and we don't need to rush for a refactoring patch.
>>> It can be done more safely in the early development cycle.
>>> Sorry if it disappoints you.
>>
>> This is much more than a refactoring patch - Realtek has no input jacks
>> for everything but headphones (and mics only if autoswitch is enabled),
>> so this is a good new feature. And my planned next step was to add it to
>> patch_via, which currently does not have input jacks at all.
>
> OK.
>
>> To give you some background here. As you might know, I've written
>> patches for PulseAudio to use these input jacks, that's why they're
>> suddenly so much more important. Also, it is not certain whether the
>> next release of Ubuntu (12.04, released April next year) will use kernel
>> 3.2 or 3.3. Should it be 3.3, this is not a problem, but if it is 3.2,
>> it would be better if all this was working upstream. Should it not be
>> working, I'll need to apply it for Ubuntu only instead.
>
> Well, then really you shouldn't be rushing too much.
> As mentioned, the API function will be needed to be changed because
> it's wrong to call with jack_type.  So, if you merge it in 3.2, you'll
> get anyway API/ABI incompatibility for further changes.
>
> That is, if it were a self-contained patch only in patch_realtek.c, I
> wouldn't mind too much.  But it's an addition of API in HD-audio code
> code, so I do care about it.

I don't like copy-pasting the same code into several vendor's patch 
files when the function should really be generic. Therefore I don't want 
to make several self-contained patches.

So if you feel uncomfortable with having the generic function in 3.2, 
queue it up for 3.3 (after I've changed the jack_type stuff to your 
preference) and I'll try to backport it into Ubuntu's 3.2 kernel, should 
it become necessary.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
