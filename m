From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: remove unneeded sound
 #address/size-cells
Date: Mon, 25 Feb 2019 10:11:49 +0100
Message-ID: <20190225091149.ojihawt67okyurk3@verge.net.au>
References: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
 <877edo3bt3.wl-kuninori.morimoto.gx@renesas.com>
 <20190225090054.idyvcxgy3kupsgat@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225090054.idyvcxgy3kupsgat@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: twischer@de.adit-jv.com, patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

[CC linux-renesas-soc@vger.kernel.org, for the record]

On Mon, Feb 25, 2019 at 10:00:54AM +0100, Simon Horman wrote:
> On Mon, Feb 25, 2019 at 10:30:49AM +0900, Kuninori Morimoto wrote:
> > 
> > Hi
> > 
> > > From: Jiada Wang <jiada_wang@mentor.com>
> > > 
> > > commit 78bc93b3ffb2 ("arm64: dts: renesas: r8a7796: Add address
> > > properties to rcar_sound port nodes") added missing #address-cells
> > > and #size-cells for sound ports.
> > > But, these are based on platform, not on SoC. This patch cleanups it.
> > > 
> > > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> > > Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> > > ---
> > 
> > I thought I had mentioned about this, but it seems no fix...
> > Anyway
> > 
> > 	Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks Morimoto-san,
> 
> applied for v5.2.
