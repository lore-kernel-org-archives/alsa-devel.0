From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/35] ASoC: Intel: Clenaup SST
 initialization
Date: Tue, 27 Aug 2019 20:06:08 +0100
Message-ID: <20190827190608.GL23391@sirena.co.uk>
References: <20190823102652.GM23391@sirena.co.uk>
 <c845fda4-c18d-2ca8-7337-6e6af74d239c@intel.com>
 <70222fac-8c4e-5ceb-3c49-7020196b59df@linux.intel.com>
 <2e2a34b8-2451-01f6-79a1-14f06d1ed059@intel.com>
 <9dfd3a96-f286-34d6-fe57-9b6b8740e424@linux.intel.com>
 <20190823213920.GW23391@sirena.co.uk>
 <57196fe6-9291-5518-9fb6-731b9b5c27ed@intel.com>
 <ab5f0c6a-8d16-0848-1ca7-96286334a9bc@intel.com>
 <330b6be6-21c2-2eb8-9959-7d494841b3d6@linux.intel.com>
 <15484165-d751-b60e-f703-de7c1fa1ad17@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5162278177974028986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71C92F805F7
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 21:06:15 +0200 (CEST)
In-Reply-To: <15484165-d751-b60e-f703-de7c1fa1ad17@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, "Kaczmarski, Filip" <filip.kaczmarski@intel.com>, tiwai@suse.com, lgirdwood@gmail.com, "Wasko, Michal" <michal.wasko@linux.intel.com>, "Wasko,
 Michal" <michal.wasko@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5162278177974028986==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slMCvwAS3D50yFKj"
Content-Disposition: inline


--slMCvwAS3D50yFKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 11:51:32AM -0500, Pierre-Louis Bossart wrote:
> On 8/26/19 2:24 AM, Wasko, Michal wrote:

> > If the driver and FW update will be within the same kernel release then
> > IMHO
> > there should be no compatibility problem between those two components,
> > right?
> > This way kernel users willing to stick to old FW can stay on older
> > kernel version while
> > others can update and receive all the latest FW functionality that was
> > developed and enabled.

> I am not comfortable with precluding a kernel update because of a single
> firmware file. There are all sort of reasons for updating a kernel,
> security, sideband attacks and Android CDD compatibility being the most
> obvious ones.

Right, this is the whole ABI guarantee thing - we'd need an
incredibly strong reason to require a change in firmware for
upgrade of existing systems.


--slMCvwAS3D50yFKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lfx8ACgkQJNaLcl1U
h9CmSwf+MXgCTE4M7RFgm2V+02N5WY3CWVmmd838zI+RJ3su1MO/BcncRz0SM+xn
cHxr+rkye+BlBeGw/Md4pomLOojlQx9O0ds/fbP7JZreNxrIP6IoIyiNNb0g42Tw
yH4/UZFazTrVTzdiq6fXMJff7+UDN/CObGxCCG7v+MN0Gac7hiwCZlx6Za/uEl0k
CQ+KraB+kk5h3Hk8WR490IAU+naYcgc/vKGbabJRj9vLfqf0wuCNVG6pgwgmWyyU
NvWvmb39ZXqPMAAf+90qfxnXhmxQaSy6GgMCZT2RNhIDsEhwcjUtE7Ujxv7G3Sxm
dxZLPVLjc9EvoXYzuet4PKNFZtqV+A==
=swm3
-----END PGP SIGNATURE-----

--slMCvwAS3D50yFKj--

--===============5162278177974028986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5162278177974028986==--
