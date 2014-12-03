From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: dwc: Allocate resources with
 devm_ioremap_resource
Date: Wed, 3 Dec 2014 18:26:59 +0000
Message-ID: <20141203182659.GG7712@sirena.org.uk>
References: <547F3C96.9070509@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6550824677820420071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 909A726049C
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 19:27:15 +0100 (CET)
In-Reply-To: <547F3C96.9070509@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6550824677820420071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WUTMTnGprlFONK8E"
Content-Disposition: inline


--WUTMTnGprlFONK8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 04:38:46PM +0000, Andrew Jackson wrote:
> Prepare for the introduction of device-tree support by re-ordering some
> of the allocations and using devm_iomap_resource to simplify IO mapping.

Applied, thanks.

--WUTMTnGprlFONK8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf1XzAAoJECTWi3JdVIfQQskH/Rw0xIo5VQ4nbTzjoaQ9sn2I
uDjsnuzaq3mZOgOSkKCyoGnGzA9FlnsCWmxvdt9ReKKuehIBP33UnIlEQgDRdP27
WWGJdxbWXqplrRupo7yVGLhgDPCXRreIzN4oaBBbEpeeq4mMCVRWhHBMaLmUY4P4
UOmMM0m7mlDLuIliVhV19puCUPR07Ok8UdiOLGnH8wz2ND/UCRoqMUK6hlTGwJBg
4pdkYB5k/tQsbLzBbVYVzqDZZneHBRa1P+wtSBxEhXyFPbBQcdB2No1nQQNSa3xd
WkrEivQesqahIlXHJl14dIzZET8TLrZWJj+lMjlIA52T/7JWYmFE/RQMlrSw2m0=
=Ky9s
-----END PGP SIGNATURE-----

--WUTMTnGprlFONK8E--

--===============6550824677820420071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6550824677820420071==--
