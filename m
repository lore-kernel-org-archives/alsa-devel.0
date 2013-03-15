From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: add .name for
	snd_soc_component_driver
Date: Fri, 15 Mar 2013 01:25:13 +0000
Message-ID: <20130315012512.GD4931@opensource.wolfsonmicro.com>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87hakhtnjl.wl%kuninori.morimoto.gx@renesas.com>
 <20130312200253.GI19942@opensource.wolfsonmicro.com>
 <87zjy8f82b.wl%kuninori.morimoto.gx@renesas.com>
 <20130313101411.GB25610@opensource.wolfsonmicro.com>
 <8738vy4fg3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8226033583602118943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99E9D261643
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 02:25:15 +0100 (CET)
In-Reply-To: <8738vy4fg3.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8226033583602118943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2013 at 12:18:41AM -0700, Kuninori Morimoto wrote:
> This patch adds .name member on snd_soc_component_driver.
> But this patch doesn't care about whether cmpnt_drv was NULL,
> and/or its name was NULL in snd_soc_register_component()
> at this point.

Applied both, thanks.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQnhyAAoJELSic+t+oim98AEP/0Opve0LzdMg5WQNbhzkNwrl
QB550pTNpfORKvO+IbUZM1SdVYiZq0RLErwvbSxuhlzNkv4Yf886vaEWNjQeSSpq
wGkH1DQoqolohpZXWR+gnC65XYHvMinYi4R93oKXaHLtjzat85s9JCGuhsBRKutf
tfoG87/AO+TWMwpEl+mM04l2D9Yto/GaPfsl2PLHfkAGdBJXBTVxIe9h+LNsY68s
pn5U15s4Oqh2q5iQte8YSKOqSXyrfDGKwDfwVJim6aW24PH/pXV2eNICTGDHMtPA
aG2HYSEo3qre2KuahLrSLYLk/m9kw6EnxvAXTtRRWgJahv3+6urnYDJGw4YcrDEF
hufl0twcWtHFq9go9tvzY1kVV5pg7j6IqZO5ZFKYjBCRbROUzKHwRdzbWkCgoYl6
ze7gu3mPyGl7ZcnXbhJaO2FU23anHvevKhWhu2XiKxIRfcBdCrG18EeWBOPhdUMb
t839O6KQIYmxBnIssv2tXjGqj1/V18JrfvWYQLzQU/XJmLUDGTPhMCffSaGx5sTM
7v12h+Uz9BNtd/xOvSnKqze2uSGuE1VuxHHRiTMlAzNF7TZ0PlECFDGrbJfPfujo
xOQz5CCM5c76Ejfjwpz2zFONsSDD+BHcIQyn981dRat0YAeBYMLB/VdYZZbFTbCc
hnooVc5T6GUoLTQEBj2q
=cLL0
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--

--===============8226033583602118943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8226033583602118943==--
