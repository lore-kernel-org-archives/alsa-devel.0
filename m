From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 2/9] ASoC: hda: Add IPC library for SKL
	platform
Date: Sun, 26 Apr 2015 20:06:04 +0530
Message-ID: <20150426143604.GX2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-3-git-send-email-vinod.koul@intel.com>
 <20150420215639.GY14892@sirena.org.uk>
 <20150422035453.GE2738@intel.com>
 <20150424173427.GZ22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3679057355240577325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B63D62606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:38:52 +0200 (CEST)
In-Reply-To: <20150424173427.GZ22845@sirena.org.uk>
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


--===============3679057355240577325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tzZdJ4yHDV5r1Akt"
Content-Disposition: inline


--tzZdJ4yHDV5r1Akt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:34:27PM +0100, Mark Brown wrote:
> On Wed, Apr 22, 2015 at 09:24:53AM +0530, Vinod Koul wrote:
> > On Mon, Apr 20, 2015 at 10:56:39PM +0100, Mark Brown wrote:
>=20
> > > More prints perhaps?  _PHRASE_DETECTED looks interesting, as does
> > > _OVERRUN.
>=20
> > Overrun is FW detectiong its pipelines are overunning the buffer, no the
> > ALSA ring buffer though. _PHRASE_DETECTED is for keyword detection whic=
h can
> > run on dsp
>=20
> Sure, it was fairly clear what the messages were for - it was more that
> they seemed like things we'd want to do more with than just ignore.
Oh yes, that will be added after base driver is upstreamed. So I will remove
as these are unused atm, and adding them when used makes more sense :)

--=20
~Vinod

--tzZdJ4yHDV5r1Akt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPfUAAoJEHwUBw8lI4NH130P/iv5uSz/LCz9yocS97HxGO3/
6Gsql3y55SwfbaxvqFF0L2O3L9hC4kzQxvMiComCpWnbRQHc+G2j2CvUaCsaiRb9
MOyTwd7dSWZHQes0d4YuDlRazLmETtOKyPtyo5NNMZRdxTnZpSuU9MavZ0QtKc4e
ghCbwD9cjSlEoN3dBO2IEIHbyhKU8joDuQ2LobUJ4fbVDMQKBoXv73NCYx8tTRQP
vq0pD4Y2sk9sNyPzLFQLmBl8laYsoWikO1Xcu0vokjKMnKgEW9K+rmCmwAvPalXH
ZlLl5Syb69jC8vNeTDl5Jv344BerQKPdHRo2fzKEn4cBy87JslKRPtxp0vVfpi6r
mseP4/tPhESlcttyrZ/6xw3lL07l+ci22/F+3rxI6SGjRtvhm98/yl8HaxbAxMhG
OLwkL7hmY5N97uv4cT73rBtSGJa09Wl312cXf1+pVvLyHlg36tAuhuYjXBm1avDA
JgzTvKIMijQqUpB/WIOICjY8fxXqMlFMGq/LMEQ/g6vH8CQ1yeeb0Ur7GjgynJPv
X08ML/Zw489Lp4eZ5tMp8hkjqEvu7/ChxT1NLZzKhVh+r5BVpqdqpiyRoh4X1mD7
KMmAzjdOt/iAlGH51XOBb1YvgEkZX0DaJ6X8XTuKPWQu1oqfZO953CXiNdbx9Fwc
wdiiMWvOymRJG6o/TB4F
=T3e2
-----END PGP SIGNATURE-----

--tzZdJ4yHDV5r1Akt--

--===============3679057355240577325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3679057355240577325==--
