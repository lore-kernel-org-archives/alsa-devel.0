From: Simon Horman <horms@verge.net.au>
Subject: Re: BockW 4th sound doesn't work on latest linus/master
Date: Wed, 29 Jan 2014 21:38:23 +0900
Message-ID: <20140129123821.GC24573@verge.net.au>
References: <878uu08tp8.wl%kuninori.morimoto.gx@gmail.com>
 <8761p48ry3.wl%kuninori.morimoto.gx@gmail.com>
 <20140129062942.GF23833@verge.net.au>
 <87wqhj6yvl.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wqhj6yvl.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 28, 2014 at 11:17:06PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Could you post a patch to revert the offending defconfig change.
> > 
> > Geert tells me that DEVTMPFS is needed for udev on Debian Jesse
> > and is also common in other arm defconfigs. So I think it should be
> > enabled.
> 
> Yes, it is needed for udev.
> I can send patch, but, according to git comment,
> the defconfig which doesn't have DEVTMPFS is not only BockW.
> Do you want "revert patch" ? or "add DEVTMPFS for all board patch" ?

I think the second option would be best.
