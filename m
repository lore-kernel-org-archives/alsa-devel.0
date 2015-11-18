From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
	loopback dai_link
Date: Wed, 18 Nov 2015 13:17:57 +0000
Message-ID: <20151118131757.GI31303@sirena.org.uk>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5232632847376297090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C54C4260A5D
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:18:03 +0100 (CET)
In-Reply-To: <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
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


--===============5232632847376297090==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dQAkT9kf8uI42z2+"
Content-Disposition: inline


--dQAkT9kf8uI42z2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2015 at 11:19:59PM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> soc_link_dai_widgets() creates codec-codec loopback link which
> allows DPCM to trigger these links and program the parameters for
> these links These links are:
>=20
> 	Codec1 Tx (Pb)  ----------> Rx Codec2 (Cap)
> 	Codec2 Tx (Cap) <---------- Tx Codec1 (Pb)
>=20
> But as we try to model a CPU based loops for non host links like
> modem to codec loop, the above mapping gets wrong as:
>=20
> 	CPU Tx (Pb)  -----------> Codec Tx (Pb)
> 	CPU Rx (Cap) <----------- Codec Rx (Cap)
>=20
> So we add a new flag to handle above scenario and link widgets as
> depecited above

So, what I was really thinking of with the renaming was a bigger rename
that updates the names in snd_soc_dai_driver and everything that comes
=66rom that.  That's a much bigger thing though, let me think about it a
bit more.

--dQAkT9kf8uI42z2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTHqFAAoJECTWi3JdVIfQKhIH/RZSLTLeTxk2HJD54Pmt+JT9
GyZ+1eq8Nqzr7klBhbs8ncSsUCqapbQKZOwoq5dFZ0I7+VHh7ZDNgQhnn26zKoYn
8v7MxGah6Gdc2ZNXgnkN+1gUIMqYOhHg3/1EOX6Sr2M0oeXyAJ82EPCEwe08XzER
nFTGDrkrAoLBfojmzCQwa7sqdYsD02wTO9Df4WTHfRmTWz3oSW3k1wDVZe8FnNRw
0CVh+PqOPkGlW84HYat5jrCXfabB/XRCiwV7k/cnFmpqIBZxulC73WF3kfuUtD8U
Nk07j/QP9bMz3cbLrx1+sUselpQaHsKt/nFLDMdXYBLvaibeaSuLAwne+7RMfRE=
=DHrT
-----END PGP SIGNATURE-----

--dQAkT9kf8uI42z2+--

--===============5232632847376297090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5232632847376297090==--
