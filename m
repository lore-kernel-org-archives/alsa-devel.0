From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc-core: make kernel complaints on
 -EPROBE_DEFER dev_dbg
Date: Wed, 9 Nov 2016 14:36:42 +0000
Message-ID: <20161109143642.7knvr63vwmcgunjf@sirena.org.uk>
References: <20161109140036.GB20859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7946246638465574128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF40266802
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:37:30 +0100 (CET)
In-Reply-To: <20161109140036.GB20859@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7946246638465574128==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brn7nz4h45u7xsif"
Content-Disposition: inline


--brn7nz4h45u7xsif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 09, 2016 at 03:00:36PM +0100, Ladislav Michl wrote:
> There is no point having these complaints to be dev_err as
> they are just adding noise to bootlog.

No, errors are errors and not displaying them just makes it harder for
people to debug things.  If you don't want to see errors just change
your system configuratiion to hide them.  If you don't like deferred
probing please contribute to the efforts to order probing.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--brn7nz4h45u7xsif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIzR5AAoJECTWi3JdVIfQfaYH/inZRGq+Rqh0+O2B727qiPQv
fAPzlXqSNO3h6XATEBScYc8V/Tpidbrmm0St7eHYSWKpSG1cpWAao/4+XncrvRMh
MXeOBN9h8bSoixxuj5dQsKxN+SR/uIBbPnrrfxG5ym9fJynVCnyjpGRQN1ccQeDr
lYiAQFVWpWPDqaO2c3irwhc+QnfMkUPnhCRHhWwc6L2nE5dqo7hzW5DAmbWZgPwU
YmkZ9U5yeMi1ZTRCp952YN/4wQyO4styvupsIevYYmZeLKTF6bREuM7iMMyGEjW8
5VTjOaLLAa/VMeJs+1O4J09JOeOFg4QZKHv8dYwh853vIZ3pkiO5I+xalMJmbhE=
=CrTL
-----END PGP SIGNATURE-----

--brn7nz4h45u7xsif--

--===============7946246638465574128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7946246638465574128==--
