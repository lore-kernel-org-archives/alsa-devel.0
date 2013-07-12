From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: codec: SPDIF only works with Tx/Rx seperate
	codec drivers?
Date: Fri, 12 Jul 2013 12:33:53 +0100
Message-ID: <20130712113353.GC24508@sirena.org.uk>
References: <20130712083030.GA28555@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5217465960071856399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A562659BB
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 13:33:56 +0200 (CEST)
In-Reply-To: <20130712083030.GA28555@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5217465960071856399==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r6fxLKBTHCmC166Z"
Content-Disposition: inline


--r6fxLKBTHCmC166Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2013 at 04:30:31PM +0800, Nicolin Chen wrote:

> Actually I'm gonna prepare some patches to add Freescale SPDIF drivers.
> But this needs to create a brand new dummy SPDIF codec driver, which's
> some kinda same as spdif_receiver/transmitter.c but quite different
> in the supports of SAMPLE_RATE/FORMAT and IN/OUT-in-one integration.

We could just merge them into a single driver easily enough.

--r6fxLKBTHCmC166Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3+meAAoJELSic+t+oim9xIQQAJDDtaZfPEj8QFrCuxGJxaIv
10VrsuwxSMVOpFSEaPqFcGBEPx0bFukruLhw9GSbK/jTY9clIyJfKJHe9SFptPWs
yacSWbL/Ye07luDpnumnSQ5SgQpaa012zwug3UI6PuZLNvQ0NQplKndnbqHrcKWZ
LwkIkPjFSEBVVkUs9GXWf9uMcuGFHR201Ue6rkEX1o9PPETXVgm6hNnl4fnZZLc7
XvIcY1dsk2IXnQZgMaw3w0sGrC8U5WsRPaptzjrkto3lOIAkOI4t4JQPTyu7WNaa
zZUOkARBkS03af/noDIDGgLXcwsI5AzqBXk3gidVvVzUO3doojZ7D39qS5ihcri4
7Wi5mO405omhEKWZi6GltPQFTQA6VQ1EaNyd71VbFnJj2hyRvo1TmKse5JRDtIFN
PaSq7BjCXqR/ncYgTYDOuFLrSZimPZpibuwN8Breg/MgKUG+HHcQqvRk6ZlJDr9E
zOboOZ82o3dJvBoOzkZTOP5sH0mu/tUSjI0Bdf9iJUhKBTPbTbjlJdCakwJ+vEyZ
+nwGmSqiiuTgvkhfDE4cwQIcsSDMVIuMq2Bsl4pbR80iCSsQTJMFiDPOveF7dPpY
ND4s/mr7moc9gzdHsTikVLnmpWr51QYEO2CDBrouhrkU3QLLjW9cjrkh+ANXorVz
O3tpIN9sjMMmINoQMWhm
=sk8U
-----END PGP SIGNATURE-----

--r6fxLKBTHCmC166Z--

--===============5217465960071856399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5217465960071856399==--
