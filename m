From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Thu, 7 Nov 2013 20:01:44 +0000
Message-ID: <20131107200144.GA2493@sirena.org.uk>
References: <20131106111529.GH11602@sirena.org.uk>
 <s5hppqdvk79.wl%tiwai@suse.de>
 <20131106114836.GK11602@sirena.org.uk>
 <s5hk3glvisi.wl%tiwai@suse.de>
 <20131106160304.GA2674@sirena.org.uk>
 <s5h1u2twin3.wl%tiwai@suse.de>
 <20131106234806.GD2674@sirena.org.uk>
 <s5hbo1wekgg.wl%tiwai@suse.de>
 <20131107113145.GT2493@sirena.org.uk>
 <s5h1u2st8m0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4514286293789799507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ED86B2602AD
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 21:01:55 +0100 (CET)
In-Reply-To: <s5h1u2st8m0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4514286293789799507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DG78IEnUmLKoW088"
Content-Disposition: inline


--DG78IEnUmLKoW088
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 06:38:47PM +0100, Takashi Iwai wrote:

> OK, back to square, I simplified the patch without extra error
> handling, just replacing with WARN_ON() at that point.  The revised
> patch is below.

Looks good, applied thanks.  By the way...

> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ASoC: dapm: Use WARN_ON() instead of BUG_ON()

...if you do this it makes things even harder to apply - the --- gets
the rest cut off by git am so I don't just have to delete the quoted
message but also need to paste in the changelog.

--DG78IEnUmLKoW088
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe/GlAAoJELSic+t+oim9T7AP/3vdnBCTmro6dk49UleVzkL+
SzgVmIbbq4SjCxWV6h1jXFV8hEtdOXuwjj8j7O13RP0UR0IwsOzKi8B2nnbw6VPz
jIzYlyWQinJsdTosXWN1IiiCTa9wWgyGor+CqPNPrMLWLWOgCTB3UpgagFpb65sM
FNuB4qSJJ6ExPpB0cNyyOxphQkBPqGARoZ8bqs2buB7+17D/PpPTBRlHLwqpzQ7W
QQ2WKswLnFGPyUavDpzgRjFShi8yULUBQbLlm9rGJrIDAPWuww4+vDGNGU/xCfYs
LFh9zbognxBgNMRDhNOUM2ZmRYTl0x32pnO7+HrOg44Y15vpz+PJQSa7EG7W4XMV
WZvVcy+cotHEd81nY1TvqgJg6R4RMOcw3Ujzl7p7JUk6zpAhrxwh3PDZSPS0jmUt
j5ri4q8KpzEcg1BqjtJ5EOKU/q8z4DD/SHlOGFAvVkVoR5VGRPMOUyzDAlkDXMyq
u9Qea7ROXDsnViJ3jxLh/CGcOpnoGvHxBn2UuqdzLZ8T7OK8Zp01flBU+cnDuwXH
m+ALSK+GoErp7pJRT2rzIf7r/0dO9vvfqGlAg8wAeq90SzpugcQpoZ6WqY7FZsJk
URtVnAsfiETrV8fzr5RcK3NW5WuwX6P/7b+HIRHgWcJwYYRQi/9kvQ0cDqW8txsX
WVEvQMkoCctlU6iHOyoc
=SxRv
-----END PGP SIGNATURE-----

--DG78IEnUmLKoW088--

--===============4514286293789799507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4514286293789799507==--
