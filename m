From: Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules.
 ioctl32 revisited.
Date: Thu, 16 Dec 2004 00:25:39 -0800
Message-ID: <20041216002539.60d37dfe.akpm@osdl.org>
References: <20041215065650.GM27225@wotan.suse.de>
	<20041215074635.GC11501@mellanox.co.il>
	<s5hbrcvqv7r.wl@alsa2.suse.de>
	<1103135460.18982.68.camel@krustophenia.net>
	<20041216050356.GH32718@wotan.suse.de>
	<20041216075301.GC11047@elte.hu>
	<20041216080952.GL32718@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262655AbULPI2r@vger.kernel.org>
In-Reply-To: <20041216080952.GL32718@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: mingo@elte.hu, ak@suse.de, rlrevell@joe-job.com, tiwai@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Andi Kleen <ak@suse.de> wrote:
>
> I think Michael's patch is best (but I'm probably biased) because it addresses
>  the independent problem of a race in unregister_ioctl32_conversion() too
>  (and some other smaller issues in ioctl 32bit emulation)

They should be separate patches.

>  Andrew, could we replace unlocked_ioctl.patch with Michael's patch?

Where would one locate Michael's patch?
