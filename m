From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Thu, 16 Dec 2004 08:53:01 +0100
Message-ID: <20041216075301.GC11047@elte.hu>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net> <20041216050356.GH32718@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262626AbULPHxc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041216050356.GH32718@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel <alsa-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org


* Andi Kleen <ak@suse.de> wrote:

> > How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
> > official way to do BKL-less ioctls"?
> 
> This is another "official" way which is more powerful. I suppose it
> will replace Ingo's patch.

the ALSA changes are mine but i'm otherwise building ontop of the 
following patch in -rc3-mm1:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/broken-out/unlocked_ioctl.patch

whichever approach gets adopted upstream, the various actors ought to
synchronize a bit more - this is the third approach so far in a very
short interval to get rid of the BKL in ioctls :-)

	Ingo
