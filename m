From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda: Abort capability probe at
 invalid register read
Date: Wed, 18 Oct 2017 15:59:44 +0530
Message-ID: <20171018102944.GY30097@localhost>
References: <20171017144711.23962-1-tiwai@suse.de>
 <20171017171508.GU30097@localhost> <s5hvajdy9ur.wl-tiwai@suse.de>
 <20171018032416.GV30097@localhost> <s5hfuahxb9n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 16EDF266EEB
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 12:25:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfuahxb9n.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 18, 2017 at 07:42:12AM +0200, Takashi Iwai wrote:
> On Wed, 18 Oct 2017 05:24:16 +0200,
> Vinod Koul wrote:
> > 
> > On Tue, Oct 17, 2017 at 07:15:08PM +0200, Takashi Iwai wrote:
> > > On Tue, 17 Oct 2017 19:15:08 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > On Tue, Oct 17, 2017 at 04:47:11PM +0200, Takashi Iwai wrote:
> > > > > The loop in snd_hdac_bus_parse_capabilities() may go to nirvana when
> > > > > it hits an invalid register value read:
> > > > > 
> > > > >  BUG: unable to handle kernel paging request at ffffad5dc41f3fff
> > > > >  IP: pci_azx_readl+0x5/0x10 [snd_hda_intel]
> > > > >  Call Trace:
> > > > >   snd_hdac_bus_parse_capabilities+0x3c/0x1f0 [snd_hda_core]
> > > > >   azx_probe_continue+0x7d5/0x940 [snd_hda_intel]
> > > > >   .....
> > > > > 
> > > > > This happened on a new Intel machine, and we need to check the value
> > > > > and abort the loop accordingly.
> > > > 
> > > > okay and what machine is the problem here. I have had a similar bug report
> > > > from Gfx CI guys on  CFL machine. Turns out the BIOS was buggy and we fixed
> > > > that up by upgrading the BIOS.
> > > 
> > > Yes, it's a CFL-H.  Possibly a buggy BIOS, but the driver still
> > > shouldn't crash.
> > 
> > Okay so can you ask them to update BIOS and check.
> > 
> > > > Yes it is a good idea to keep this guard but -1 would mean that HW read is
> > > > failing which points to some other issue here
> > > 
> > > Right.
> > 
> > In this case should we send this to stable? I have not seen this crashing
> > till now except bad BIOS issue
> 
> People will be getting test hardware now and see the Oops.
> We can't guarantee the sane BIOS, and obviously the current code does
> crash easily, and yet the code fix is trivial -- a perfect situation
> for stable :)

Right :), But do make sure to ask for BIOS update on that board.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
