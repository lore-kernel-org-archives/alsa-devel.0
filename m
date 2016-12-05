From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 13/14] ASoC: add simple-graph-scu-card document
Date: Mon, 5 Dec 2016 16:40:38 -0600
Message-ID: <20161205224038.obcrqcvsruaajexy@rob-hp-laptop>
References: <87k2bowckx.wl%kuninori.morimoto.gx@renesas.com>
 <871sxwwcas.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871sxwwcas.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2016 at 02:48:37AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../bindings/sound/simple-graph-scu-card.txt       | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-graph-scu-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-graph-scu-card.txt
> new file mode 100644
> index 0000000..b0e46ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-graph-scu-card.txt
> @@ -0,0 +1,69 @@
> +Simple-Graph-SCU-Card:
> +
> +Simple-Graph-SCU-Card specifies audio DAI connections of SoC <-> codec.
> +It is based on common bindings for device graphs.
> +see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> +
> +Basically, Simple-Graph-SCU-Card property is same as Simple-Card / Simple-Graph-Card.
> +see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
> +    ${LINUX}/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> +
> +Main difference between Simple-Graph-Card and Simple-Graph-SCU-Card is that
> +Simple-Graph-SCU-Card can use multi CPU.

So it can have more that 1 port? At least for the bindings, I think you 
should combine these 2 bindings. Whether the driver should be combined 
is separate question. I imagine you have 2 compatible strings because 
you have 2 drivers, but that isn't really a reason to have 2.

I still have no idea what SCU is.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
