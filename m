From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 3 Jul 2014 12:09:46 +0530
Message-ID: <20140703063946.GJ2296@intel.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <20140701164134.GH2296@intel.com>
 <20140701174117.GD15028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6854227997239190978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B8CA265825
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 08:41:09 +0200 (CEST)
In-Reply-To: <20140701174117.GD15028@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, misael.lopez@ti.com, Benoit Cousson <bcousson@baylibre.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6854227997239190978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2014 at 06:41:17PM +0100, Mark Brown wrote:
> On Tue, Jul 01, 2014 at 10:11:34PM +0530, Vinod Koul wrote:
> > On Tue, Jul 01, 2014 at 09:47:59AM +0200, Benoit Cousson wrote:
>=20
> > > +	for (i =3D 0; i < rtd->num_codecs; i++) {
> > > +		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
> > > +
> > > +		switch (cmd) {
> > > +		case SNDRV_PCM_TRIGGER_START:
> > > +			snd_soc_dai_digital_mute(codec_dai, 0,
> > > +						 cstream->direction);
> > > +			break;
> > > +		case SNDRV_PCM_TRIGGER_STOP:
> > > +			snd_soc_dai_digital_mute(codec_dai, 1,
> > > +						 cstream->direction);
>=20
> > Wouldnt it make sense to fix snd_soc_dai_digital_mute() for multi-codec=
s. Did
> > you do same thing for pcm?
>=20
> Yes, the other callers also iterate through all the CODECs.  It might be
> sensible to have a wrapper which does the iteration but I do think it's
> reasonable for _dai_digital_mute() to just operate on one DAI.
Yes that sounds okay as well

--=20
~Vinod

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTtPqyAAoJEHwUBw8lI4NHpcQP/2Z+pwilOCxrHi4XkqS2s70X
7JptyTKRt8AM2F1Y5jsmEIUrp6hu0+iIbA0TPeCPH+DRAXgStg1P2eY5pAJFFpUo
6JEriNoBdE/nchXKNg28UY2htOLbwkZ6ZPll4KfEFFG3ruVTpRH6jdFcmEY6u/k/
sFVFHUc4wUz3HO+lQWdBcErVIhJWGFZ3n7ofFGPPZrDsebRIIdbkU8cscN5YHaBV
3LIMz0sSDXXSRHov4IK1cbekG84GIc5WLMP2nvmhyiCUn0rySowte2B4W9RIrjhT
Fb1AXqtclrXGRtlcNZ83s+x15A82RCzgLQIo6OPS2tf8dPLGr6Yu6DDPJoG46Ya6
RX1Y2WQSGDcATL63YTEIB/jYfcHd5Aciqxiu594XX+4Mmqo9Ezg922l+2FgVfhk3
xudMGLYmXEqt3AcuDIMpc171XY9O53TujN6mSbkNjPh1g0wCiz/9jBC+R8ofLVr5
0+49oR1VY8VH5Llgq8iTD94CCzHfm3+4FrbNjhPrvw2dwA9qt3to3FT40FaiWzZG
DBX/d0VtzxD5pkHGcLvkBIt3miCGDG1FNk0g2g16sX7hFN7qswN3rSQeUKY2vna1
C6hEqnE7JyvHIHq7jmj3xuzzmQvm0z4gYkQbiW9aFMuV1unGJn0/7ZDNi56omWl1
PX3JhUMAa9/tgBX7xMMa
=uBig
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--===============6854227997239190978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6854227997239190978==--
