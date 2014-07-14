From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: tas2552: Support TI TAS2552
	Amplifier
Date: Mon, 14 Jul 2014 20:17:11 +0100
Message-ID: <20140714191711.GI6800@sirena.org.uk>
References: <1405093489-11897-1-git-send-email-dmurphy@ti.com>
 <20140714184321.GW6800@sirena.org.uk>
 <00FC9A978A94B7418C33AFAE8A35ED49D80B10@DFLE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4206703550393951933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97EF6261B02
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 21:17:27 +0200 (CEST)
In-Reply-To: <00FC9A978A94B7418C33AFAE8A35ED49D80B10@DFLE09.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Murphy, Dan" <dmurphy@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============4206703550393951933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJFFgG5QZHt5jcrP"
Content-Disposition: inline


--aJFFgG5QZHt5jcrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2014 at 07:07:06PM +0000, Murphy, Dan wrote:
> On 07/14/2014 01:43 PM, Mark Brown wrote:

> >> +config SND_SOC_TAS2552
> >> +	tristate "Texas Instruments TAS2552 Mono Audio amplifier"
> >> +	depends on I2C
> >> +
> >>  endmenu

> > Keep this and Makefile sorted - since this is a proper CODEC driver it
> > should be in with the CODECs and also sorted in alphabetical order.

> OK.  I was trying to stay away from a conflict by adding to the
> bottom of the file.

The whole point is to avoid conflicts - if everyone adds at the bottom
of the file any two adds are pretty much guaranteed to conflict either
on application or on merge.  Sorting avoids most of these and makes any
that do occur much clearer.

--aJFFgG5QZHt5jcrP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxCy0AAoJELSic+t+oim9ZC0P/0xXUNawujyd33X24/UV5qSp
aloiKAIzyiIrQyCudGVQT541+Kida3csZi8U+xGD5AGrxohCR44sFdcZKfmSeIWH
C1rJcmMdTrfv3GaPgUYJ5Vlq7UK25C76JjZ0x0VIuG2Tnaz7tbIPawdbV4ResHEq
YWi1GKgqY59tGI8KQGM2vpg8LPa7n+MUQEA6XkBMTmqX6u631XWpHzo1h0UpcZvH
ro48VsVg1wrUXixlQozPw8wyfJDvs72L/avOqx8XmeSVuIGNAHQNisBaCE1yPzhH
reaYLPafKra3Eb/8gBuCUqSsqgOwKElfCsZVU8qoCU+yX4rsPBo1f+idgWdp+ASZ
biy2NyNhnTqP8hLa+iNjArxHR+axUSPQvlXMpJz6GHBDK3+SIRkrcSTLzGo4EQ5w
5OLGfxllX1u51YnjGhf5yVoXeXee4oNftPWVxrsslWSfOehAdZ5yj9W/nskweiA+
xWz6EGMmq3tbHXExh7ZXjeAVlfoJmCRkOBEt8/EhQUtCbH2JEICQeXFtVROOwP1r
/rDNp/nfsl4mERZjQu0/kmAXA5VoL9K+3fBRpSybSAii3B8fpy3DinwVcIc2v0nc
+4m7TNfzfcFJ/tqLr5DKK5iPNaqNqUAY/cJcCG2UvG3ZD7r3wvJR8GO641or3KKB
i3XvoKw4thb1TRR2GB3F
=g9z5
-----END PGP SIGNATURE-----

--aJFFgG5QZHt5jcrP--

--===============4206703550393951933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4206703550393951933==--
