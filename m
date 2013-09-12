From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Thu, 12 Sep 2013 12:56:26 +0100
Message-ID: <20130912115626.GO29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
 <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
 <20130912110800.GI29403@sirena.org.uk>
 <62c9342f91e99fa5d421a7ad29fbf354@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0005525656044122692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 043AF2619F6
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:56:28 +0200 (CEST)
In-Reply-To: <62c9342f91e99fa5d421a7ad29fbf354@kapsi.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <oku@iki.fi>
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, Joel Fernandes <joelf@ti.com>, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0005525656044122692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NYDXpqjHYlOmfapm"
Content-Disposition: inline


--NYDXpqjHYlOmfapm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 02:34:13PM +0300, Jyri Sarha wrote:

> The bottom line of my suggestion is only to add the dma register
> location
> to reg-property, since that info is needed in the mcasp node also in the
> future dmaengine_pcm-implementation.

What exactly is the dma register location here - what hardware is being
controlled?

--NYDXpqjHYlOmfapm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMavmAAoJELSic+t+oim9KawP/3tUS9BhPnVREvYOviC+w0eS
q/p12PXdVO0Vijnnx1MpHfOa7Qruokcd52hgkd9NJikbG1SM4tPPflud+4Pwj8Dx
t8ck9iHgj0FsKZXvhPaIfNH/Yp+/tqry5VMMzr2Z33KGWBFvpz0KOm/DyNmOyiDz
1OzV/iJjArEu4vvZHd9DOP0gm7bmABjjwR9Vka8hRk7NnzcY2ZqdzRAVFxwx0MiC
e9j4H9UOAdAbkqSl8oncukKgg7EjLoLxryZrHfjdM/wqoJCICKyny0rC2cA/HqiZ
8UTRN8kgdMfZTn3RvnYDKBXcTMHII622B/Epl5HfGEggWjTBWEFtEJo1obi9Gbk3
yKTpt4PeZanz7c3j9weT5YsTu7Q6pTlShMLcTBbTKOK8HQK2LW4X0F3x7rScGjTf
FLKUQ0Q/T1/29jQoSjXcsdQlnThfA9PCG4Vlr5oBcXwVE5/syelUifj17vWhP12U
rJJlHY8agqKksDOZjJfJA5hxqXuQBtyJjo/VfNzX6M+AoXCMaIc+9D+t3FMY/iRJ
vga+4FAsVl0+zqwxjnxmLqLbgV34jaZ6NoTAsptjgetplHQHYMf/8B6TGMB53a4K
HsSWZ1pf4rUhziwOKdlg8xaqaXFPJ9alyES8mDt9wKXMsqk9sjN3hQOetgM8kpTp
yRdR6gr3ZSgMdpRht+qt
=VqLC
-----END PGP SIGNATURE-----

--NYDXpqjHYlOmfapm--

--===============0005525656044122692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0005525656044122692==--
