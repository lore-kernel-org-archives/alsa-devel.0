From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Wed, 16 Dec 2015 20:18:06 +0530
Message-ID: <20151216144806.GO1854@localhost>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
 <20151201025654.GJ3901@localhost>
 <20151201122747.GG1929@sirena.org.uk>
 <20151202052330.GE1854@localhost>
 <20151202103241.GC1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2106003215148899025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1E32657F9
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 15:44:52 +0100 (CET)
In-Reply-To: <20151202103241.GC1929@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2106003215148899025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 10:32:41AM +0000, Mark Brown wrote:
> On Wed, Dec 02, 2015 at 10:53:30AM +0530, Vinod Koul wrote:
>=20
> > But if we do wrt from CPU the situation is different
>=20
> >      CPU Tx (Pb)  -----------> Codec Tx (Pb)
> >      CPU Rx (Cap) <----------- Codec Rx (Cap)
>=20
> > Since this follows normal playback kind of scenario, we need to link pb=
-pb
> > and cap-cap
>=20
> But neither of these is a CODEC so why would the CODEC flag be set in
> the DAI?  Unless your "Codec" here is genuinely the CODEC rather than
> the CPU DAI connected to the CODEC in which case surely this is just a
> normal DAI link?

Sorry Mark for late reply..

You are right this is like a normal link, and yes that is _exactly_ we need,
but we also need parameters to be specified for this as this is hostless.

The moment I add 'params" core will do different connections which do not
work for us.

I am okay if you have something else in mind which solves our problem :)

Thanks
--=20
~Vinod

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcXmmAAoJEHwUBw8lI4NHsaUQAJaeFdhzjImIS87rFjFHF6ZD
ZUPWYdfxKQVyD65OV9DoWub1BKQ3M7Uu7qgb19vXNZ4tOO3iE5GV9b8cWPi52cQe
NRfLVU6L5HsvvHw/X4TmWHcmAvQuyxJtU5gbwUs4DlX8NE/XmfPh87kOXoGaJNWU
P+aYnNk91FvmfA8sqzV183oAe+sWzG72ur51KGdyuQziIbHsKdW/lQ+BfZ69hU87
XeeRbpkia7cdOO7Ypyv88+Zvf02Gmg8WUT3vGdhOFc0xEnIxjDJmYFBCmGCu+OWi
Zh+a4V1xOQXXWWK78wM0TzpJdJQcrsggwdkCP5cPRfaYR3INCf1BhY+o/A00+ull
7dAW8f7Zj5hGxgDEu4m6RxFJJpmbjhu1gXMdFaC4x/dNLJqA8RNBGwb7Kb6qOdwI
qTlD/81+FNiw5PTwVPkmp7eGHCqhUmhxCTItctvUU0n9TL0fSnIbj/kkOF+mNDa/
jnfsUImOG9Sq1m6KR7RkgzEJ5H+W+dG+jNNSPZgZf+T1Rqq97k7i3Br3rKmZw+cV
kW541vwct0mE1UttrThiS3BpLB0YQZanOxQdB90wG2//osVCBqjRIbFEYGjR++tV
IcGSiFy8kRAxSFsBDhkoHJGQNWfXEX1YiVz9ldMoKOrgaOpnXNzNUwib4UWDgNu5
FsXfHzUgrqESauh+eUYU
=8SBG
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--

--===============2106003215148899025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2106003215148899025==--
