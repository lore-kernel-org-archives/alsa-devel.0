From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 2/7] ASoC: Intel: mrfld - Add DSP load
 and management
Date: Mon, 20 Oct 2014 21:37:30 +0530
Message-ID: <20141020160730.GH28745@intel.com>
References: <s5hy4seucfk.wl-tiwai@suse.de> <20141020054149.GC28745@intel.com>
 <20141020152900.GS18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5744891978166383745=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B05266AFD
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 18:45:24 +0200 (CEST)
In-Reply-To: <20141020152900.GS18557@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5744891978166383745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2014 at 04:29:00PM +0100, Mark Brown wrote:
> On Mon, Oct 20, 2014 at 11:11:49AM +0530, Vinod Koul wrote:
> > On Fri, Oct 17, 2014 at 02:07:43PM +0200, Takashi Iwai wrote:
>=20
> > > > > > I will work on moving memcpy32_toio to core and move users as w=
ell :)
>=20
> > And I did prepare RFC for that and had to trash it :(
>=20
> > Turns out we already have an API for this in kernel.
>=20
> > While adding the new header, though it should be io.h, stumbled upon not
> > much used __iowrite32_copy() which seems to be the API I need.
>=20
> > I am testing it as we speak, will send conversion patch today.
>=20
> Probably best to send patches for the MTD devices too while you're at
> it.
Yup, sent out few moments back.

Thanks
--=20
~Vinod

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJURTNCAAoJEHwUBw8lI4NHKKwP/ihD/D2Zu78J/oBWUGmg+M1Y
wsyKmWF6+MGa/GHOgyjqzyX1bFbizAgwWAKKg/SbCIDXR+3F/oxABWxf/7Ppu8iB
JlwcIrcaS/5QGf9M6yftWrr1RkcyIG9Ku8kIZ6GsYOBYP+yCXgYOhTOlct7grsZ4
+IHQGDROQiJWggXvJNomzhkSwkCFwfkdOm/Yim6h2lBM6gix7HAnu+3u4hOTMFrp
om5UXrVWZlOsW4IQth+Zvf6zHdnRzs8RxMPavfKVS3AvuWlfmNHxT7IUV19uW4WC
Zz+KimEEck7cZGsRJTH9tPHfOu4W/YKEBbAgwPp+JED1IKawBTnabnkeBO/a5gAx
18bpTgwphYdG9s8floCbK7bcqx2+FqOjb/znjsQhBR5CnnzS9ks9ZldbSkQeRSi3
uTt1akb9/TVZnqArrcFoiTOQr0ZZzpl0Kl8lw819cCFMsIOLonODVuERSz+dXOBX
PhjnJ+Sq8KBt4CcO28RyfycuhavHDvwHmXE8uJNOcXM9PWWzJu3RHj/PIomDNkyw
2NcXwjFWzPKNCulo5SkZqzQ4RuiSzZgnwdz/r7ndws3h3u11MpP7Q3s5wH6IM+RV
sS3q+l+lsuPrlmnRcgq3/fhPugL9poRY53+B8T9ZQXH+d/P8OBHaDaRpsi1uLvTG
BLYUfPxeXjWX+X5/0Hwx
=D0Q0
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============5744891978166383745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5744891978166383745==--
