From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Fri, 12 Jun 2015 08:07:20 +0200
Message-ID: <557A7718.5070100@canonical.com>
References: <5576B419.5010505@canonical.com>	<s5h1thlqeus.wl-tiwai@suse.de>	<5576E994.2080300@canonical.com>	<5577BAEE.50506@canonical.com>	<s5h1thjoo14.wl-tiwai@suse.de>
 <s5hoakmjn6i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D9BB32666F5
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 08:07:21 +0200 (CEST)
In-Reply-To: <s5hoakmjn6i.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, hwang4 <hui.wang@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-06-11 17:10, Takashi Iwai wrote:
> At Wed, 10 Jun 2015 12:28:39 +0200,
> Takashi Iwai wrote:
>> OK, good to know. I'd like to test a bit more via hda-emu whether 
>> this gives any ill effects. So far, this seems fixing a few other 
>> machines, too, so it's a good thing to have in general. 
> This change alone results in regressions on machines that are capable
> of 4.0/5.1 surrounds.  For avoiding it, the badness for multi-io has
> to be increased as well.  It's damn sensitive.
>
> But, now I wonder now whether blindly applying this is good.  Suppose
> a machine with 2.1 speaker and one headphone, but the codec has only
> two DACs.  With this setup, now the headphone and the speaker share
> the same DAC, as the cost of having individual 2.1 speaker volume.
> Is this more useful than having individual volumes for speaker and
> headphone?
>
> Maybe the machine you're trying to support has a different situation.
> So applying the new rule to limited devices is fine.  But if so, it's
> not necessarily to be an adjustment of badness table, but just you can
> provide the simple DAC/pin preference map explicitly in the fixup.

Oh, this is an interesting trade-off.

In the PulseAudio desktop scenario, we automute the speaker, and 
PulseAudio remembers the individual headphone and speaker volumes. So in 
this case, there is no benefit from having individual headphone and 
speaker volume at the ALSA level.

However if a user wants to turn off automute, then there is a need for 
being able to adjust headphone and speaker volume individually.

But it's not just a question of volume control for 2.1. Being able to 
send a different stream to the subwoofer could be useful too, especially 
if the hardware filter is bad or non-existing.

So my gut feeling leans towards using the second DAC for the subwoofer 
speaker being the more useful default, but it's not a clear cut.

// David
