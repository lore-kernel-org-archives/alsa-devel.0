From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Fri, 20 May 2016 12:01:37 +0100
Message-ID: <20160520110137.GJ8206@sirena.org.uk>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk> <573E80A7.50602@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2588958890546562099=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DAF26672D
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 13:01:46 +0200 (CEST)
In-Reply-To: <573E80A7.50602@nuvoton.com>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2588958890546562099==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 20, 2016 at 11:12:39AM +0800, John Hsu wrote:
> On 5/19/2016 1:05 AM, Mark Brown wrote:

> > > [PATCH] ASoC: nau8825: apply BIQ to reduce recording signal DC offset

> > This is hard to review since it's quite complex and doing things that
> > look like they might be using general purpose parts of the chip for
> > specialist purposes.

> We find there is a DC offset issue when recording. For the issue, it
> needs a HPF in ADC to reduce the offset, but no such hardware circuit.
> Thus, the driver configures the biquard filter as HPF when headset
> connected. It is a must setup for the codec. This patch sets the
> coefficients A1, A2, B0, B1, and B3 in the biquad filter to make the
> HPF funciton.

I understand what it's doing but obviously a biquad filter isn't
specialized for this function...

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPu5/AAoJECTWi3JdVIfQf+oH/2aaw8qNfP4LcNg5n/wmbLIR
V0hlr0NmZdrGwbdDUrYlsVlqXe+lYDV8JcM/Bp9SiuDwMQl3cDtvNkNIOxvfvt8V
FIdrVj7g0IgqWOXvgXmG7LUqJ6IjW9jL7RBypm2z1LN3/T+i/MnVdR1yhDbTWM6O
e3Kr0Sa6HE54hYOAWp4zMVsw1peOMLblCUDRSmHFDchG1W30ZgzDFVJ1C/jf10du
XGOS2JILeP0YNXUV1aMqn8Y98b/ITZM9bNZOAcv4oEjSM8DsUArgZUdkh1Bk3QMB
okj1Cad6Q9Ea/+L+HsG0SykDeuaFcQ9HfD8iVSpxwwa57SbG/vXzZTIwoyfafXk=
=QBzo
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--

--===============2588958890546562099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2588958890546562099==--
