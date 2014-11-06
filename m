From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 6/6] ASoC: Intel: Add Merrifield machine
	driver
Date: Thu, 6 Nov 2014 18:48:35 +0530
Message-ID: <20141106131835.GE1870@intel.com>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-7-git-send-email-vinod.koul@intel.com>
 <20141106125119.GD8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4961268371037844465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D4C5326520A
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 14:17:51 +0100 (CET)
In-Reply-To: <20141106125119.GD8509@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4961268371037844465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:51:19PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2014 at 04:25:20PM +0530, Vinod Koul wrote:
>=20
> > +static int mrfld_wm8958_set_clk(struct snd_soc_dai *codec_dai)
> > +{
> > +	int ret =3D 0;
> > +	struct snd_soc_card *card =3D codec_dai->card;
> > +
> > +	ret =3D snd_soc_dai_set_tdm_slot(codec_dai, 0xf0, 0xf0, 4, 24);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "can't set codec pcm format %d\n", ret);
> > +		return ret;
> > +	}
>=20
> We already set this on init - why do we need to set it each time here
> too?
It is not required, will remove.

--
~Vinod=20

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIbBAEBAgAGBQJUW3UrAAoJEHwUBw8lI4NHQP0P9j1UAQDVt5XP2jPK5uQT1BAS
qcvmaNENu3roADR/7wPuZbNn+k8jYBTdwXmRa+ACWq/vToqUcQL7jyneCEzDozhW
/ri+FHjiCan9r42Ul+VEBVnyCo/Mca3fmFnyZc8sctpNpvURNpRekhgCsej8icHP
19BBm0qZZwhRi8MQFz1wVsojG4/miB4nnfgGCqpM5y/aVqAhS+AWcK5fvce9vjx5
pSRgN6XpTQvijlaHLuA8qNU1bd3fMFOQz9nXn3kepyZNoOgtr3mjpC67i6Ndtoct
iCZW3tZGhlT7/KuafOXcbqNVuaHp2k7Iw4slg1nYNsDq0g0yuMO8+OITZD8dLQC8
mUDk+88e3K5Lku9fEwsKZWZvSFOhnxgtQfeS2BrVU8suZAOD3zfYcqJA5rdrnpeH
EXndlQEmnpeaMEB9n0CgQ5LGU+PIHQi+lwfTBNxWhWAzyMxYKkJ2iR0hgKqFvP38
TtZj/HMSdrZh7CigSMG9U/c4K3GETz4txwgSEIxbznIQUgzEkRn1CB1dOEshJmZ6
xOETXd4Y5itsCPh+m0REZH3vD1j5IuyUD51wnpz+LwZwkyr1OPga20nYMxh5YEaF
p0QFSh6V5VpifrHyvaiOtqsndQvrTxhWvIPgyO3jKG7Tc8FrqrOxokF4Tbfyi5IT
tu+uo3/X1cp92r0Mrms=
=HCq4
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--

--===============4961268371037844465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4961268371037844465==--
