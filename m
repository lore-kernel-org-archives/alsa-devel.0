From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Date: Wed, 5 Jan 2005 14:46:03 +0000
Message-ID: <20050105144603.GA1419@infradead.org>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262118AbVAEOqR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050105144043.GB19434@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2005 at 04:40:43PM +0200, Michael S. Tsirkin wrote:
> Hello, Andrew, all!
> 
> Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
> here is a patch to deprecate (un)register_ioctl32_conversion.

Sorry, but this is a lot too early.  Once there's a handfull users left
in _mainline_ you can start deprecating it (or better remove it completely).

So far we have a non-final version of the replacement in -mm and no single
user converted.
