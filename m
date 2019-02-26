From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77965: add SSIU support for
 sound
Date: Tue, 26 Feb 2019 12:14:12 +0100
Message-ID: <20190226111412.llczj7f7t3ssfu2g@verge.net.au>
References: <1551098381-1733-1-git-send-email-twischer@de.adit-jv.com>
 <87a7ijbfdx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87a7ijbfdx.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: twischer@de.adit-jv.com, patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 26, 2019 at 08:58:37AM +0900, Kuninori Morimoto wrote:
> 
> Hi
> 
> > rsnd driver supports SSIU now, let's use it.
> > Then, BUSIF DMA settings on rcar_sound,ssi (= rxu, txu) are
> > no longer needed.
> > Applies commit 8d14bfa074db ("arm64: dts: renesas: r8a7796: add SSIU
> > support for sound") and commit 10bd03fa896e ("arm64: dts: renesas:
> > r8a7796: remove BUSIF0 settings from rcar_sound,ssi") for r8a77965.
> > 
> > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> > Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> > ---
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, applied for v5.2.
