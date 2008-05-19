From: Travis Place <wishie@wishie.net>
Subject: Re: Incorrect model selection for HDA Intel based card.
Date: Tue, 20 May 2008 01:43:31 +1000
Message-ID: <200805200143.31066.wishie@wishie.net>
References: <200805190419.14316.wishie@wishie.net>
	<s5h8wy6cx7n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-101.dial.usertools.net
	[202.137.100.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 208A82464D
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 17:43:51 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 55B4F317EF
	for <alsa-devel@alsa-project.org>; Mon, 19 May 2008 16:05:01 +1000 (EST)
In-Reply-To: <s5h8wy6cx7n.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 May 2008 10:09:00 pm Takashi Iwai wrote:
> At Mon, 19 May 2008 04:19:14 +1000,
>
> Travis Place wrote:
> > Just had a user in #alsa on freenode, with an Asus P5GD1 mainboard.
> > They couldnt seem to get surround sound working at all.
> > It has an ALC880 based HDA-Intel sound device on board.
> >
> > Now, the problem lies in the Susbsystem ID's (1043:814e).
> > These match in patch_realtek.c as follows:
> >
> > SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS)
> >
> > The users mainboard (The ASUS P5GD1) actually has 6 output jacks, aswell
> > as SPDIF, not the standard 3-jacks that the "ASUS" model quirk implies.
> >
> > I talked this user through forcing the driver to use '6stack-digout' for
> > his sound device, and things all work fine now.
>
> Actually, this was changed originally from ALC880_5STACK for the
> exactly same mobo (changeset 4798).  I guess 6stack-digout wasn't
> tested by that user.
>
> So, if 6stack-digout is confirmed to match better than now, it's
> fairly safe to replace the line.  Care to send a patch with a proper
> changelog?
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

As previously mentioned, it appears the HG code has an entry for the "ASUS 
P5GD1" mainboard. But its onboard sound vendor/device Ids dont match those of 
the person i was helping. I have double checked the pastebin post, and 
confirmed the mainboard model with the user though.

The _original_ alsa-info.sh run (before the model was forced to 6stack-digout) 
is as follows..

http://pastebin.ca/1021995

There it shows the vendor/device ids as 0x1043, 0x814e .
So according to the current HG code, those IDs would select the "asus" model.
Also, in the same, current HG code, we have..

SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST)

This shows the correct model name for the mainboard, but (from my experience) 
wrong vendor/device ids.

Perhaps we have to check with the person who originally added that P5GD1 
quirk ?

I have made up a patch, but want to confirm all this information before 
proceeding. Please let me know your thoughts.

Travis Place

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
