From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: Fix Baytrail SST DSP
	firmware loading
Date: Tue, 13 May 2014 18:21:27 +0100
Message-ID: <20140513172127.GL12304@sirena.org.uk>
References: <20140513105352.GG12304@sirena.org.uk>
 <1399985166-29055-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1087897989264890357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C84CF26549A
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 19:21:42 +0200 (CEST)
In-Reply-To: <1399985166-29055-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1087897989264890357==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+WYxA/8TJI14xo7C"
Content-Disposition: inline


--+WYxA/8TJI14xo7C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2014 at 03:46:06PM +0300, Jarkko Nikula wrote:
> Commit 10df350977b1 ("ASoC: Intel: Fix Audio DSP usage when IOMMU is
> enabled.") caused following regression in Baytrail SST:

Applied, thanks.

--+WYxA/8TJI14xo7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTclSTAAoJELSic+t+oim9G7EP/0zZb0Ua8QLphM40I/Hys7bU
5RIh9abQ3+DUwq72G6UZm5mmVYa0BakrkzcO6v/2IzvtppZ0KMoNXuyJPVY252+h
K7KOIbYaIg9p2arGRV2kHSTl9tpvyqJvJLpeOHwoqUS+xu40t6fCISVPPjxvtMFm
ZnxlHqsA/xOsXJBs645qDGi5AxC/HU2CaJvg5uwCJ15npZwDZPi4DyLMeFKaw8p1
YI0O0ELUMVxawGAi6LcI6os7X606w9TShsgNlVTNlAzZiVNYsiVfTLB6QVhE2Agd
Ac/K7ZXpnWhgKnScm/r7RO1Utpn286e572g6M8bF3C48UdKWb30ZVGf8dZK9S/Qc
qyjvvaDSNM6n2EOFYCk1z+VVntoiO3Ngf6EIVSwwZcGcMKXjphIv6QluGxOtJUJo
iC8IkY8evSHZkdsOV/dEcN9exodDq/GJ4GxEAB/VCzNJALPkP4s3+s5TTCrUfdKj
pQhHUlCOFiQeCNgHbZ6RQZCK/HkMKMLpSr85hpgxR/3FXt3PRu6hbHn4uRci/+8w
9FlP9f7OZSg4SLdm5YGVpZf6wsRsmCmP9M53/WoAAG2SLhrZNIFhh5J3Yxl98IaN
010HFEVso6tJojaqtEWmVr4dD0MYERCah/QeKX9goo03hhiPT2Z9XVXkINFcBoOL
cVaRaVq9JemDvkUbM1oj
=X9gc
-----END PGP SIGNATURE-----

--+WYxA/8TJI14xo7C--

--===============1087897989264890357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1087897989264890357==--
