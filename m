From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Date: Thu, 6 Jan 2005 14:53:56 +0000
Message-ID: <20050106145356.GA18725@infradead.org>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262847AbVAFOyW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050106140636.GE25629@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com, VANDROVE@vc.cvut.cz
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2005 at 04:06:36PM +0200, Michael S. Tsirkin wrote:
> > It should be, unless there's some problem.  In maybe a week or so.
> 
> To make life bearable for out-of kernel modules, the following patch
> adds 2 macros so that existance of unlocked_ioctl and ioctl_compat
> can be easily detected.

That's not the way we're making additions.  Get your code merged and
there won't be any need to detect the feature.
