From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Wed, 15 Dec 2004 13:30:59 -0500
Message-ID: <1103135460.18982.68.camel@krustophenia.net>
References: <20041215065650.GM27225@wotan.suse.de>
	 <20041215074635.GC11501@mellanox.co.il>  <s5hbrcvqv7r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262439AbULOSbI@vger.kernel.org>
In-Reply-To: <s5hbrcvqv7r.wl@alsa2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel <alsa-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-12-15 at 19:20 +0100, Takashi Iwai wrote:
> At Wed, 15 Dec 2004 09:46:35 +0200,
> Michael S. Tsirkin wrote:
> > 
> > There were two additional motivations for my patch:
> > 1. Make it possible to avoid the BKL completely by writing
> >    an ioctl with proper internal locking.
> > 2. As noted by  Juergen Kreileder, the compat hash does not work
> >    for ioctls that encode additional information in the command, like this:
> > 
> > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> 
> I like the idea very well.  Other benifits in addition:
> 

How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
official way to do BKL-less ioctls"?

http://lkml.org/lkml/2004/12/14/53

Lee
