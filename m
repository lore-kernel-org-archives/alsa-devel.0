From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 1/9] ASoC: hda: Add helper to read/write to
	dsp mmio space
Date: Sun, 26 Apr 2015 20:04:52 +0530
Message-ID: <20150426143452.GW2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
 <20150420214638.GX14892@sirena.org.uk>
 <20150422035014.GD2738@intel.com>
 <20150424173331.GY22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3224439342871961156=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F75C2606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:37:41 +0200 (CEST)
In-Reply-To: <20150424173331.GY22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3224439342871961156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhKpTYimqQF2+bfE"
Content-Disposition: inline


--FhKpTYimqQF2+bfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:33:31PM +0100, Mark Brown wrote:
> On Wed, Apr 22, 2015 at 09:20:14AM +0530, Vinod Koul wrote:
> > On Mon, Apr 20, 2015 at 10:46:38PM +0100, Mark Brown wrote:
>=20
> > > Much of this looks like a MMIO regmap, there's the memcpy() bits too
> > > which aren't but otherwise...
>=20
> > Yes they are. memcpy bits are to copy the IPC mailbox payload data to a=
DSP
> > RAM which can range from few bytes to couple of KBs
>=20
> Seems like we could use the block I/O stuff in regmap for that?
Yes we could, but not sure if we really benefit from using regmap here.=20

--=20
~Vinod

--FhKpTYimqQF2+bfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPeMAAoJEHwUBw8lI4NHkUgQAMTcR/CLTRT2UuYb4+U93/DV
LKzk3hrUFFS/tss3Syn+PwbQ/Gj0DN/i9YXIULtJ49lm1doo2ZfIRTXTEAjV5MHK
70kM2E9Gu5QEp5DkPvBrPSaRjdbhtX89m6zT5pqzqKTfN0xT0wdGESvfllYWwqwF
6N7x2FjoZTI2OnmU8T4zF+aw8P+v9IXyhyvwMMyDs87n20m2NxXlee51WOUksnQw
xUwiGbDBAOvWVUR2Uw/Gz41L/or2XObFJeXP7trat5PTpKdwr664JHFO8mKXypcU
Y6kN22o1uh36417dX1p9BQgDTluxaEGikIhggMep09RvjiVg8cxh+rAZOQZqNMaw
a6DSYMjs6LWTdvLDOC/Md+0310YGXaP+7CInv2b07lh5rwHoR7bxyCKWm5qZipi2
vrfeQgfc1HkZKC1XRrqtG4MIcjuGkAJFJkdlz8UoNLNrYxAURI8oNg0BKyphxHtN
cE/vcA0mMcYJrsblZ32F2QYCMAfkuUfIX3DgOeULLHYK3+Y4XazvKa8BSXtBa3kK
7nVzc4H8Xiouq6LewtGzZPFdFPJGBu5LcGkz2QrEqb9zVA0U9JW5cgCHokHuSRFq
tqd5feJxErmQl8oi1oP1gfADA1pDTrgCoqG0ap0HV5v22qusHaMqCaVLrIZ8yii0
A6bEr1/54YhwHaCg5VJC
=OSXa
-----END PGP SIGNATURE-----

--FhKpTYimqQF2+bfE--

--===============3224439342871961156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3224439342871961156==--
