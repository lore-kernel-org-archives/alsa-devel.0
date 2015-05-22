From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/9] ASoC: sti: add binding for ASoc
	driver
Date: Fri, 22 May 2015 13:43:28 +0100
Message-ID: <20150522124328.GV21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8593416601872524009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8F4F265C95
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:08:04 +0200 (CEST)
In-Reply-To: <1431951176-24670-2-git-send-email-arnaud.pouliquen@st.com>
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


--===============8593416601872524009==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G9m07da55tKJni3T"
Content-Disposition: inline


--G9m07da55tKJni3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:48PM +0200, Arnaud Pouliquen wrote:

> Add Asoc driver bindings documentation.

ASoC.

> +  - standby:  standby mode activation deactivation. this mode is specific to
> +	      Uni player IP and allows to transmit bus clock and a pattern data
> +	      while audio stream is stopped or paused.
> +  - auto-suspend-delay: runtime auto suspend delay (in ms) before deactivating
> +			stanby mode. Equivalent to the DAPM mechanism but for
> +			CPU DAI.

It's still not clear to me that these are things that should be
configured via the DT.  Otherwise this looks OK.

--G9m07da55tKJni3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyRvAAoJECTWi3JdVIfQ8tAH+QGw/lno6KnPK+5n+J3l+sIz
jsAWBQBMh3KZK+qdbq6xPxe9CGEzaMW0jN923D7IlJuZMVE64YRh0JdEOwhWmMok
Va4d9A9DOMbbBmLGcyhOvt03TWorVhCfdfcn7RFnxMgw2XFMkKVMketCzkSiuGnV
v6RyXGKHPlQPmcjqd0v+Vud/7HnUwzth/72Bmct572ChAJKjvDWrbBLsVt4LohC/
8xh7ebbWIYBvVJU0HXd+/YAhtPURU8sLJSbP22+zO33hp+KYUUN6CAxkyD0AsbrD
jKqyAg3aYJpMnwCEVo3T3lnA9cLyoartMKS7e7BxKOInuRVWdqxbVeb2B8lgPdk=
=nLGt
-----END PGP SIGNATURE-----

--G9m07da55tKJni3T--

--===============8593416601872524009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8593416601872524009==--
