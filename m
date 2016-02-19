From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix pointer
	scaling
Date: Sat, 20 Feb 2016 00:33:45 +0900
Message-ID: <20160219153345.GO18327@sirena.org.uk>
References: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4935066859761904342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D95A2651B8
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:30:27 +0100 (CET)
In-Reply-To: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, Alan <gnomes@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============4935066859761904342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Content-Disposition: inline


--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2016 at 11:42:32AM +0530, Vinod Koul wrote:
> From: Alan <gnomes@lxorguk.ukuu.org.uk>
>=20
> skl_tplg_tlv_control_set does pointer maths on data but forgets that data
> is not uint8_t so the maths is already scaled in the pointer type.
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Please ensure that the name and signoff match up.  I'm fairly sure that
both are for the same person here but it's not something I should have
to think about and it is important to ensure that we have signoffs for
everything.

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxzXTAAoJECTWi3JdVIfQag0H/0g3gnpH231ySyHimDJGrvuy
VG3D1PUSDEU8VGgf/wh+cRvtdNPeBhofPqkMFtNJPXAgwOrUksLvO4zF8V0gCTLl
924W5mh7cDi55exjItvnIbmORdZiPZCLsMTQ/SEJimE4Hy6DSwAwRF8TZtJWlI4E
QmdwcVMnc+z3NC3cUXU1FOnmxegL23BH0fNWYLOuF1hJUYif4Q8Qm+bk1ncX4Twx
oxJ3lmI3pBsmMlNCdWBhdsRCSsjHblVxt6m46/m/C75YAxV0LSMKXubttYA0aM0i
qwAdf1dank5V/sDwR1Tfpz1JL9T2FS5EG6ige0WN2m43WF9jqI2iyNZbnpRa8Ig=
=o2Z4
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--

--===============4935066859761904342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4935066859761904342==--
