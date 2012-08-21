From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 15:12:36 +0100
Message-ID: <20120821141236.GL7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de>
 <20120821135947.GB21557@sirena.org.uk>
 <s5hwr0s1gnr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0095342749430320710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7B06265F8E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:12:36 +0200 (CEST)
In-Reply-To: <s5hwr0s1gnr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0095342749430320710==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 04:08:40PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Currently only named channel maps are supported.  It'd be nice to also
> > support just plain numbered channels, or at least provide a way to say
> > to userspace that it needs to do something like chase through a routing
> > map to figure out where each channel goes (as opposed to assuming that
> > the driver doesn't know what to report). =20

> The channel map value are basically arbitrary 32bit integer, so we can
> define something like:
> 	#define SND_CHMAP_NUMBERED	0x10000
> and pass the channel number with this bit flag.
> Then it becomes a matter of definition of chmap values.

Yes, I think something like this where we've got the map values split
into a type and a value would address things simply.

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM5dMAAoJEFJkBDiqVpZ4pjMP/0D4iScYqoHU6b+td/DQOY40
liCBbAbDkhyKTdvJpGkZ+us7bIVjzoyKBS9X1KxSdKXAv3f7EeGgidHyJ7YwBlcU
VCQomvWhw54squiMMlACTo0f9in5TC58QESqVcEhBVtj4t3bN/PMP20F0TB0bhtD
K+Pbd6gqBVIMYZFQZuq4G0TYt7bx9lDwi4nsNe4VMF/pXENyZt2xCnoDq2tjuszb
ptikni1UQr/giYhbaAj9/UDci+4Ozi7d8sTGVRaUSncw0Sj0uKoANqsH9koIOcbR
w3vmOPQsHct8Fj9nuZ9YjsoM9E8K6AodfPXZGgfywVc9EK9PmNX0YFsZWbC/avfP
U/1FtLIHS9FlBUkxycB3ZzHha4n76qLsqKYXXn669T0mPrwbjUZR7JIS+hu2nJ9w
HhimVs+BGITsxA4xsWih580cnYBvA7VMTXcr3aJQosknWe/G4csRhYSPAnmZBQzU
Yt82rdQsWYnJcv/3MsSmrY5k5PYKe/V9DbH9x7pdlKMOueEdKnQMRwxnx8dsHXh/
r3dvLfLuLgkGkUQxC5rKGoHxykSioMaxjrX2UHamokminDfmJZUHy/BA5obME9qg
6UAc/K8RnPzrD5EcTMJdne2TpjmYjrX7LAN6goi4c65nXLEw4gDL8F2ZZZlcUZvm
u9t7dn0+X47+nrLBq2OD
=G4In
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--

--===============0095342749430320710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0095342749430320710==--
