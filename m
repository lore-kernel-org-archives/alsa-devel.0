From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: Workable vintage driver support mechanism? (Re:
	[PATCH v3] ES938 support for ES18xx driver)
Date: Sun, 12 Oct 2014 23:19:04 +0200
Message-ID: <201410122319.05127.linux@rainbow-software.org>
References: <1412027079-15876-1-git-send-email-linux@rainbow-software.org>
 <20141006184150.GA2465@rhlx01.hs-esslingen.de> <s5hr3ykla1p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F44E260462
 for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2014 23:19:37 +0200 (CEST)
In-Reply-To: <s5hr3ykla1p.wl-tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org



On Tuesday 07 October 2014 07:32:18 Takashi Iwai wrote:
> At Mon, 6 Oct 2014 20:41:50 +0200,
>
> Andreas Mohr wrote:
> > On Mon, Oct 06, 2014 at 04:13:12PM +0200, Takashi Iwai wrote:
> > > At Mon, 6 Oct 2014 15:55:18 +0200,
> > >
> > > Ondrej Zary wrote:
> > > > ES938 does not depend on ES18xx and can be connected to any device
> > > > with MIDI interface. Maybe there are some other cards with this chip.
> > >
> > > Please prove it :)
> > >
> > :(
> > :
> > > That said, I'm not willing to merge the patch in the current form.
> > > One of the reason is that this can be implemented pretty easily in
> > > user-space.  Another is that it's a deadly old device, and likely only
> > > handful boards are still running in the world, thus no much motivation
> > > to bloat the kernel code for that.  We're even discussing to get rid
> > > of ISA codes from the kernel tree nowadays.
> > >
> > > Sorry, the patch was submitted 10 years too late.
> > >
> > :((
> >
> > Given that I hate the forces that are increasingly coming into play here
> > (but of course I do see the bigger picture, namely of kernel tree bloat),
> > I think I have an idea which might be useful to accept:
> > for every piece of sufficiently "vintage" submission,
> > people would be tasked with offering (or somehow ensuring)
> > a sufficiently closely time-related cleanup in other places.
> >
> > Thus, given a "diffstat penalty" (lines added minus lines removed)
> > of the vintage support patch:
> >
> > Additionally offer a cleanup patch
> > which gets rid of redundantly implemented kernel tree functionality:
> > - for 15 year old devices: 0.5 * diffstat_penalty
> > - for 20 year old devices: 1.0 * diffstat_penalty
> > - for 25 year old devices: 1.5 * diffstat_penalty
> > - for 30 year old devices: whaaa?
>
> The kernel bloat is one side, and your proposal would help to keep
> figure.  But another side is the maintenance, as Clemens pointed.
> It's obviously more difficult for exotic hardware devices.  So, it's
> really case-by-case.
>
> Speaking of this particular patch, however, the reason for NAK isn't
> (only) the vintage.  There are other concerns as I raised, especially
> the ugliness of the interface it uses, and this doesn't have to be a
> kernel stuff at all.  You could implement it as a user-space alsa-lib
> plugin as well.

So do I understand correctly that there is no (right) way for a kernel driver 
to issue MIDI commands?

Is it possible for an alsa-lib plugin to automatically load when an ES18xx 
sound card is present to check for ES938 (without repeating the detection on 
each application launch)?

-- 
Ondrej Zary
