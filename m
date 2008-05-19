From: Travis Place <wishie@wishie.net>
Subject: Re: Incorrect model selection for HDA Intel based card.
Date: Tue, 20 May 2008 00:58:47 +1000
Message-ID: <200805200058.47467.wishie@wishie.net>
References: <200805190419.14316.wishie@wishie.net>
	<s5h8wy6cx7n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-101.dial.usertools.net
	[202.137.100.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B3EA24645
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 16:59:13 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id A599F31CA2
	for <alsa-devel@alsa-project.org>; Mon, 19 May 2008 15:20:18 +1000 (EST)
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

Going to get the user to run a few more tests, to confirm all is working as it 
should (seems to be, on first glance) before submitting a patch/changelog.

Will let you know when ready.

Travis Place

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
