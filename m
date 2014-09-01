From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCHv2 1/2] ASoC: simple-card: Fix bug of forgetting
 decrement DT node's refcount
Date: Mon, 1 Sep 2014 08:37:28 +0200
Message-ID: <20140901083728.01454558@armhf>
References: <1409535327-11449-1-git-send-email-Li.Xiubo@freescale.com>
	<1409535327-11449-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409535327-11449-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Sep 2014 09:35:26 +0800
Xiubo Li <Li.Xiubo@freescale.com> wrote:

> We shouldn't forget decrement the last DT node when the
> for_each_child_of_node() has finished searching.
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/generic/simple-card.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simp=
le-card.c
> index fd8b045..9e170fe 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -360,6 +360,7 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
>  			}
>  			i++;
>  		}
> +		of_node_put(np);
>  	} else {
>  		ret =3D asoc_simple_card_dai_link_of(node, dev,
>  						   dai_link, dai_props, true);

No. np is NULL at end of loop.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
