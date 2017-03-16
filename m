From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] ASoC: wm8994: delay aifxclk
	activation
Date: Thu, 16 Mar 2017 17:51:52 +0000
Message-ID: <20170316175152.hqipd5yvfdrt2ywd@sirena.org.uk>
References: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
 <1489682483-13051-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3001601066098263880=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2842671D8
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 18:52:11 +0100 (CET)
In-Reply-To: <1489682483-13051-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: olivier moysan <olivier.moysan@st.com>
Cc: alsa-devel@alsa-project.org, alexandre.torgue@st.com, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3001601066098263880==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aybydqemvsv76duz"
Content-Disposition: inline


--aybydqemvsv76duz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 16, 2017 at 05:41:23PM +0100, olivier moysan wrote:
> Signed-off-by: olivier moysan <olivier.moysan@st.com>
> ---
>  sound/soc/codecs/wm8994.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

...with no changelog.  That's especially important here, we really don't
want to be messing with the clock activation ordering on this device
without a good and clear understanding of what's going on.

--aybydqemvsv76duz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljK0LcACgkQJNaLcl1U
h9BjLgf/UEx6OJqLjgHemjYUQx5NawkQcxGZxZFWcImsm0BdHoluOB9qwZ5u+0FE
btby+E+7P+neVd96zNlPWEci76NXvdPMWXaOHXHB7Kk09f4klGc/r9jI1IrcALWq
hOdionk/V8KLDS3FglGNFxgjsBw26xQQK5ccEzdDGxw09lNKTYJ//1q0R1zrE1Nl
3C3rzFolmmTsavOlvp4FsS6Bw7NQGoHCsK88G2UBrbWtUEZtoSjaZIbjNaMT1845
D/xJ6xcp2JuFEv2slFCHy+q49V0vuvOVaTUYP9Jas+8EeRHUHLvCBsaB61Cx/lFI
X9e79IDvLoVDdXoEVZlrB0ktXGm/TQ==
=Ekzc
-----END PGP SIGNATURE-----

--aybydqemvsv76duz--

--===============3001601066098263880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3001601066098263880==--
