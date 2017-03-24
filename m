From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ASoC: rcar: ssi: don't set SSICR.CKDV = 000 with
 SSIWSR.CONT
Date: Fri, 24 Mar 2017 07:55:12 +0100
Message-ID: <20170324065512.GH1319@verge.net.au>
References: <87zigenerc.wl%kuninori.morimoto.gx@renesas.com>
 <4764a887-edbc-efa3-881b-3edfb1175d01@cogentembedded.com>
 <87o9wtofqy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o9wtofqy.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-renesas-soc@vger.kernel.org, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 22, 2017 at 08:56:07AM +0000, Kuninori Morimoto wrote:
> 
> Hi Sergei
> 
> > >  		/*
> > > +		 * It will set SSIWSR.CONT here, but SSICR.CKDV = 000
> > > +		 * with it is not allowed. (SSIWSR.WS_MODE with
> > > +		 * SSICR.CKDV = 000 is not allowed either).
> > > +		 * Skip it. See SSICR.CKDV
> > > +		 */
> > > +		if (j == 0)
> > > +			continue;
> > 
> >    Why not change the *for* statement itself to start with j = 1?
> 
> It can be one solution. Actually my local 1st patch was such style.
> But I thought that it is difficult to notice such magical operation from code.
> Thus, I used this style

FWIIW, I think if you have a comment, like the one above, then j = 1 should
be obvious enough.
