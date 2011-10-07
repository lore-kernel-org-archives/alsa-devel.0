From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] HDA: Generic input jack handling
Date: Fri, 07 Oct 2011 14:46:07 +0200
Message-ID: <4E8EF48F.4000707@canonical.com>
References: <4E8EE75A.3050809@canonical.com> <s5hfwj50zsq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 744CF103B43
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 14:46:08 +0200 (CEST)
In-Reply-To: <s5hfwj50zsq.wl%tiwai@suse.de>
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

On 10/07/2011 02:08 PM, Takashi Iwai wrote:
> At Fri, 07 Oct 2011 13:49:46 +0200,
> David Henningsson wrote:
>>
>> So, this is what I had in mind for 3.2. Assuming positive feedback from
>> Takashi I'll go ahead and make a real patch out of this, and to clean up
>> the Realtek implementation, as well as probably add this method for more
>> codecs.
>>
>> Thoughts:
>>
>> 1) The unsol event tags vary wildly between different vendors. How about
>> standardising that as well?
>
> Generalization is good.  But tags aren't always constant.  It'd be
> better to assign each tag dynamically like in patch_sigmatel.c.
> The reason is that you'd need to know the pin NID from the unsol
> event, so the tag has to be unique even for the same purpose.  E.g. if
> a machine has two headphones, both are the same type but they should
> issue unsol events with different tags.

One would think that this is an area where it shouldn't differ between 
vendors (after all, they need to do the same things, so this is just 
different implementations), but we can clean that up later, and when 
that is done we could consider standardising on having the nid as the 
unsol tag value.
Anyway, as the patch below stands, sigmatel would call the function with 
unsol_tags->unsol_tag = 0, and then enable the jack itself.

Did you think the patch looked good otherwise?

>> 2) If alc_init_jacks would call the new method, that might regress
>> model-based (non auto) parsers. Is that a big deal these days?
>
> I don't think so.  And most of all model-based entries will vanish in
> 3.3.  In 3.2, already a half of realtek quirks are gone.

Ok.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
