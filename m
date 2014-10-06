From: Andreas Mohr <andi@lisas.de>
Subject: Workable vintage driver support mechanism? (Re: [alsa-devel] [PATCH
 v3] ES938 support for ES18xx driver)
Date: Mon, 6 Oct 2014 20:41:50 +0200
Message-ID: <20141006184150.GA2465@rhlx01.hs-esslingen.de>
References: <1412027079-15876-1-git-send-email-linux@rainbow-software.org>
 <s5h7g0dzgd5.wl-tiwai@suse.de>
 <201410061555.19007.linux@rainbow-software.org>
 <s5ha959xp53.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5ha959xp53.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ondrej Zary <linux@rainbow-software.org>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 06, 2014 at 04:13:12PM +0200, Takashi Iwai wrote:
> At Mon, 6 Oct 2014 15:55:18 +0200,
> Ondrej Zary wrote:
> > ES938 does not depend on ES18xx and can be connected to any device with MIDI 
> > interface. Maybe there are some other cards with this chip.
> 
> Please prove it :)

:(

> That said, I'm not willing to merge the patch in the current form.
> One of the reason is that this can be implemented pretty easily in
> user-space.  Another is that it's a deadly old device, and likely only
> handful boards are still running in the world, thus no much motivation
> to bloat the kernel code for that.  We're even discussing to get rid
> of ISA codes from the kernel tree nowadays.
> 
> Sorry, the patch was submitted 10 years too late.

:((

Given that I hate the forces that are increasingly coming into play here
(but of course I do see the bigger picture, namely of kernel tree bloat),
I think I have an idea which might be useful to accept:
for every piece of sufficiently "vintage" submission,
people would be tasked with offering (or somehow ensuring)
a sufficiently closely time-related cleanup in other places.

Thus, given a "diffstat penalty" (lines added minus lines removed)
of the vintage support patch:

Additionally offer a cleanup patch
which gets rid of redundantly implemented kernel tree functionality:
- for 15 year old devices: 0.5 * diffstat_penalty
- for 20 year old devices: 1.0 * diffstat_penalty
- for 25 year old devices: 1.5 * diffstat_penalty
- for 30 year old devices: whaaa?

Hmm?

Andreas Mohr
