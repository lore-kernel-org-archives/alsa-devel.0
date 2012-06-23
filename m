From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 6/9] sound:asoc:spdif_out: Add spdif out
	support
Date: Sat, 23 Jun 2012 11:56:16 +0100
Message-ID: <20120623105615.GT4037@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<0c78cd7b8f874b5e7e8a84c5fdc78cfa257840f7.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7380684996184546690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 473DC11CF02
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2012 12:56:17 +0200 (CEST)
In-Reply-To: <0c78cd7b8f874b5e7e8a84c5fdc78cfa257840f7.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============7380684996184546690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VxJb6WgA6MoA+arP"
Content-Disposition: inline


--VxJb6WgA6MoA+arP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2012 at 03:54:54PM +0530, Rajeev Kumar wrote:
> From: Vipin Kumar <vipin.kumar@st.com>
>=20
> This patch implements the spdif out driver for ST peripheral. This
> peripheral implements IEC60958 standard

This is fine but it should use module_platform_driver(), please resend
with the other patches.

--VxJb6WgA6MoA+arP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5aDJAAoJEBus8iNuMP3d4eUP/jtJ7gIxpWUWc2jDwSLqk3au
bn6EEZNDFpuowwhlPHCCKiV5T4q9URNIKJyhI6VcuFQ+mCZ/phbby7/Ik/dNSpcB
K2aKZ0QJn4ixZiS456mfpUIqxLDmrPg5xdWvgtd0WSP0PyqYOF4pF/5bjxulXoN+
V9nzARPE+Fe6LIZvOnOK2XIimZqzc7HArHmCBYvm+QiVEMLQ6VcSyrvGML01Hmm0
nqaIgR874z6Lhfozvgs46XE7x8Grn/FLe2GvqKtyjQVtNQzi/GrtlCE2uFsvyIzZ
3HCN1SAwReLx/W8HtWEP7iMbxMNF7w8/jWDeP1brKWirKZcLDaJ41L+eXaHuwJgC
wJlz0BnZ1D4X3XFGq7UK7Uhijd22jyhC5yztYzIw3yBBBPxHmkZ9ybXWuyk9fVCp
9mEghEwfryTE7UkPtH+t9cidhkttbbm8EMAo3f7Bm+o5NO+z5EHOOhWYLraacOg2
uBdPT14aSQaKqM+ABcvKS1driZAPkl3QHcmQGBF+IMjI7jlLEQU+jqSdgtLHfLEJ
ER6jbx6q/4gpoqtBHxjM43N2OlKJSG6ZBSnKGR8GaqAPQ6z+UOInJxAMlMnq6xKl
CUdQiAwEuIQAIcnowF3Vxsud9wqMJt6lSmwHxowu+8bjFF8oxID6eV4T7eFM8TUN
yw6SPFG8wDAszVO04mb7
=XFYc
-----END PGP SIGNATURE-----

--VxJb6WgA6MoA+arP--

--===============7380684996184546690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7380684996184546690==--
