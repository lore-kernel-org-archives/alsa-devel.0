From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Tue, 1 Dec 2015 12:27:47 +0000
Message-ID: <20151201122747.GG1929@sirena.org.uk>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
 <20151201025654.GJ3901@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7743282887589760080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D2E261A80
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:27:53 +0100 (CET)
In-Reply-To: <20151201025654.GJ3901@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7743282887589760080==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J1G63k6rHSyTx7zN"
Content-Disposition: inline


--J1G63k6rHSyTx7zN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2015 at 08:26:54AM +0530, Vinod Koul wrote:
> On Mon, Nov 30, 2015 at 04:25:48PM +0000, Mark Brown wrote:

> > Can we make the temporary hack be to check if there's a CODEC defined
> > in the DAI?  It's nasty and fragile but it keeps the hack much better
> > isolated.

> The flag added here, cpu_loopback would do that and keep this isolated from
> the rest. The problem with checking if codec is defined will be for dsp

No, it means that the drivers need to set the flag to work around the
core which is what I want to avoid.

> based loops which terminate in codec. It will not work as we will find codec
> in the dailink for the voice call (modem-dsp-codec) loop

I'm confused about the situation you're describing here.  The
connections are DAI to DAI so why would any CODEC behind the CPU DAI
have an impact?

--J1G63k6rHSyTx7zN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXZJCAAoJECTWi3JdVIfQnR4H/1AOHPvJatDI34iRaIfFqt3y
ZTfr9nZnl52UfilNTMcvfA01PuKJXKVcQ+7498+u1CUb2JtCXoGjmOWURMXuo2+b
igjf6DWzC7ZJbXZMjYiWimKWppFxo8gRmXy3bGpfROAUogZfT/Qt+PLEgR3LF1WL
JkNk6/tbzoVklMetUH13yU1gsuYSLX76tQD3ZXeNf+PjjwVLzWh1RKVXiDGoEgbJ
vXtb1olxuVlDqKIvj8bpfPDKWVNHM/sHfqAJd7cRWJPSsEJZyqDGTJkin9chTTGO
Z4gVkuC4H/bvnyHHuBM7wLoBTkHRAxZLNOjNEj07o7Jr8ImuIYOoXTXwi9Zjgb8=
=TaRa
-----END PGP SIGNATURE-----

--J1G63k6rHSyTx7zN--

--===============7743282887589760080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7743282887589760080==--
