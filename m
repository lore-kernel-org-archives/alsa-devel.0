From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Date: Wed, 5 Jan 2005 15:11:33 +0000
Message-ID: <20050105151133.GA2021@infradead.org>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org> <20050105150310.GA19758@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262460AbVAEPNP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050105150310.GA19758@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2005 at 05:03:10PM +0200, Michael S. Tsirkin wrote:
> I dont know. So how will people know they are supposed to convert then?

Tell the janitors about it - or do it yourself.  Except for taking care
of the BKL going away it's a trivial conversion.
