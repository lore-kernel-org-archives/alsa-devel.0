From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/4] ASoC: core: add code to complete
 dai init after pcm creation
Date: Wed, 2 Mar 2016 13:03:13 +0900
Message-ID: <20160302040313.GY18327@sirena.org.uk>
References: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
 <1456820357-2545-3-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8730152575315156779=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9AC426145A
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:03:22 +0100 (CET)
In-Reply-To: <1456820357-2545-3-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org


--===============8730152575315156779==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zXwtYLeuv4p4yQJ9"
Content-Disposition: inline


--zXwtYLeuv4p4yQJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 09:19:15AM +0100, Arnaud Pouliquen wrote:
> Some Controls defined in DAI need to be associated to PCM device (e.g. IE=
C60958).
>=20
> This allows to perform post initialization in DAI after PCM device creati=
on.

Rather than add an explicit callback and make drivers open code this
I'd prefer to see us either just move the control creation entirely (I
can't immediately think of a particular need for the current ordering)
or add a data based mechanism like we currently have.  Why do we need to
do this via a callback?

--zXwtYLeuv4p4yQJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1mYAAAoJECTWi3JdVIfQ/bIH/RF/7MMXXMT0nJ+HCJZOgkaM
dsOS1LgtKYj+56pc2gu0F9NLxDyZZEQOsHtVygyo9hQAWqUEpJVi6S5hscBfLHvV
+NED/Wms+g1nYU4Xi76V51FQNF9CSTVfFNhowiM5mXm1x02K0mEv8DCPMLRZ951e
pxLabYDo9jPBJv1wVPGTPL+04IJ0ZmOKic36O2tCn/8u8aAVWjz+ftaLprZI5Nws
akQ/ge44Ulflm/RH/6X4t/3Li4pmmLlaijZ0KfcagB6zFz4Q5NDZkbaCk2ba0mZ2
9wI1/eRz+ouH9LJSUN0lMWLxxx53IO8kHnwopEb01/s3iJ9JI7A8FnBAecLLddY=
=1rs3
-----END PGP SIGNATURE-----

--zXwtYLeuv4p4yQJ9--

--===============8730152575315156779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8730152575315156779==--
