From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/9] ASoC: Add ability to build sti
	drivers
Date: Mon, 25 May 2015 13:50:40 +0100
Message-ID: <20150525125040.GR21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-7-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7859456075583937797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7AF8260713
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:02:28 +0200 (CEST)
In-Reply-To: <1431951176-24670-7-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7859456075583937797==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8Vg9Vt30SMsjSDh"
Content-Disposition: inline


--B8Vg9Vt30SMsjSDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:53PM +0200, Arnaud Pouliquen wrote:

> +menuconfig SND_SOC_STI
> +	tristate "SoC Audio support for STI System-On-Chip"
> +	depends on SND_SOC
> +	depends on ARCH_STI

ARCH_STI || COMPILE_TEST?

--B8Vg9Vt30SMsjSDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYxqfAAoJECTWi3JdVIfQTQAH/1CU11RatioG85aTiXVKZJOG
s6RTk86aiH7QMsAPdL2ldT3fs8U3KXt+2oOxxFTT35ym8md7NkFCzvsevktY9o0K
z0fO55Q3oF6Kb1dG9iBTdpn3kSAX8k6bYfQZhiOgghk4ZRYpPPmJCB5X93WRAL6e
16vdffFeApMpwV4T8Echd1x4Gs6WSNUUEBUMLm3wpBXyUruHeQwNPK0gkFilqi/y
Ara5C4S7cl2ejjCuSRQ6EdoMWqC7nPSfM1wQpGr+D9kZKcOZfb696fWq2VeH0jBR
Rg+mRm48YLOFTxIEtDR9hz8LtOQ2Yc8TOBYIyFCcGTKOk2YyTqaGqka0lXPO7GE=
=u3Po
-----END PGP SIGNATURE-----

--B8Vg9Vt30SMsjSDh--

--===============7859456075583937797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7859456075583937797==--
