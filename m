From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: disable sinc filter for
	high THD of ADC
Date: Mon, 5 Dec 2016 11:50:09 +0000
Message-ID: <20161205115009.ri5qpgzlfszumvo7@sirena.org.uk>
References: <1480643338-9423-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4506005244624678816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4129B2668C0
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 12:50:17 +0100 (CET)
In-Reply-To: <1480643338-9423-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4506005244624678816==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="msm4emquga2blywh"
Content-Disposition: inline


--msm4emquga2blywh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 09:48:58AM +0800, John Hsu wrote:

> This bit will enable 4th order SINC filter. =20
> =3D1, filter will enable;  but it consumes higher power.
> =3D0, the sinc filter is disable, and it should always keep 0 value to
> get high THD.

> Therefor, disable the filter when codec initiation for better
> performance when recording.

This looks like something that users should be able to control at
runtime - while some users are going to prefer lower power there will
most likely also be some users who prefer the better performance (or
perhaps even users who switch depending on if they're running on battery
or something).

--msm4emquga2blywh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhFVHAACgkQJNaLcl1U
h9Dm1wf+Mxg+9qMcRcjAC+auKgYJ6AbnDTuJOx/K4ydOadT7r4qznGHugCXuq1lC
36CDRvA3VS57HEMOmgyZSpz2eeNktf4RtjjHxw9hVmJ/y9ZBNnXYQJcA/QjFFhbL
VJiKUx8FGVQ2PYWdR6jgjEnnJxTrNh1fXi2UWWL1GfmW8CV1EtkL9+Ank0mwKS1k
IFQuoGZFxMZvS/wdjVw4BWsTuJc6kBEylmLhH4Bu8AZNRrqp+ueH1OhEg+wGKpXZ
MStjdZjKK/D/GyLpesYTkwpiWpVL0syWUnvHr24GCVe/5YnGHmA0wenFN4UvYBrd
gXXVV5YKAd/b91rxDz0Gl4xm0PKuNw==
=8BYu
-----END PGP SIGNATURE-----

--msm4emquga2blywh--

--===============4506005244624678816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4506005244624678816==--
