From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: Davinci: machine: Add device
	tree binding
Date: Fri, 17 Aug 2012 23:43:28 +0100
Message-ID: <20120817224327.GK18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-5-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7948969900518533237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEB2326619E
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 00:13:43 +0200 (CEST)
In-Reply-To: <1344948125-5649-5-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, peter.ujfalusi@ti.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7948969900518533237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2012 at 06:12:04PM +0530, Hebbar, Gururaja wrote:

> +- ti,codec-clock : The Codec Clock from the board

I think this is the clock rate?  Please specify it more specifically.

> +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> +"<evm ops required, evm_ops or evm_spdif_ops>";

Please be more specific as to what these actually do - consider the user
who is reading the bindings with a view to implementing them for their
board, or writing drivers for another OS.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLskEAAoJEFJkBDiqVpZ47WQP/0YoudpM3P9Ro0IjpwOsFeuv
TmDpNh3qqzFZskXVWht4vUyirCBNv5o4VTCi05pO/NHJ4MB3fi+00pYGfPhDdqYP
QcUfKvU0zQl8zk+nnsogwX9xBUyzHLvFgCG+yEB1PSml/Wi9EJucVBxHZQlH+G0Y
sMJsvUWEWZbwfdoRUnqOMgIcfcuzioONH2uNLkWR9CGI15Zt9vPDarbtJmVf4J39
c2cJbfIb5IwldXbrq4pMKL4EUtdddvdbDhQRN7yMysG5W6rvlLMuk6C8gi6AwBUQ
zalM5gVNJ5XmPPybj4Uz52n8Xm3XMlqaf0x4hXNcuax/5GMXk7aOwmJ4AQLX5QWc
jFo2d5mqbP15L0xHmTmRjo3ykHpI6WJGHNf08MvBBsbQTREHfqXZ2CzMKmC4vFPD
kpd5EvhkwUqohNvsquHVE14w1qI3WQ0fZktkxVzPBB8ablsWbOaTMvehma7PBtVd
oddCaD+Nmx67MW75gwIspyNHQGdTwPDmm2ZmcIAyK19DlILjAv9yKCJkMLGM9nUU
Vk6Xj6SjhafAG2Y5yDrsbIprrY0vw3VOSubJNMyyUTUcWbjrEwLlYbzbTMtUP/sh
rvFenZ4OU4TUTtxEiCoKccNc0AzjwMXXBqvSbt3DdivbxLLD1j8QO7FFo42yCgB6
CPSeXJa9sMJzCUHEBzrF
=n9Ux
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--

--===============7948969900518533237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7948969900518533237==--
