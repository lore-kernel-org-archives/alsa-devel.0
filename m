From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 03/14] SoundWire: Add error handling and locking
 documentation
Date: Tue, 15 Nov 2016 20:12:24 +0530
Message-ID: <20161115144224.GO3000@localhost>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-4-git-send-email-hardik.t.shah@intel.com>
 <20161114154435.GN1575@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161114154435.GN1575@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2016 at 03:44:35PM +0000, Charles Keepax wrote:
> > +
> > +Lock Hierarchy
> > +==============
> > +
> > +- Core lock is the parent of Master and Stream lock.
> > +- Master lock is parent of Message lock.
> > +- Master and Stream locks are independent of each other.
> > +
> 
> A small diagram might be nice here, just would make it easier to
> see the hierarchy at a glance.

Sure will add..

-- 
~Vinod
