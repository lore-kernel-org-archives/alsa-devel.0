From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: codec: use enable pin to control dmic start
 and stop
Date: Mon, 4 Sep 2017 13:18:39 +0100
Message-ID: <20170904121839.2hkk4anngjjo2ywl@sirena.org.uk>
References: <1502936685-24414-1-git-send-email-hl@rock-chips.com>
 <63c1d120-9c50-93ef-9ea0-be882ac8de1c@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujhwzci2zuiayqp3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63c1d120-9c50-93ef-9ea0-be882ac8de1c@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Lin Huang <hl@rock-chips.com>, "dgreif@chromium.org" <dgreif@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "briannorris@chromium.org" <briannorris@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "mka@chromium.org" <mka@chromium.org>, "dianders@chromium.org" <dianders@chromium.org>
List-Id: alsa-devel@alsa-project.org


--ujhwzci2zuiayqp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2017 at 12:03:21PM +0200, Arnaud Pouliquen wrote:

> > +static const struct snd_soc_dai_ops dmic_dai_ops = {
> > +	.trigger	= dmic_daiops_trigger,
> > +};

> should it be handle by trigger or DAPM?

DAPM is a bit better, yes.  I don't think it matters *overly* much in
this case where there's nothing else going on with the device, though
bypass use cases would need it.  OTOH it could mess up the timing.  I
was on the edge with this one but I decided that if it ends up making
a problem the binding is fine and the code can be sorted later.

--ujhwzci2zuiayqp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmtRJwACgkQJNaLcl1U
h9Ajkgf+M1xyDOyPCwKBu5lUwUswKUcw7n3If88zUrT7Q0LQxNWu2Ex9As1Ztekc
+tN/XY+kJsX/Sjen6QkycDWzY586vvicM/yOsWCFZBwqART719Z3fjTmTONTERBx
dTkVjpDx9u2sgdOwS+C7sfMvV2r2UFRurnblsgxC7rbis3EL0W3EjhEqmz/GRCEI
1kguQofZXA8AYl/vYzORnCk4hgn2294GZU+eDn6pFqB/rZDN8Vg+6XrhGnrQjyHI
p5/XFHzOAf9cZRgVnIktmd06acZWm5Q6AL9C0oWkUYqu+3dGIvgLqFlWYjDbXJhu
+E+x4TXo7pr0AwGeTzb1Ia5YDz1AqQ==
=nfeG
-----END PGP SIGNATURE-----

--ujhwzci2zuiayqp3--
