From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/9] ASoC: hda: Add helper to read/write to
	dsp mmio space
Date: Mon, 27 Apr 2015 22:02:02 +0100
Message-ID: <20150427210202.GP22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
 <20150420214638.GX14892@sirena.org.uk>
 <20150422035014.GD2738@intel.com>
 <20150424173331.GY22845@sirena.org.uk>
 <20150426143452.GW2738@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2887038790759193244=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4FF0260547
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 23:02:06 +0200 (CEST)
In-Reply-To: <20150426143452.GW2738@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2887038790759193244==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="74sDuBlr11nCUhb5"
Content-Disposition: inline


--74sDuBlr11nCUhb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2015 at 08:04:52PM +0530, Vinod Koul wrote:
> On Fri, Apr 24, 2015 at 06:33:31PM +0100, Mark Brown wrote:

> > Seems like we could use the block I/O stuff in regmap for that?

> Yes we could, but not sure if we really benefit from using regmap here.=
=20

I'd look at it the other way around - what would it cost you given that
you're implementing regmap like wrappers already?  You do get all the
debugging features if you use it...

--74sDuBlr11nCUhb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPqPJAAoJECTWi3JdVIfQ00oIAIZ97ROGk/N6bbZDGDkAJvnL
SM+XAhdfSpJWhNoKf5BgJMG8xv+Hxx+FHnZtRghMNDKTUQQblo4npLDfzN7NNrjl
BfTwfIeZ0Qm2UZVsVv7XcDy3Yp+4kh9Sy5VC6WLEyarzGjV+Lj38OnByw7D2wTPx
+bIGPDhYT6uSsPfYuJW+qM2txlVJ3u7RDtETqSd+BUEoo7y0in8OX1TtH0kDzS5O
XhSwA5IoAFnSr9aZCcTXK07TXlDpqsfCqiSa/5zzkRRaqYS0m2InrG2gkrmHl+OR
z2bnQn0WhxvJ6VmONbKnDue/1X2PpmmdJYOSqitoTW+d1mnnQdcORlVtdAc4XLo=
=HgMp
-----END PGP SIGNATURE-----

--74sDuBlr11nCUhb5--

--===============2887038790759193244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2887038790759193244==--
