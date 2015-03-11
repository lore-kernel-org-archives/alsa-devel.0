From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Braswell snd_soc_card
Date: Wed, 11 Mar 2015 11:50:11 +0000
Message-ID: <20150311115011.GY28806@sirena.org.uk>
References: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4117444990549126154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1790226057B
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 12:50:22 +0100 (CET)
In-Reply-To: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jin Yao <yao.jin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4117444990549126154==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z8fvYVVi1MVTXPE1"
Content-Disposition: inline


--z8fvYVVi1MVTXPE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 11:48:33AM +0800, Jin Yao wrote:
> On Braswell, we need to add some machine specific setting before suspend
> and after resume. For example, disable/enable jack detection in codec so
> use snd_soc_card suspend_pre and resume_post ops for this purpose.

Applied, thanks.

--z8fvYVVi1MVTXPE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVACvyAAoJECTWi3JdVIfQWkEH/2UyE8R57hlnCylK/QjkrIHM
vTvYMGk8NXwzekRyPFogIlZ4CD6mI1GF3bfrSpEjr4a4UL9ILFym8bbs75PFifkO
enz7VMSOAeEZZfUp7g95bdxN7ujjzDXAPM1bZmbdtE8nVHj9Tv/HI70/Zc9AR9Y8
uxiUWi8ht2kTj4bJQOQVMq4Qf5yZ5TuqMLDQ5vmJ3TEgVMqUzPPxcgwvB+zmqBH+
zcXF7p0FYlbEXvUzGfm3M7m41S/VDICbCo4wvIYRgEV3ZWlh1iDjV4f7RQlSTiaL
WwlYUszk4WFE2pTmjXAYKTzmR90nQMky+m8Aj4c5GAA99mg91fKeY/lVLo+yVe4=
=1E55
-----END PGP SIGNATURE-----

--z8fvYVVi1MVTXPE1--

--===============4117444990549126154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4117444990549126154==--
