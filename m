From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: check suspend state in
	dapm_dai_check_power()
Date: Mon, 3 Jun 2013 20:44:43 +0100
Message-ID: <20130603194443.GU31367@sirena.org.uk>
References: <1370281000-1120-1-git-send-email-swarren@wwwdotorg.org>
 <20130603185120.GS31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8224622691884858942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EABD2264FB0
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 21:44:47 +0200 (CEST)
In-Reply-To: <20130603185120.GS31367@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8224622691884858942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2013 at 07:51:20PM +0100, Mark Brown wrote:

> I would expect us to be dealing with this as part of quiescing the DMA
> operations on the links - it's not just the CODEC that needs handling
> here.  This feels like it ought to be more joined up somewhere along the
> line.

So having grovelled a bit this is of course more annoying than it should
be; the trigger operation is in atomic context and there's nowhere
convenient to react to it outside of suspend and resume.  That said the
active flag is only being used for links started and stopped from
userspace so this change *ought* to be safe to do what you're doing but
it still doesn't seem terribly clever.

Another way of looking at things here is that the DAI widgets are
unusual in that they don't require a complete path to power them as
widgets generally do (including DACs and ADCs).  If we fixed that
instead then everything would work just fine.  This should just be a
case of splitting the playback and capture DAIs into separate widget
types and then using the existing DAC and ADC functions.  I can't recall
why we didn't do that in the first place, it's probably just an
oversight...

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrPIoAAoJELSic+t+oim937EP/2KXrvgJZoshSBmh8m4hNGVd
g1S2JB2v83dAchyBSEvuR7Ft5rXIYc3Nb3RxklsQCHzR7dkEwFvRFkGEKOoq97hB
LmNVEnDoJia1dzs+0VdHT0+Y5BBdkBTe/TDELjHfDPAh1+z1Sb8PqphJ5QwJ5BGq
slmUG+URx7+q0NpjQhq3vyVCQlgfoO6BtXW+avCBBTuwQDH0YUHFYTpS9sISykAZ
HflB7karSr6HB4ob7W8OECddclCaUXS04kTvjMEoNHkij1XcZ2GfMJCaa6aAbP4G
c7sAA3DJh1c+xfb4kLIoLNLV0ObqGzGqfKhe3FWehVZxijluvw0RIRDfYL0xyfJ/
+vn/nCUzpPJRQgP/FfD7vMVRRlCr2099ObyVgSeRhi564eB0AAmnVCJCJR7TkpDk
oKNWyCZi78ti9pKWXobnKlyR9WRnVPiPMdGl71TSNPXAnzY+sX+HIlbtTrXzkf+S
ZY3bxcMjDshjU4szB0GgBwELSog5uw2ptqWNIFhjWeJwb+v4sVykKLZMNWAmOk6k
+Cn3pzQoHiu9rRZ8dC5ebxiBkRzH5515nhlgv2ForY/ugyO5hatXx4NLwLIpt6Br
GZR6g2dVjOpKM6Cl/5tBV7D6rLs1CCjBY6tLrzSU0jQorpVbE851mCQw2ZcPMg6/
QDG2ltsufbPMuSs2M0M+
=0aHa
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--

--===============8224622691884858942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8224622691884858942==--
