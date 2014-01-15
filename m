From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Change prototype of soc_widget_read
Date: Wed, 15 Jan 2014 11:44:35 +0000
Message-ID: <20140115114435.GH15567@sirena.org.uk>
References: <1389742314-20125-1-git-send-email-aruns@nvidia.com>
 <1389742314-20125-2-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G1IH56i3DES2a+WZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389742314-20125-2-git-send-email-aruns@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--G1IH56i3DES2a+WZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 03:31:54PM -0800, Arun Shamanna Lakshmi wrote:
> soc_widget_read API returns the register data and it is possible
> that a register can contain 0xffffffff. Thus, change the prototype
> of soc_widget_read to return only the error code and pass the reg
> data through pointer argument.

Applied, thanks.  Don't send cover letters for single patches, if there
is anything extra in there put it in the changelog or after the --- but
otherwise it's just an extra mail to read.

--G1IH56i3DES2a+WZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1nSgAAoJELSic+t+oim9tewP/3bZ+4Nn+DO69bR/iB8Voo7h
F5Lg8GCa4UO70rdYep5WOgOyXpKm0RbeND+wqyuTpng7v9ZfN9mAAz9SbTzRAUpr
K9C3Q6H8ONEVQNLHcbXGLORCUQrPC5Sd4opsl0STNI0hzsLsVbcjxtL/N9A7605m
AkE2O+P2cu9tGccJQgTW5hsQE13zLiFstPT23WdqnoDCmbjxnTui4biBk4siuQOy
7Ax6lJ2FIGUBFow/FlU25j8tYefUB+W7yClXYPya5Ea42INA6aO7iwXav9HyOsMB
wtLKgK9JrID9vZJmUT5emchyi5QqTIgbdS2D/RYAfP+i0d6eWPk18idqUIk+ec+0
JEMgSoH5QtwZfgwpWl+T9EWi+dkVJg7FvRZCSkWLOJEQ19NiYK7gGOfehqzenaKr
kKsMyA3gMPQgKOwM02QNxCwk+B7aF9NN40J6m52JJNiIR/hZlP0h7xzpk5wJox7f
6JnJsGVSrAAcM3ySbXLteSZfT0qSqUnxxYkBNB4BqWnJxRyyqwKZf3usjaSVj5dt
/1uh+RetWIXAtvXZxIaP7r1HpvTaCF+hFSpZ0cBrB9YSXLQsasGtuoh6mA60AXjj
ou7zK7693ngh9QCmNfDiWXR755zL+Iwrx916yH3DW/MY8gd+onIkqxx9/kie3i+H
jeCryzjbF2MAJQqIiMSN
=YIVh
-----END PGP SIGNATURE-----

--G1IH56i3DES2a+WZ--
