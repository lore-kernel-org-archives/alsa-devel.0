From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/4] ASoC: rsnd: use regmap instead of original
 register mapping method
Date: Tue, 17 Sep 2013 14:04:02 +0100
Message-ID: <20130917130402.GE21013@sirena.org.uk>
References: <87sixrre8r.wl%kuninori.morimoto.gx@renesas.com>
 <87mwnvsy7a.wl%kuninori.morimoto.gx@renesas.com>
 <87hae3sxt2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KMIs29sPfC/9Gbii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87hae3sxt2.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--KMIs29sPfC/9Gbii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2013 at 08:32:45PM -0700, Kuninori Morimoto wrote:

> +void rsnd_write(struct rsnd_priv *priv,
> +		struct rsnd_mod *mod,
> +		enum rsnd_reg reg, u32 data)
> +{
> +	struct rsnd_gen *gen = rsnd_priv_to_gen(priv);
> +
> +	if (regmap_fields_enable(gen->regs[reg]))
> +		regmap_fields_write(gen->regs[reg], rsnd_mod_id(mod), data);
> +	else
> +		regmap_field_write(gen->regs[reg], data);
> +}

Ah, sorry - I see you are actually using fields_enable().  I must've
searched for the wrong thing.  However looking at this I'm not sure that
this is a good use anyway, it seems like the caller should know if the
register it is writing to is in one of the repeated blocks.  Can you
provide a bit more detail as to what's going on here?

--KMIs29sPfC/9Gbii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOFM/AAoJELSic+t+oim9FtMP/19FYyF0X3HmIBRJXE+Y/+ZZ
sJQNrcrsncmXyfRL9SrBXZP5rTkh14D4modMyXTj8njS11B0z+nQ4VUUClvaVJGY
B1kPJXFsk9nAAWFRg9i8/HLAwFgJcA/2xmLm4jOrhokHBC8eHdX4Dd26uIDnELjt
VFqgTGjPUlu9RBlRx3dwHweV4S4eTaa6hr1FZGfgATbKOv/9xoOvtUKjVv365kug
n22cOJ8UL3pGJvUZXH9iDH3Nzef2DVQt0DXHWJNelybAkaZkWrPOqjMC4LibJVRB
VBmOj8j3at7M/Ly6Vu4GFRgrkHTgFYaNXULzqus6XVH2TWGJ43kO0ob/kbRmCSUW
8T8oK7x8TCY00dx6vjg8MYwiuiRELP/uojEauKEc1V131OdDyUZdcv1wJaFSaNAJ
BYc2lG9UTC63oR1OrZYCzG0Mc6Qy/niSC+svOX6V3idordS3K2ov/AAZX9e+E8Mm
7kF6xya+/947WIBdvAmqy7krgovRzfsY1gz018bCPt5jeDy7SAy30j6EdIufjpmF
yQQbhd5TumIPsG4QiIEwGNCYZxNYIdsl7fNF9h7ZH975y4z3TvIJzQVpn2rR/lo/
PpONwGap3c8nPiO68A202MvW3ExeUpqSa1uT/ciK9t54LNx0cvt9u1psguY+2rlL
OSE4A5HbrHh0XFKwrLNH
=P8FL
-----END PGP SIGNATURE-----

--KMIs29sPfC/9Gbii--
