From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Tue, 17 Apr 2018 04:38:29 +0200
Message-ID: <20180417023829.GA1533@wunner.de>
References: <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
 <20180414104950.ngomyjy5l5cwhb5i@pali>
 <20180414111711.GA4245@wunner.de>
 <20180415171746.futkvgbaoj6quy5z@pali>
 <20180415190523.GA16129@wunner.de>
 <20180416142512.bwsemgwrncyl5xan@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.90.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 32FF22673FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 04:38:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180416142512.bwsemgwrncyl5xan@pali>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 16, 2018 at 04:25:12PM +0200, Pali Roh=E1r wrote:
> On Sunday 15 April 2018 21:05:23 Lukas Wunner wrote:
> > On Sun, Apr 15, 2018 at 07:17:46PM +0200, Pali Roh=E1r wrote:
> > > On Saturday 14 April 2018 13:17:11 Lukas Wunner wrote:
> > > > On Sat, Apr 14, 2018 at 12:49:50PM +0200, Pali Roh=E1r wrote:
> > > > > On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> > > > > > On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > > > > > Do you have any suggestion to check if it connects to the sys=
tem via
> > > > > > > Thunderbolt?
> > > > > > =

> > > > > > Just use pci_is_thunderbolt_attached(), introduced by 8531e283b=
ee6,
> > > > > > like this:
> > > > > > =

> > > > > > if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attac=
hed(pci))
> > > > > =

> > > > > And what about PCI-e device attached to ExpressCard slot?
> > > > =

> > > > I don't know of a bullet-proof way to recognize those.
> > > =

> > > Hm... maybe another idea: Is it possible to detect which audio pci
> > > device belongs to graphics card via vga_switcheroo? Currently, looking
> > > at output it is same PCI device as graphic card, just different PCI
> > > function.
> > =

> > No, the DRM drivers don't filter ExpressCard-attached GPUs when
> > registering with vga_switcheroo.
> =

> > They do filter Thunderbolt-attached GPUs.
> =

> So check via vga_switcheroo should at least work for Thunderbolt GPUs.
> =

> I do not know if it is possible, but for me it looks like that check via
> vga_switcheroo should be better then adding another heuristic to other
> drivers.

It is way simpler and more straightforward if hda_intel.c calls
pci_is_thunderbolt_attached() directly, as I've suggested above.

The DRM drivers call that as well and register with vga_switcheroo
only if it returns false.  So if hda_intel.c asked vga_switcheroo
and got back a negative answer, it would never know whether it's
because the DRM driver hasn't finished probing yet, or it's module
is blacklisted, or whatever.


> And once we would have good/reliable check for EC devices we can add it
> into vga_switcheroo and all users of it could benefit. Anyway, I think
> that vga_switcheroo should filter also EC GPU cards if it already
> filters Thunderbolt.

vga_switcheroo doesn't do the filtering, the DRM drivers themselves
decice whether to register with vga_switcheroo or not.  The motivation
is to avoid middle layers and instead provide the DRM drivers with
a library of helpers that they may call at their own discretion.

See this blog post and the links therein for background info:
http://blog.ffwll.ch/2016/12/midlayers-once-more-with-feeling.html

Thanks,

Lukas
