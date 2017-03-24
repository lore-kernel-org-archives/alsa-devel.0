From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack - check status of GPIO-based
	pins on resume
Date: Fri, 24 Mar 2017 18:51:47 +0000
Message-ID: <20170324185147.rwbi2qqynr2yggq2@sirena.org.uk>
References: <20170321235043.GA9831@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0731592729672069259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FEA82669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 19:52:02 +0100 (CET)
In-Reply-To: <20170321235043.GA9831@dtor-ws>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0731592729672069259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x2u6iaae2j6wu27n"
Content-Disposition: inline


--x2u6iaae2j6wu27n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2017 at 04:50:43PM -0700, Dmitry Torokhov wrote:
> From: Dmitry Torokhov <dtor@chromium.org>
>=20
> For GPIO-backed pins that are not configured as wakeup sources, we may
> miss change in their state that happens while system is suspended. Let's
> use PM notifier to refresh their state upon resume.
>=20
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---

Please send patches from the mail account corresponding to the signoff,
not doing that makes the patch look like it's missing a signoff (as it's
got the From line so more than one signoff is expected but there's only
one) which slows down review.

--x2u6iaae2j6wu27n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVasMACgkQJNaLcl1U
h9Ao/gf+J/N5ufrYVRBZyk9CQRd2jq7GAV984QrPOHBMu2Xin1L3JcPrgcUZO/u+
qiq8YzuYDiyo4nLeuz7ahhPPx53Wwqhm0zNFmoZWo6IxnB2mA2sIVfb6hEk+qabI
uVfVDPuV4wOf0p8xo5eV6xhgPMubTAGbRc3y6FCDq+RAz+/vqSzbH2XIEFr/hbMf
z35DMpGydV1yNAB1dXRYHd1F42iB1IL8S4sn8wkVUWU6a/1xJ/1Xk98DY65YFhQJ
G5+/CDYL0dVfQnHFgw/3pQ1jUypXUugTvlEgpKbAVi+f40LkSE5tF26psPXVeg3v
uQW6z97nF4RReH4wjFm+yH6C3rQYww==
=mZUQ
-----END PGP SIGNATURE-----

--x2u6iaae2j6wu27n--

--===============0731592729672069259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0731592729672069259==--
