From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: simple card: set cpu-dai sysclk
	with mclk-fs
Date: Fri, 12 Jun 2015 12:40:53 +0100
Message-ID: <20150612114053.GN1921@sirena.org.uk>
References: <1433492346-29506-1-git-send-email-arnaud.pouliquen@st.com>
 <1433492346-29506-3-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0719643891713410856=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD8A226680E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 13:41:23 +0200 (CEST)
In-Reply-To: <1433492346-29506-3-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0719643891713410856==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Content-Disposition: inline


--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 10:19:06AM +0200, Arnaud Pouliquen wrote:
> Allows to request a specific mclk frequency per cpu_dai.
> To support some codecs with mclk provided by the cpu_dai, the
> mclk rate must be set depending on frame rate.

I'm going to hold off on this one till after the merge window since we
are very near to that I worry that the behaviour change for CPU DAIs may
trigger problems, I'd appreciate test reports from other users.

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVesVEAAoJECTWi3JdVIfQ++oH/1HkqE5nIqgGTRlbUmdkhN0O
GYnQeZ/xX73wAXpfP1r5gnB43mnZrIUq3ouGHgSEO7bid/IKaTaA/tht5eJxWZKg
Mn7r8PpiFqxGdl/oJcBrJLlBzVbXpmRF0pVi21MDeJdotVasoRxXPYNOPCpKasis
u6ITksDx1AZra9B69kCYgVDSBtS9ZbN/60j8MmTc2JLEa+lwggXkVdVOcauwrsgx
VaZxSdVxylCRHQrWg7adPs8n/d0TMNCykjkTSOzuYvTmjyB1OTIzPQ3OFD3bjfnd
3p/8P5xM9nbEmU/gsZwfvJnmFek0OSlK7GRo/h7tKxKczYOdBvb2sPefBTeElnc=
=U15T
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--

--===============0719643891713410856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0719643891713410856==--
