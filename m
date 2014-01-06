From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/19] ASoC: atmel: Don't set unused struct
 snd_pcm_hardware fields
Date: Mon, 6 Jan 2014 16:45:53 +0000
Message-ID: <20140106164553.GI31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8022529577178056692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E6B52610CF
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 17:46:06 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============8022529577178056692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXHgCOIOrtdgYERj"
Content-Disposition: inline


--BXHgCOIOrtdgYERj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:20:07PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--BXHgCOIOrtdgYERj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyt2+AAoJELSic+t+oim99PQP/iQ+YsNA+xdwgLtyO2z4TE5r
lPdTY63JZ3saeNa+iHoSm9ZGsGPX034vw6J49ZEfm55ddl+QpODFiChxzztT+zXO
h+DNhyooXF/t24ABf5tBa3A+pmhxuhgo78MqGJWJTpZuKNVKyZLrk5uAUsLFVW//
OpNvvAxzVjzK1lJ+hjCHwiVTYZEqqVbu1jmgzvp+R5sOPLxc0mcLV8dBEjNN7cGw
J3J67rlZu6RVCjPuV4J9mIHJ5Y/AxZT5KHQEVX54DKNyIzbW6aZ0d8NmSmVhAE8y
YgrS5zzjVl/qaAtuGmlpbiJ4xAj+g4VbEuQ7tSTvT5Ih7R1tTNv/9eJ6YMMIlrc1
PhUrM3RhX2qdQ9VQ35+W2bXPAHawaLgOTDOqPSNpl8ydZ9nBSJrYNPF0QsveI02v
8665aPdQG+65E3l5yvetYwivkiQhEqXtXTv/yk6UUrkTTj7YRCBChZrFu+7Cd2sz
7BIf/HYRT/NMjH8/2IO4w4JILIQKbgu0f7drFRw5Iboh80KcYxk1Ybr6ruunHXN2
llVp9l3IHgxPXnmdEZwZ+MIctGs9d0oHHna3c0PRCGQ5RVK1j3iFTlu66TJ7P56e
Ppem7FzpKtK7L78bW8RE6qHeioj42tEgepHfc4jjxzYEd2dVrzipqe7k7lIEwJ80
kvAF3wN2iwmX4oHKotSC
=dKyO
-----END PGP SIGNATURE-----

--BXHgCOIOrtdgYERj--

--===============8022529577178056692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8022529577178056692==--
