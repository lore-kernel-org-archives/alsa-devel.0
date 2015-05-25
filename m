From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 9/9] ASoC: sti: Add IEC control
Date: Mon, 25 May 2015 15:36:22 +0100
Message-ID: <20150525143622.GC21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-10-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1767796447997196415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B462A260A5B
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 16:36:35 +0200 (CEST)
In-Reply-To: <1431951176-24670-10-git-send-email-arnaud.pouliquen@st.com>
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


--===============1767796447997196415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OHFW44Kv8gQ39vd8"
Content-Disposition: inline


--OHFW44Kv8gQ39vd8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:56PM +0200, Arnaud Pouliquen wrote:

> +	spin_lock(&player->lock);

This is basically fine but a spinlock seems very heavy here - why not a
mutex (and why not something just for the IEC bits rather than the big
lock for the entire device)?

--OHFW44Kv8gQ39vd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYzNjAAoJECTWi3JdVIfQg3MIAIXhzO4CEH5B7RQNHF333Nf1
oqvN0eaAWYEbe6UoHTcScDaMAm1SuqA1rvZGudzgi7VKZfmoyS5L1WxGL1OLov94
+SKkqkF/n0RpGh+JPC0unJ0FhjYmN0eA82CTL06GVdrZisUoq94TBeYU8cd4EhXZ
+IS1IV9c16Iu22t6Cth4fPNsQ9QNz6/ZmbjGqiDOGHvqLX60x0OfXIOYHwn1gy1C
eA7Z0oBk30aw2fu7tTk7bIuvFPLmFCuycdPhLrIfl1oygRnJM1HlrHutXIyGVBF+
LvQZF/4sAVSoLfgLL6DXxYgkPNYIoP9GOEajkKGBjVVb4Qc9V1jQ/WrAzEkpXRg=
=dNCG
-----END PGP SIGNATURE-----

--OHFW44Kv8gQ39vd8--

--===============1767796447997196415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1767796447997196415==--
