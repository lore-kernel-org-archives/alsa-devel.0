From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: First test of the hda-jack branch
Date: Mon, 21 Nov 2011 11:02:11 +0100
Message-ID: <4ECA21A3.9080700@canonical.com>
References: <4EBD4C04.3090406@canonical.com> <s5hwrb67gax.wl%tiwai@suse.de>
	<4EBD80CF.2070203@canonical.com> <s5h8vnj6odk.wl%tiwai@suse.de>
	<s5hk46yln3i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id B7E4F24640
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 11:02:12 +0100 (CET)
In-Reply-To: <s5hk46yln3i.wl%tiwai@suse.de>
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

On 11/17/2011 05:39 PM, Takashi Iwai wrote:
> At Mon, 14 Nov 2011 10:32:07 +0100,
> Takashi Iwai wrote:
>>
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
> I added more commits there for a bit better control names.
> The function got messy and I'd need to rewrite sometime later, but
> would like to complete the feature at first.
>
> Note that along with the development, I had to rebase this branch so
> that it can be merged easily to the latest tree.  Please be careful
> when you pull to the existing branch.

Thanks! I've only had a quick look so far (no real test yet), I have 
some thoughts though:

1) I like the idea of having location prefix and channel mapping suffix! 
With this implementation we also seem to avoid things like "Front 
Line-Out Rear" and "Rear Line-Out Front" which could have been 
confusing, so well done :-)

2) I saw that headphones were not handled differently, for dual 
headphones, could they be called e g "Headphone Front Jack" and 
"Headphone Surround Jack" even they both play the front channel?

3) For HDMI I added a while ago something to make it possible to 
associate the HDMI Jack name with the correct PCM device. We must do the 
same for the kctl implementation, or it will not be possible to 
distinguish them correctly. I suggest we do like with the ELD control 
here, and set the "device" of the kcontrol to 3,7,8 or 9. Do you agree? 
(We can also add this number somewhere in the name, which might be 
simpler but maybe less elegant.)

4) "Surround" is misspelled in check_output_sfx.

Thanks,

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
