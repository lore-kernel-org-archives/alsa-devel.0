From: Mark Brown <broonie@kernel.org>
Subject: Re: License for UCM config files - re plumbers audio
	conf discussion.
Date: Tue, 31 Jan 2017 19:30:38 +0000
Message-ID: <20170131193038.jlnzcu7yudoogqyj@sirena.org.uk>
References: <1484218889.2604.85.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6219400589425899521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B066F267395
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 20:30:51 +0100 (CET)
In-Reply-To: <1484218889.2604.85.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "mengdong.lin" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6219400589425899521==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="peaj7yg4nseasnbx"
Content-Disposition: inline


--peaj7yg4nseasnbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 11:01:29AM +0000, Liam Girdwood wrote:

> One thing that we did not cover was the UCM config file licence, if
> indeed there is a license for the UCM config files ? It's clear to me
> that the alsa-lib source and headers are LGPL, but does the LGPL also
> apply to the runtime UCM config files ? LGPL is specifically designed
> for libraries so my understanding is that it's probably not applicable
> to the UCM runtime configuration files. =20

Even if it's not a *sensible* license in the absence of anything else
it's going to apply unless things aren't copyrightable at all (and even
there people might not want to take the risk that someone will argue).
Relicensing under something like three clause BSD does seem to make
sense though.

--peaj7yg4nseasnbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliQ5d4ACgkQJNaLcl1U
h9BpEgf9Fh3Mpa08KEKXzn4UbWrJ38uGxxsheb79pJ8GmcZYHx5s1W5FPIeLW1aU
tUcKk6hIbDVFDuuUirbDaLj+o55qGmIEE0TmtjQddy9vwSH33IBTlurzKKRtBOa/
C17HqiDST7JG5BVBgjYLFbKmE1HTP2nPY8qV+f1VSbcrM+H4A51DXLs6Xt7GZJ/g
Z8IcA5HIk3tn0EVr/P+zbvOtpCohAF1MbXYHv5Fl6yamloVXubaF4TW2Ood86DnW
PwmZYPKIxaJcUPNuozvXoK3Q0F8hJfwj+ekFRQtYnCdCgc5l+s2Y2KCbwjhRJDLi
hJj5kSBcYn3z6QOU6tBOGAVs8A5eEA==
=OQBR
-----END PGP SIGNATURE-----

--peaj7yg4nseasnbx--

--===============6219400589425899521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6219400589425899521==--
