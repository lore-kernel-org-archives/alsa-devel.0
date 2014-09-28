From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: byt-max98090: Set card as
	fully routed
Date: Sun, 28 Sep 2014 14:11:45 +0100
Message-ID: <20140928131145.GB27755@sirena.org.uk>
References: <1411737938-29903-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1411737938-29903-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3892466497128961337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A0FA26057A
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 15:12:09 +0200 (CEST)
In-Reply-To: <1411737938-29903-2-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3892466497128961337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xwCJTF497Cudft2o"
Content-Disposition: inline


--xwCJTF497Cudft2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2014 at 04:25:38PM +0300, Jarkko Nikula wrote:
> All byt-max98090 audio connections are known and described in DAPM routing
> table. Set the fully_routed flag in order to disable unused codec pins.

Applied, thanks.

--xwCJTF497Cudft2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKAkQAAoJECTWi3JdVIfQSlIH/jIlyjtIRZccxOlWhRxv/Ek/
VG896oKmLCJEjOMM2/j6TMu+YWXESZD3ugHhkd0cSWAmrcaHjExtPZ28JJOVTNJa
ejnVEeKQqoG0PleicYozY/k2H2+h5Nj58OKCQhDy06ZVc9yh94APC/M3eBQ3j2vV
nTa2W2cA4sY5iJyB6OOA6GOA+L4YLHojLHpRVFRs2RR4ULgBTv1V4/fqLx7vza1h
02YFtEbiMr8BxOzzlmK/a6xbNWCqyyGO3MjTwn+qd2t/QlhQOmXumVVVWt9pIptb
S+3Zq1d7ezDLyTEsSUfUsuLFoD6tjK5sVgSuD7OBQyA+NBQ5+E5i3RDDjE1OH3k=
=fn2k
-----END PGP SIGNATURE-----

--xwCJTF497Cudft2o--

--===============3892466497128961337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3892466497128961337==--
