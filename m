From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: Intel: Skylake: Disable clock
 and power gating during fw/lib download
Date: Thu, 1 Mar 2018 19:40:42 +0000
Message-ID: <20180301194042.GL12864@sirena.org.uk>
References: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
 <20180127042025.22042-6-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5097297352050714307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A75626797C
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:40:56 +0100 (CET)
In-Reply-To: <20180127042025.22042-6-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5097297352050714307==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 09:50:25AM +0530, Guneshwor Singh wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
>=20
> In order to achieve better DMA performance and reduce download time for
> firmware and library, it is recommended to disable dynamic clock and
> power gating. In some scenarios, DMA may wait to accumulate more data and
> last chunk of data never gets completed if dynamic clock and power
> gating is kept enabled.

This doesn't apply against current code, please check and resend.

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYVzkACgkQJNaLcl1U
h9AHBgf/YPpZ7+JZy08pL8xBi1clv4172awMCpI+S1Pi+B87VhQVErXVK6zbBnvG
vggzZ1LRb4R8cD1ayPxy9TRT8NT+FxzviHHNgkbyNva7YxZ/dZRvRNNnn2Nw1PQL
+tNsHfVUb/Y7H/YZv56AMx8Xi9LvAi8DLmnz49fRvl4bUahPq3I9elYPlwrP+u63
UpatsN33FElJxaoW1JHVnpnWIWQn+V9M2hsrUv7C3PXMuYDSUN0B9bD2zJXUUW74
/HsVre6FHh2bimbOaShNbVNYbv67KY3+ul8FJZBZqM0I57Vhrq53K0yHlJta5+RO
3xJ9zDqcgS5UtGkgOitHrtoe5hTkuw==
=hegn
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--

--===============5097297352050714307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5097297352050714307==--
