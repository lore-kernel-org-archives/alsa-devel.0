From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Sun, 15 Apr 2018 21:05:23 +0200
Message-ID: <20180415190523.GA16129@wunner.de>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
 <20180414104950.ngomyjy5l5cwhb5i@pali>
 <20180414111711.GA4245@wunner.de>
 <20180415171746.futkvgbaoj6quy5z@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [83.223.95.100])
 by alsa0.perex.cz (Postfix) with ESMTP id BC2BD26705F
 for <alsa-devel@alsa-project.org>; Sun, 15 Apr 2018 21:05:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180415171746.futkvgbaoj6quy5z@pali>
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

On Sun, Apr 15, 2018 at 07:17:46PM +0200, Pali Roh=E1r wrote:
> On Saturday 14 April 2018 13:17:11 Lukas Wunner wrote:
> > On Sat, Apr 14, 2018 at 12:49:50PM +0200, Pali Roh=E1r wrote:
> > > On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> > > > On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > > > Do you have any suggestion to check if it connects to the system =
via
> > > > > Thunderbolt?
> > > > =

> > > > Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> > > > like this:
> > > > =

> > > > if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(=
pci))
> > > =

> > > And what about PCI-e device attached to ExpressCard slot?
> > =

> > I don't know of a bullet-proof way to recognize those.  In theory
> > one could check if the PCIe port above the GPU is a non-hotplug
> > root port, but I think there are machines with hotplug capable
> > root ports with GPUs below them that aren't actually removable.
> > =

> > However I think ExpressCard-attached GPUs were rare, much less ones
> > with integrated HDA controller, so in reality that's probably a
> > non-issue.
> =

> Hm... maybe another idea: Is it possible to detect which audio pci
> device belongs to graphics card via vga_switcheroo? Currently, looking
> at output it is same PCI device as graphic card, just different PCI
> function.

No, the DRM drivers don't filter ExpressCard-attached GPUs when
registering with vga_switcheroo.  They do filter Thunderbolt-
attached GPUs.

The ExpressCard 2.0 spec defines some ACPI stuff that *might* be
used to recognize root ports that are ExpressCard slots, but I'm
not sure how reliable that is.  I don't have such a machine and
have no experience with it.

This is from the MacBookPro8,3 DSDT:

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)
                OperationRegion (A1E0, PCI_Config, 0x19, 0x01)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    SECB,   8
                }

                Device (EXCD)
                {
                    Name (_ADR, 0x00)
                    Name (_SUN, 0x01)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (0x01)
                    }

                    Name (_EJD, "\\_SB.PCI0.EHC2.HUBN.PRTN.PRT4")
                }
                ...
            }

Thanks,

Lukas
