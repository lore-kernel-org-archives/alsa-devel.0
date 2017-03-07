From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ASoC: TLV320AIC23: Unquote NULL from
	control name
Date: Tue, 7 Mar 2017 13:06:31 +0100
Message-ID: <20170307120631.ixlwdjldliqijw4k@sirena.org.uk>
References: <20170301122628.10392-1-liviu@dudau.co.uk>
 <20170306104118.6v763cejdc3ow6ef@sirena.org.uk>
 <20170307005408.GB8397@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4492149246184015505=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B23A32669EA
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:06:50 +0100 (CET)
In-Reply-To: <20170307005408.GB8397@bart.dudau.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4492149246184015505==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubii4tvbwali66eb"
Content-Disposition: inline


--ubii4tvbwali66eb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 07, 2017 at 12:54:08AM +0000, Liviu Dudau wrote:
> On Mon, Mar 06, 2017 at 11:41:18AM +0100, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> Other than the additional ALSA: prefix I have matched the format used
> by previous commits touching the file. I'm not clear where I have made the
> mistake and what would have been the better subject line.

It's the extra ALSA prefix, the start of the subject line is the most
important bit to get right since it's that that people are most likely
to pattern match on.  You also used caps for the name of the CODEC,
normally they use lower case, though that is less important.

--ubii4tvbwali66eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli+okYACgkQJNaLcl1U
h9BIcgf/SCeZ3U9FxtvQWLtq2vBX1nyRMxokKJh+GbDxfAczO52FgAhH55tD2R9D
poBp+e5vwDtbbF42tXGGnlv+Xof1BQ20mAegkc/KTJoNfM7QJTmQQCKzb1SQNuiL
nt6oAGUmaZif0YaC+oY90OtyPaCyW/MITdlWRchOmT6hplLvR4hu80m2zRPQ5wvg
m/qEOiDhqyue65JT0I82bTHiX+YI3EjlcalwsM0k0dJ0swnI1L/Z7wzN7Nj88OCr
zhIMcrlGS9Vzxw7axq+aszjAxnWdWAm3uoOATAPqOI4H20mR35lkrvcivLjPJU+v
FBFWRXXHrAY4JjaGzYTT2+NPHFaX9Q==
=JIDr
-----END PGP SIGNATURE-----

--ubii4tvbwali66eb--

--===============4492149246184015505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4492149246184015505==--
