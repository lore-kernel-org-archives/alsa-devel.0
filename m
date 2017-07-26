From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fix balance of of_node_get()/of_node_put()
Date: Wed, 26 Jul 2017 12:37:28 +0100
Message-ID: <20170726113728.fpj3kboxib5tnmzv@sirena.org.uk>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pdg3od3nsu3laalx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725214952.6491-1-borneo.antonio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--pdg3od3nsu3laalx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 11:49:52PM +0200, Antonio Borneo wrote:

> Fixed by:
> - removing of_node_put() in the body of of_for_each_phandle(){},
>   since already provided at each iteration. Add it in case the
>   loop is break out;
> - adding of_node_get() before calling of_graph_get_port_parent()
>   or asoc_graph_card_dai_link_of().

>  sound/soc/generic/audio-graph-card.c  | 14 +++++++++-----
>  sound/soc/generic/simple-card-utils.c |  5 +++++
>  sound/soc/soc-core.c                  |  5 +++++
>  3 files changed, 19 insertions(+), 5 deletions(-)

This is a series of different changes to fix different (although
related) problems which should be being submitted individually.  Sending
multiple changes in one patch makes it harder to review things and for
fixes like this makes it harder to backport the fixes where not all the
code being fixed was introduced in a single kernel version.

>  	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
> +		/*
> +		 * asoc_graph_card_dai_link_of() will call
> +		 * of_node_put(). So, call of_node_get() here
> +		 */
> +		of_node_get(it.node);
>  		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);

Why is this the most sensible fix?  It is really not at all obvious why
asoc_graph_card_dai_link_of() would drop a reference, or in what
situations callers might have a reference they're OK with dropping.

> +	/*
> +	 * of_graph_get_port_parent() will call
> +	 * of_node_put(). So, call of_node_get() here
> +	 */
> +	of_node_get(ep);
>  	node = of_graph_get_port_parent(ep);

Same here, why does this make sense?  It is not in the least bit obvious
to me why looking up the parent of a node would cause us to drop the
reference to the current node, this seems like an error prone and
confusing API which would be better fixed.

--pdg3od3nsu3laalx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4fvcACgkQJNaLcl1U
h9CU1Af/ZReSDQ01CwRuuzsJP8lxhw3m0xV3AcWyJXx68mG8yCaZpzU+zwNsbdfp
0Fsy95he+dWefcI7BX/5AMiPWzQPW0Fwrmn1/ZxHF2QYV9WZbiR5KJPRuOyHMNLz
0jQ9QKTz6a880Oxs+I+MwuGowlXAXQGzNvZy+l+vphnxAHORmyytdyLgP4b2ZHkh
9KZLomO75Cr1uj0Yy2Cv88lzKO2n1D8FN+ftY7PAUJjjA6tlYBJN/b/u8Xazc2vn
T57AnedST74vYuYT/YZurYTQFv2g00ZEwOyqU99Ccy+sdn3hKhWdD16UyPPhidpG
WNRNgPsTV7es9qhSCaWu+dmn13NtBg==
=DCn/
-----END PGP SIGNATURE-----

--pdg3od3nsu3laalx--
