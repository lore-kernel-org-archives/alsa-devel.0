From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: rsrc-card: add convert channels support
Date: Wed, 2 Mar 2016 11:39:21 -0600
Message-ID: <20160302173921.GA6580@rob-hp-laptop>
References: <877fht7376.wl%kuninori.morimoto.gx@renesas.com>
 <874mcx734l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874mcx734l.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2016 at 05:51:44AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Renesas sound device has CTU (= Channel Transfer Unit), and
> sound card needs its support.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/renesas,rsrc-card.txt           |  1 +
>  sound/soc/sh/rcar/rsrc-card.c                      | 22 ++++++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
> index 2b2caa2..5abebf7 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
> @@ -30,6 +30,7 @@ Optional subnode properties:
>  - frame-inversion			: bool property. Add this if the
>  					  dai-link uses frame clock inversion.
>  - convert-rate				: platform specified sampling rate convert
> +- convert-channels			: platform specified channel size convert

This needs a better description (as did convert-rate). What is the type?
What are valid values?

>  - audio-prefix				: see audio-routing
>  - audio-routing				: A list of the connections between audio components.
>  					  Each entry is a pair of strings, the first being the connection's sink,
