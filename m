From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 05/14] ASoC: hdac_hdmi: Apply
	constraints based on ELD
Date: Thu, 14 Jan 2016 14:21:32 +0530
Message-ID: <20160114085132.GN11130@localhost>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-5-git-send-email-subhransu.s.prusty@intel.com>
 <20160108140933.GT6588@sirena.org.uk>
 <s5hfuy8dt5o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1214985374900232686=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 577492604EF
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 09:47:54 +0100 (CET)
In-Reply-To: <s5hfuy8dt5o.wl-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1214985374900232686==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 03:48:03PM +0100, Takashi Iwai wrote:
> On Fri, 08 Jan 2016 15:09:33 +0100,
> Mark Brown wrote:
> >=20
> > On Wed, Dec 09, 2015 at 09:46:12PM +0530, Subhransu S. Prusty wrote:
> >=20
> > > +static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runti=
me,
> > > +						void *eld)
> > > +{
> > > +	u64 formats =3D SNDRV_PCM_FMTBIT_S16;
> > > +	int i;
> > > +	const u8 *sad, *eld_buf =3D eld;
> > > +
> > > +	sad =3D drm_eld_sad(eld_buf);
> > > +	if (!sad)
> > > +		goto format_constraint;
> > > +
> > > +	for (i =3D drm_eld_sad_count(eld_buf); i > 0; i--, sad +=3D 3) {
> > > +		if (sad_format(sad) =3D=3D 1) { /* AUDIO_CODING_TYPE_LPCM */
> >=20
> > 	switch (sad_format(sad))  {
> > 	case AUDIO_CODING_TYPE_LPCM:
> >=20
> > > +
> > > +			/* 20 bit and 24 bit */
> > > +			if (sad_sample_bits_lpcm(sad) & 0x6)
> > > +				formats |=3D SNDRV_PCM_FMTBIT_S32;
> > > +		}
> > > +	}
> >=20
> > I really don't have a clear idea what the above is supposed to do or why
> > this is specific to HDAC and not handled...
> >=20
> > > -	return 0;
> > > +	return snd_pcm_hw_constraint_eld(substream->runtime,
> > > +				dai_map->pin->eld.eld_buffer);
> >=20
> >=20
> > ...here.
>=20
>=20
> The PCM format cannot be determined uniquely as it depends on the
> container type and endianness.  So this can't be implemented in a
> generic helper.

Hi Mark,

Initially we did start out by adding these in common code (v1) and per
Takashi's feedback we moved this back to driver.

Please let us know if you are fine with approach

Thanks
--=20
~Vinod

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWl2GUAAoJEHwUBw8lI4NHRGQP/iPNlSXQqsa087Ecv1Ry4EVM
BY4E/sQeB1pxdGnOJ5NFBRQU+VRSI+I4sk/YCDcTcOnYwldYjNR9u8Ob9i/+IH3W
a6HicXxOgORc1J0oxBTKomE1CMiUP1c1JD3VaEitNIP4NJrcCcsQOLTeDYZg5PoB
RsqIeT+jQe80dFVhw/+oHqxwe12SU6Ut+DFC2Lec4o8hEPWQYOKtn350BUe6zuHb
5SorFBKsmG0DxHbMZ/jHDrvmKw66xp5aUmfpo/xZvkEodeaRX7Dd25gMZbdGmBi5
Lg6q+t7vP6rh41vWRm5tzqvMnCiXnZ6AlS6Av2KNlCq4zA4yxmZ3NU5jdU3fARl6
9/LacgTpnSaqZv/FnXl+YDSlKTtz67RcFgi2SV4peg7x+ZtgCbPHeW3CX0o/jjsp
jPciSt+EEEl3CcMy23mhFZHvN6JgQJWrLHmqQqT0fpezADRWhkZ/7Yrm6P/UwVBC
/quswHMNIuJHWmlBcoEypdwBqMpqQbdJhj6y3hUxBqI0CCwXRDZWaQwqjUmio0Ni
jriRBwfiGS2lIUOseSeUhI63mc2NvhY12TxRRK0/zNwURzwZwpn8+DN+chIjeZ06
LTLbnWQSAsMg2tR6uKl7bmiH/3Je3nZp4cx9tRj6HiQzcBZXsmZQXQXdN8ZMNhEu
GIo/T3BZwoB1z2+5pL9B
=Wxgv
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============1214985374900232686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1214985374900232686==--
