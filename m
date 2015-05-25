From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/9] ASoC: sti: Add CPU DAI driver for
	capture
Date: Mon, 25 May 2015 13:39:01 +0100
Message-ID: <20150525123901.GP21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0693345397212189903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F2D26129B
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:03:13 +0200 (CEST)
In-Reply-To: <1431951176-24670-5-git-send-email-arnaud.pouliquen@st.com>
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


--===============0693345397212189903==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOr5JpMIiGv/Oaxu"
Content-Disposition: inline


--zOr5JpMIiGv/Oaxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:51PM +0200, Arnaud Pouliquen wrote:
> Add code to manage Uniperipheral reader IP instances.
> These DAIs are dedicated to capture and support I2S and IEC mode.

Basically the same things apply here as apply to the playback patch.
This is still making me think there should be more code sharing...

--zOr5JpMIiGv/Oaxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYxflAAoJECTWi3JdVIfQSyUH/01T/20XB4iXNd1oJBxJCR9K
h0hJX5PVRF7Rxm09bd/SkPM4mVNrxckvNHDS0HGInNvbbjo8Z1hVT8SZf9THzeoO
BAdYEOzQ3IQAIyMx0JkBcZ3+wg2MhZD7ebZzv40sKuL464M1RYZh+U8+phkBhP/o
X8tN8MPHi2ZCJfZUQ1mU7b5e2ma0TEBwhJy6yVjdy+5TJVUQGPvTPin8KCuD5VYv
ViVTndFZpbjWJHGEQ90FEZZZFrBiI04Iw2OIB3ROq5GJOmz6Qf0viKcchX7NPpBE
zKG/xNF/ionFL9y41OkXgPCeVC+ppsPCZix1Hf4EXCxTCFEXCubJoGwzhcmnvEI=
=Fsb6
-----END PGP SIGNATURE-----

--zOr5JpMIiGv/Oaxu--

--===============0693345397212189903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0693345397212189903==--
