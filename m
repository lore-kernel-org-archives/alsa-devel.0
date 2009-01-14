From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: RFC: snd_card_create() function
Date: Wed, 14 Jan 2009 15:14:54 +0000
Message-ID: <496E016E.7010801@superbug.co.uk>
References: <s5h63kkd23c.wl%tiwai@suse.de>	<ad2655cb0901120642h542f2a5s9f3e9bb05e6e176c@mail.gmail.com>	<s5h4p04d1ij.wl%tiwai@suse.de>	<ad2655cb0901120706g1bfe019bk23316a288c08ee7b@mail.gmail.com>
	<s5htz84bl6p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lon1-post-1.mail.demon.net (lon1-post-1.mail.demon.net
	[195.173.77.148])
	by alsa0.perex.cz (Postfix) with ESMTP id BD0741037F1
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 16:14:59 +0100 (CET)
In-Reply-To: <s5htz84bl6p.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 12 Jan 2009 15:06:51 +0000,
> James Courtier-Dutton wrote:
>> 2009/1/12 Takashi Iwai <tiwai@suse.de>:
>>> At Mon, 12 Jan 2009 14:42:06 +0000,
>>> James Courtier-Dutton wrote:
>>>> Sounds good to me.
>>>> One can keep the wrapper outside of the kernel, and only available in
>>>> alsa-driver for those out of tree people.
>>> Yes, that's good.
>>> I think it'd be better to do that after one kernel-cycle later for a
>>> softer landing, though.
>>>
>> How soft do we need this?
> 
> One kernel cycle is enough.
> 
>> The change is probably max of 3 lines of code per sound card that has
>> an out of tree driver.
>> The only one I am aware of is the xfi one. With the wrapper being more
>> than 3 lines of code being put into the kernel only to be removed
>> again seems a little un-necessary to me.
>> For internal kernel changes, I don't think we should care about out of
>> kernel drivers. None of the rest of the kernel developers go out of
>> their way for anything out-of-mainline.
> 
> Well, my main concern isn't about out-of-kernel drivers like xfi, but
> the drivers that will come from other trees.  The codes outside ALSA
> tree, for example, V4L, can't be always controlled by us (suppose a
> new V4L driver comes in for the next kernel).  And these are more or
> less "mainline" development.
> 
> If you see the linux-next development, you'll find how the internal
> API can be a pain among several tree merges.  A typical API change
> (that has been often seen in driver-core area) introduces first a
> wrapper while converting all in the present kernel, then kill it at
> the next cycle.
> 

Ah! I did not think of V4L. Once cycle seems OK to me. I hope it creates
a warning message to the V4L developers, although, I don't see why you
cannot include a patch to V4L together with all the other alsa cards
drivers that would get into linux-next.
