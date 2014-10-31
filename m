From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Fri, 31 Oct 2014 12:54:15 +0000
Message-ID: <20141031125415.GA18557@sirena.org.uk>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
 <20141028164822.GB18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
 <20141029103053.GX18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B704DC6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8050479378454813697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6090526593D
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:54:46 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B704DC6@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8050479378454813697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BY0EBX/gsEa+Og+b"
Content-Disposition: inline


--BY0EBX/gsEa+Og+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 12:48:26PM +0000, Lin, Mengdong wrote:

> Now we're working with Realtek to enable runtime PM on RT5672 codec drive=
r.
> With help of ACPI,=20
> - the codec will be in suspended to D3 when idle , switch to its internal=
 clock,=20
>  and BIOS will turn off the platform clock output (MCLK) to save power.
> - And when the codec resumes to D0, BIOS will turn on the clock at first.=
 And=20
>  hw_params will make the codec use PLL and lock to MCLK again.

> Thus the machine driver does not need to explicitly turn on/off the platf=
orm=20
> codec by itself.

If the machine driver has asked for the PLL to be on I'd expect the
CODEC driver to be respecting that...

--BY0EBX/gsEa+Og+b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU4Z2AAoJECTWi3JdVIfQnacH/iKRsfmbuD94GuPO6QAmJNYA
wzBqlGdGgQBLRcXjsdnJgoF3IYZrO5jsTjzJtL+zCAfXkXidaMr+xDHpYVtetQjn
CaV7FkfUhw/umI6sAXMVN5yHy+Prsrs6JBOm6G7jkzDjCNU+bQWeKm07hcN2O5Aq
dbzh+G8ncChZk8gYDVk8fcGXGWUPw06DyrLZPEl/OVGlnJmKdbsIWkkEkbnk4hPG
gKO5jbrJaKsajrnQcrP5cri1exy50M34KReDip/ZvG6TStjNqFkaull6B/1nEn8j
cFqeSIVKDunklUGhHSDke7Cf+B3EKPp+oR00d5Ir93L4ky9BTFtcJ3Jnghz2FcI=
=sYuB
-----END PGP SIGNATURE-----

--BY0EBX/gsEa+Og+b--

--===============8050479378454813697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8050479378454813697==--
