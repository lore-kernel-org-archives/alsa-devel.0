From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Thu, 16 Dec 2004 10:30:58 +0200
Message-ID: <20041216083058.GA21887@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net> <20041216050356.GH32718@wotan.suse.de> <20041216075301.GC11047@elte.hu> <20041216080952.GL32718@wotan.suse.de> <20041216002539.60d37dfe.akpm@osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262645AbULPIbM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041216002539.60d37dfe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Hello!
Quoting r. Andrew Morton (akpm@osdl.org) "Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.":
> Andi Kleen <ak@suse.de> wrote:
> >
> > I think Michael's patch is best (but I'm probably biased) because it addresses
> >  the independent problem of a race in unregister_ioctl32_conversion() too
> >  (and some other smaller issues in ioctl 32bit emulation)
> 
> They should be separate patches.
> 
> >  Andrew, could we replace unlocked_ioctl.patch with Michael's patch?
> 
> Where would one locate Michael's patch?

Here it is for review (against 2.6.10-rc3) http://lkml.org/lkml/2004/12/15/62
I plan to incorporate Arnd Bergmann's comments and repost later today.

MST
