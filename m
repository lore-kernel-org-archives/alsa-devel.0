From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: First test of the hda-jack branch
Date: Mon, 14 Nov 2011 17:24:04 +0100
Message-ID: <4EC140A4.2060408@perex.cz>
References: <4EBD4C04.3090406@canonical.com> <s5hwrb67gax.wl%tiwai@suse.de>
	<4EBD80CF.2070203@canonical.com> <s5h8vnj6odk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id C72022470D
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 17:24:06 +0100 (CET)
In-Reply-To: <s5h8vnj6odk.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Date 14.11.2011 10:32, Takashi Iwai wrote:
> At Fri, 11 Nov 2011 21:08:47 +0100,
> David Henningsson wrote:
>>
>> In addition, I have a question about the second machine, which looks 
>> like this:
>>
>> numid=45,iface=CARD,name='Front Headphone Jack'
>> numid=47,iface=CARD,name='Front Mic Jack'
>> numid=48,iface=CARD,name='Line Jack'
>> numid=41,iface=CARD,name='Line-Out Jack'
>> numid=42,iface=CARD,name='Line-Out Jack',index=1
>> numid=43,iface=CARD,name='Line-Out Jack',index=2
>> numid=44,iface=CARD,name='Line-Out Jack',index=3
>> numid=46,iface=CARD,name='Rear Mic Jack'
>>
>> Would it be possible to name the Line-Out Jacks "Front Line-Out", 
>> "Surround Line-Out" etc, so one can tell which one is which? Or can you 
>> always tell that just from the order of them?
> 
> I can assign more intuitive names for the output, certainly.
> I'll consider the implementation.

Perhaps, the jacks should be described (control name) using physical
parameters (location, color, connector type). Many codecs support both
directions and I saw some bug-reports that ALSA cannot reassign the
direction of jacks - if we agree that next versions of ALSA driver might
support this feature, naming using the logical purpose might be
confusing (we might propagate the logical purpose information using TLV
to user space as an extra info).

So something like "Ext Right 1/8 Black Jack".
The lenghtest possibility "Ext Rear Panel Digital Unknown Jack" has 36
chars (including '\0') so it fits to 44 characters for the control name
with reasonable amount of space for future extensions.

Can we handle the jack direction (playback, capture), too? This control
element might be R/O or R/W (depending if hw/driver supports the jack
direction control).

And for last, we might create an enum control to set the VREF / LR_SWAP
/ BALANCED behaviour from the user space.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
