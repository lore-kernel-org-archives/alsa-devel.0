From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Date: Thu, 6 Jan 2005 23:34:59 +0100
Message-ID: <20050106223458.GA2766@elf.ucw.cz>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263078AbVAFWnu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050106163559.GG5772@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Hi!

> > > > It should be, unless there's some problem.  In maybe a week or so.
> > > 
> > > To make life bearable for out-of kernel modules, the following patch
> > > adds 2 macros so that existance of unlocked_ioctl and ioctl_compat
> > > can be easily detected.
> > 
> > That's not the way we're making additions.  Get your code merged and
> > there won't be any need to detect the feature.
> 
> When Greg made sysfs GPL only, I've asked whether it is possible to merge
> vmmon/vmnet in (and changing its license, of course).  Answer on LKML was 
> quite clear: no, you are not interested in having vmmon/vmnet in Linux 
> kernel as you do not believe that they are usable for anything else
> than VMware.  

What about

1) Put vmmon/vmnet under GPL

2) Find some GPL user of vmmon/vmnet

3) Merge should be doable now

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
