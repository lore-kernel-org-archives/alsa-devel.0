From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: max98088: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 18:16:28 +0000
Message-ID: <20141121181628.GC3815@sirena.org.uk>
References: <1416514915-29836-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0487937666115411653=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D256D265CF8
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:17:57 +0100 (CET)
In-Reply-To: <1416514915-29836-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0487937666115411653==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jnOyM4i38QxK9DOz"
Content-Disposition: inline


--jnOyM4i38QxK9DOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2014 at 09:21:53PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--jnOyM4i38QxK9DOz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4F7AAoJECTWi3JdVIfQOKEH/RIa+5jZJVd7xYaiNaizH7st
99rdr4c+QwXicjQ4FTcAgE9iYGmfxVyYUDelcZTDzHXQYAeiydeXLJdEu0yh4pbo
jIGb2WtdHk1n4w0oM/vaGrXVlmORRZWSswbWAQ0ev/VNkW0GQnXt5U8lsZwE4rHj
GP8P1nwyFhLY5HlaQMDMcgYX4CBDpwiTj5E5c/Qdk0K69QhCbLCqskFtE7pFuTZA
4n2nTsS09Yzx0STjWOPGFHfBv4xCCgemQ/wQpKakifAOy1bHm2GNUlzgdxIMx4Yv
OcTssfyP5BEoAjCE3t1KWeyxiP1wnhQoryY/nFoiqfO19I7MFMMxUeTLcjlo0E4=
=KAay
-----END PGP SIGNATURE-----

--jnOyM4i38QxK9DOz--

--===============0487937666115411653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0487937666115411653==--
