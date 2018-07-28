From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ALSA: memalloc: declare
 snd_sgbuf_aligned_pages() unconditionally
Date: Sat, 28 Jul 2018 15:48:43 +0100
Message-ID: <20180728144843.GO2414@sirena.org.uk>
References: <20180727162805.20785-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5725456608546737335=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4534B26775C
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 16:48:47 +0200 (CEST)
In-Reply-To: <20180727162805.20785-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5725456608546737335==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BtmVPk+Smchi6n7w"
Content-Disposition: inline


--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 11:28:05AM -0500, Pierre-Louis Bossart wrote:
> Make this helper inline function available for all platforms. This
> helps solve 0-day compilation issues when CONFIG_SND_DMA_SGBUF is not
> defined.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--BtmVPk+Smchi6n7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltcgkoACgkQJNaLcl1U
h9Cahgf+PucwHtRtpl2kRpHnT8cCK2dGVAHxLdmmnPlbVyiKdq0kLJTGXSzQAf/w
lACYp1VxB7RHWlmVe7oGkVQw7uOVyYGNS/+JqBhlb03SLhC6+orxNZnoyfjaRIWr
xPvaRbNofCV03gfqX+RRKseOkc/DrebiUm0yyFGtYIVYLuOE93YNjqvYgRnOynbp
3bITR1eNyU7UVLKDmzgaOUyKalTh+3n3dzMM0s0I7je14pT5XBc+Oyi3oB7BOjTu
GGQnGHjx7JsRD2Sg11tp9wUjTRfXIxoAYaWzGRBjQH1N5xTgsFCyCogMbFZHGMoc
G0yrh4RVlsCMkqQa0XZ0IsLsBts/jw==
=4yHJ
-----END PGP SIGNATURE-----

--BtmVPk+Smchi6n7w--

--===============5725456608546737335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5725456608546737335==--
