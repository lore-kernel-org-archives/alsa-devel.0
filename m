From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Replace instances of
 rtd->codec with dai->codec
Date: Tue, 18 Mar 2014 12:46:41 +0000
Message-ID: <20140318124641.GY11706@sirena.org.uk>
References: <1394742294-14698-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1881715701494971090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E8326072A
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 13:46:58 +0100 (CET)
In-Reply-To: <1394742294-14698-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============1881715701494971090==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gWFRGQTl+JkoOcqx"
Content-Disposition: inline


--gWFRGQTl+JkoOcqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 09:24:54PM +0100, Lars-Peter Clausen wrote:
> With CODEC to CODEC links rtd->codec does not necessarily point to the driver's
> CODEC. CODEC drivers should always use dai->codec and never even look at the PCM
> runtime.

Applied, thanks.

--gWFRGQTl+JkoOcqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKEAtAAoJELSic+t+oim9vgoP/jTEzNOdadtmXBFTX7iNwN7v
5XS/BHe5khBi1KRg7X5J8X1EuZwQxnyptnjLbwNo1uc+M5Us3GLc7Pqvz18iIOSG
6G8Q+Ipc5QDZC9gzyPAEFBB1SubV6qFqjO6yiA04GmhtnvYH0qpiFkFub4SHEQ08
c00Gr6k4Awgccrs3JD5GKkhlmLezKHleiuVTHtkrihEs/NfmLR414tnQd7VFxx5R
Ng8i++T26dLm3Q34RLlsIHye2/PNLUGcPIbCymsFLUkfBmPgNK7/ninfKo27+rto
PpZyLtkkQZwduBuLuq+L8HF+yaocz9+lx1A6mPc7yphu3c9TJWF2LDvqei9Pq24S
0UDR/qkbbOeki/WwkHi5FjqSoCT7+gvZVAZLluORq2pKcnJGkyPsbihQa5rDMXkW
uwVke0VsgpHDlKtJoP6QDR/+FGhWGEX0ruD05kZfMWHqIvPwE146PJ4MR6ZzXYrg
r6E9FfwgX5aOL55U1b80RAu/CyOAK0nL2Q5i55Mwup77NoJvnbVTA/4v7wS3FEUG
bzm3E5O62g7o36PsrowLGkj3ubd4HpZk5MSyfL00KEJYq2YY+rGGHS5TRSWyT1os
Meognewd2LiG/P8euk1xpD6Is8cj/w85VoOH6UqhNLuJ69YceDHMfEXYesMvpy4V
J8FLes7OnpVNmlRNugH8
=8xdL
-----END PGP SIGNATURE-----

--gWFRGQTl+JkoOcqx--

--===============1881715701494971090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1881715701494971090==--
