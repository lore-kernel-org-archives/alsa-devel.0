From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: sti: tdm: uni tdm mode
Date: Sat, 2 Apr 2016 09:45:45 -0700
Message-ID: <20160402164545.GE2350@sirena.org.uk>
References: <1459440058-12234-1-git-send-email-moise.gergaud@st.com>
 <1459440058-12234-3-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2118932762700607858=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C1C12260524
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 18:45:57 +0200 (CEST)
In-Reply-To: <1459440058-12234-3-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, rmk+kernel@arm.linux.org.uk, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2118932762700607858==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pEX2GA8pip5RjAtK"
Content-Disposition: inline


--pEX2GA8pip5RjAtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 06:00:56PM +0200, Moise Gergaud wrote:
> Implement tdm mode for uni player & reader:
> - Remove "player" in uni type enum => common type enum for player & reader
> - When TDM_ENABLE is set to 1, the i2s format should be automatically
> configured. Unfortunately this is not the case (HW bug). Then, we shall
> force DATA_SIZE setting.
> - Compute the transfer size for tdm mode: transfer size = user frame size
> - Manage tdm slots configuration given in DT.
> - Don't use mclk-fs when unip in tdm mode; use tdm slot config to compute
> frame size and to set mclk rate.
> - Refine the hw param (channels & format) according to tdm slot config.

This looks like a large set of separate changes which should be split
up.  For example, the refactoring to use the same type for plater and
reader seems like it should be separate to the rest of the changes.  As
it is it's a very big change which is hard to review.

--pEX2GA8pip5RjAtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW//c3AAoJECTWi3JdVIfQd/sH/RHMAu9uE73A1jq5Ng3qDXJq
a3Oqvg7dEQ0uA6HMJ39ot21S7LD1VmRJd371f7+QyQszBpRuym/JgUQL8Xxzl30i
Y+fn+PDHT1STcFoSi2JzTCx27yb+OzAJpey0iGvxXqV6fjDi3yEgZpRmebxh8UGM
q56gY3GxV5ZREQxIISuVvQ6SvAwR6MH2D99GPVXkwfMp37/aczvjGraG/sBCjFWb
JWsM93Q9/9YwHha78bZJDiLXVMmJVg5U2plnRM/co1dDC1L9GWCbl+518l6Ey7jY
/Mz44VOJi2j2FshG7c1WT7pycAGxBV/3LfH7X1Wux8nCDktrhoaW63sb24W9asA=
=T97D
-----END PGP SIGNATURE-----

--pEX2GA8pip5RjAtK--

--===============2118932762700607858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2118932762700607858==--
