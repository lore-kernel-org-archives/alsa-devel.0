From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: First test of the hda-jack branch
Date: Tue, 15 Nov 2011 10:22:05 +0100
Message-ID: <4EC22F3D.6030001@canonical.com>
References: <4EBD4C04.3090406@canonical.com> <s5hwrb67gax.wl%tiwai@suse.de>
	<4EBD80CF.2070203@canonical.com> <s5h8vnj6odk.wl%tiwai@suse.de>
	<4EC140A4.2060408@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 73515245BE
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 10:22:03 +0100 (CET)
In-Reply-To: <4EC140A4.2060408@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/14/2011 05:24 PM, Jaroslav Kysela wrote:
> Date 14.11.2011 10:32, Takashi Iwai wrote:
>> At Fri, 11 Nov 2011 21:08:47 +0100,
>> David Henningsson wrote:
>>>
>>> In addition, I have a question about the second machine, which looks
>>> like this:
>>>
>>> numid=45,iface=CARD,name='Front Headphone Jack'
>>> numid=47,iface=CARD,name='Front Mic Jack'
>>> numid=48,iface=CARD,name='Line Jack'
>>> numid=41,iface=CARD,name='Line-Out Jack'
>>> numid=42,iface=CARD,name='Line-Out Jack',index=1
>>> numid=43,iface=CARD,name='Line-Out Jack',index=2
>>> numid=44,iface=CARD,name='Line-Out Jack',index=3
>>> numid=46,iface=CARD,name='Rear Mic Jack'
>>>
>>> Would it be possible to name the Line-Out Jacks "Front Line-Out",
>>> "Surround Line-Out" etc, so one can tell which one is which? Or can you
>>> always tell that just from the order of them?
>>
>> I can assign more intuitive names for the output, certainly.
>> I'll consider the implementation.
>
> Perhaps, the jacks should be described (control name) using physical
> parameters (location, color, connector type). Many codecs support both
> directions and I saw some bug-reports that ALSA cannot reassign the
>direction of jacks -

We can essentially do that in snd-hda-intel with the reconfiguration 
feature. That will also recreate the jacks with the new name. This seems 
to be a reasonable way forward IMO.

> if we agree that next versions of ALSA driver might
> support this feature, naming using the logical purpose might be
> confusing (we might propagate the logical purpose information using TLV
> to user space as an extra info).
>
> So something like "Ext Right 1/8 Black Jack".
> The lenghtest possibility "Ext Rear Panel Digital Unknown Jack" has 36
> chars (including '\0') so it fits to 44 characters for the control name
> with reasonable amount of space for future extensions.
>
> Can we handle the jack direction (playback, capture), too? This control
> element might be R/O or R/W (depending if hw/driver supports the jack
> direction control).

 > And for last, we might create an enum control to set the VREF /
 > LR_SWAP / BALANCED behaviour from the user space.

The problem is making something useful out of all this from userspace. 
If we ever end up creating and using the complete graph information in 
userspace, perhaps this would make more sense.

For now, having a consistent view is better as it easier to match the 
"Rear Mic" mixer control with "Rear Mic Jack", than it is to match "Rear 
Mic" with "Ext Right 1/8 Black Jack".


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
