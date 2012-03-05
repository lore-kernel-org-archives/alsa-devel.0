From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Mon, 5 Mar 2012 15:26:16 +0000
Message-ID: <20120305152616.GS3224@opensource.wolfsonmicro.com>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
	<20120304140939.GH3083@opensource.wolfsonmicro.com>
	<1330958882.4370.15.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1549390783122118026=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 286CC10400B
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 16:26:19 +0100 (CET)
In-Reply-To: <1330958882.4370.15.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1549390783122118026==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0M7E0x35R+W+EAky"
Content-Disposition: inline


--0M7E0x35R+W+EAky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 02:48:02PM +0000, Liam Girdwood wrote:

> A separate DAPM mutex and subclass (for init and PCM ops) would be
> required here but I'm fine with that too.=20

What's the path where init and PCM ops end up fighting with each other
for DAPM?  I can't think of one right now.

> I do also need the card mutex changes for Dynamic PCM though since we
> need to lock the card PCM operations for Dynamic PCM devices.

Yes, they do need to have something.

> Fwiw, looking at mutex holders in soc/codecs/ gives us :-
>=20
> grep -rn "mutex_lock(" sound/soc/codecs/

> sound/soc/codecs/twl6040.c:686:	mutex_lock(&priv->mutex);

> Some of which initially look like private mutexs.

Yes, we only really need to worry about the ones that are taking a
subsystem level mutex here - if they're locking a driver-local mutex
they shouldn't need to worry about what the subsystem does.

The twl6040 one looks like it doesn't work anyway as we're only taking
the lock at one point which is itself guaranteed to be called only from
one context.

--0M7E0x35R+W+EAky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVNsQAAoJEBus8iNuMP3dIMwQAI0BDmHJCPrdYRjYqHkGj0l2
wTSgjXFOIvb5dh8QDqHl7uq2X3NlkUArcdOB1G7mpwH5ZaQX6cHkv3HNR3DptswS
+e87AVq1rP55cYd8IYDkr+v3ttzNZhipfd+3xkRdlUBub+/9Hoi9DZopIh6AJn3R
WFVeWYlUpE5S/O2uMbIB4B8n6k65Na4bXr7wrVsEag5pWLyMACS0mgJWko7B6riY
ZflV763Dqw9G6SJibePSqZX1bELNjlT/wWK1FYrGh20Pk4L0SxkWf6Ji1PTGqQvb
I75j4IymoYPWbgNt+l81IOaPfKrBKbcmm2ulhz5+BZgKprLecmLuv62o4gJdDdJ3
Ry8cjL9H5gm34y1HTE1eZHItUKU0nfE3l48tp/l7C+04UySnEH2LQCvL3qnMDvna
i5zpb3QOwbEb/CONhnu/xnigfdAMOkw2/qXsGCJejsZsIMFoj5BupvoxgxV6EPRt
Z88wE50Xm35FoT/HNCnpF/wLYDFrmEueKSD4ItzcHYiiWGVn/uv/G24g5WE2ErUG
lV6bD9eiruogZB64DGfHaaUCxX+MkRH73Jyfze01zhypGoxI2AAs/Q3K+shRJ+fI
wJsb+h5h+m1DGXIUh8zEJgrYb8/na0vymNPZswMiqk9K+iiY6o/va9qNN4nCmmXe
tAzEN6Rki7v5uJPGwADv
=VNmZ
-----END PGP SIGNATURE-----

--0M7E0x35R+W+EAky--

--===============1549390783122118026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1549390783122118026==--
