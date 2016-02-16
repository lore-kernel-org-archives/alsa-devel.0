From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 10/15] ASoC: hdac_hdmi: Fix possible
 memory leak in hw_params
Date: Tue, 16 Feb 2016 08:28:31 +0530
Message-ID: <20160216025831.GP19598@localhost>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455243375-16067-11-git-send-email-subhransu.s.prusty@intel.com>
 <20160215205726.GF18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5823606365162133198=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E2279261501
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 03:54:44 +0100 (CET)
In-Reply-To: <20160215205726.GF18327@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5823606365162133198==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 08:57:26PM +0000, Mark Brown wrote:
> On Fri, Feb 12, 2016 at 07:46:10AM +0530, Subhransu S. Prusty wrote:
> > It's possible for hw_params to be called two times. So add NULL
> > check to prevent memory leak.
>=20
> Another fix?

Yes but can go in 4.6 as HDMI codec does not get created in 4.5 code. That
is why I didn't send this one in last fixes series

>=20
> > -	dd =3D kzalloc(sizeof(*dd), GFP_KERNEL);
> > -	if (!dd)
> > -		return -ENOMEM;
> > +	dd =3D (struct hdac_ext_dma_params *)
> > +		snd_soc_dai_get_dma_data(dai, substream);
>=20
> If you need to cast away from void * that suggests a problem and it'd
> look a lot neater too.

I suspect there is no need for cast, we seem to ahve a habit for that, let
us check that

--=20
~Vinod

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwpBXAAoJEHwUBw8lI4NHVAoP/1e43CKihII9Z+7crxutK1tx
xFK7AK9QDdUnQGId3t4sF/FuzjTxVWsjQ3k7BVlOV2RxBEgXsmr9a6N+Nx3D//DQ
V1WeEzEZzHk+NnDc8hWjAwEgdhvjFUNtSvnayx5MNNxBcnqchAE0oHktMw9CUVjw
O8wVd+ojL6FksZegP7kRhkmnqp17OWrh10oIKeb86bhaA8LIltYvGQOgnRIW9oNx
ynIuT6vTKOBocya4g4VcJOTvh4QZIVm+HBzZzMH3fiFpeQjslyQLo0aBojkhNvRg
ffHHqFqKB4CM8U7qh4PUFne/OxnTQZrr39UPnq9PUtVPwqIROkG4npw2wHxn6spq
XDlF/jt1DdyK1uEZuGLM9Zq983WQ3NkTc0qdQODE233tK4tVXdGnI/3+eQr/rjjB
ybZNFPRyR3iR+cPK2U1L4MyXxJ88uO4gCSQVkyNPOBdPcnX72TXkHWN4CCfay/82
F/la69XEpIA+eX15gt3iUbHbdUaKJm/aMTfCJTfHkq0ls8InZR4sPVg0tRqjRg0/
HrjD1pvmsCyt7YdSuXQQocVCEKVLYIm5NXbxyLEA1mAgvGJC1nNwbvB4u4Rk6s4z
iqikyMs/O8RmG2o21C+/eRue0blyvjP3asYUgIN6HpfKynVXsQFCUtZQR7/yKKVG
XagwSjJ6fWrfBUx1zAHH
=Kjgv
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============5823606365162133198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5823606365162133198==--
