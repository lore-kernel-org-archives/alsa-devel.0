From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Date: Thu, 6 Jan 2005 17:57:15 +0100
Message-ID: <20050106165715.GH1830@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262881AbVAFQ5i@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050106163559.GG5772@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2005 at 05:35:59PM +0100, Petr Vandrovec wrote:
> BTW, vmmon will still require register_ioctl32_conversion as we are using
> (abusing) it to be able to issue 64bit ioctls from 32bit application.  I
> assume that there is no supported way how to issue 64bit ioctls from 32bit
> aplication anymore after you disallow system-wide translations to be registered
> by modules.

Why are you issuing 64bit ioctls from 32bit applications? 

-Andi
