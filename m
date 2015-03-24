From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: Fix duplicate const for DVC
	ramp rates
Date: Tue, 24 Mar 2015 10:09:07 -0700
Message-ID: <20150324170906.GR17265@sirena.org.uk>
References: <1427194063-31572-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5790983231223986918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55E5F2604A1
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 18:08:43 +0100 (CET)
In-Reply-To: <1427194063-31572-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5790983231223986918==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7L9kolmstoDTZ4pm"
Content-Disposition: inline


--7L9kolmstoDTZ4pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 11:47:43AM +0100, Krzysztof Kozlowski wrote:
> Replace duplicated const keyword for 'dvc_ramp_rate' with proper
> array of const pointers to const strings.

Applied, thanks.

--7L9kolmstoDTZ4pm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEZoyAAoJECTWi3JdVIfQVGgH/AmMSiKLfFz73iR/LzbU/Qqa
rzoTymxhyd7xkiFnzwSU8sxwO4U8WTY3odncTJsepye/xWHBPBTyfJ69aIhbAlhT
Fte9wfGZA057sG4HHeUbY3gmyl1IWHqHYlPJcSetxTs2AVheTrrHsJCz12EGR0D6
lwzMhtnk2mANeFWuD5mVE5WYzCjcsKg/cYFzgN5q7+SC+m8kUaPE3DorkdA/8djF
5XO84O0mRsnUfLnriDilvwMo9mO0MBPBGyjwc7z+YZKR3SiSSyyNgYzMAscXTRxP
1Xi7xJfRGfX3h45pp/uvQiAm+6FkCdKRLNmIjzgBMRG5ZIZ4tWxR2rj4AYo8TGg=
=xRjb
-----END PGP SIGNATURE-----

--7L9kolmstoDTZ4pm--

--===============5790983231223986918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5790983231223986918==--
