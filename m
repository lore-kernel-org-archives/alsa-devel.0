From: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Thu, 16 Dec 2004 09:38:36 +0100
Message-ID: <20041216083836.GM32718@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net> <20041216050356.GH32718@wotan.suse.de> <20041216075301.GC11047@elte.hu> <20041216080952.GL32718@wotan.suse.de> <20041216002539.60d37dfe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262650AbULPIjn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041216002539.60d37dfe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 16, 2004 at 12:25:39AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > I think Michael's patch is best (but I'm probably biased) because it addresses
> >  the independent problem of a race in unregister_ioctl32_conversion() too
> >  (and some other smaller issues in ioctl 32bit emulation)
> 
> They should be separate patches.

The two new methods (ioctl_native and ioctl_compat) are in the same patch
because they basically touch the same piece of code and would be hard
to separate. The other stuff (actually replacing register_ioctl32_conversion and 
converting a few obvious users to use the BKL less fast path) will be addon patches.

> 
> >  Andrew, could we replace unlocked_ioctl.patch with Michael's patch?
> 
> Where would one locate Michael's patch?

See his mail.

-Andi
