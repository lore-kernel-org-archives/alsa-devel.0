From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Add API for configuration of
 DAI FS
Date: Mon, 16 Sep 2013 12:05:54 +0100
Message-ID: <20130916110554.GB29403@sirena.org.uk>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379092188-7385-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <20130913172604.GM29403@sirena.org.uk>
 <1379327309.3215.21.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3652509866824386831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 127EB2608D3
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 13:05:57 +0200 (CEST)
In-Reply-To: <1379327309.3215.21.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3652509866824386831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3jrZykDBmppcQRK"
Content-Disposition: inline


--i3jrZykDBmppcQRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2013 at 11:28:29AM +0100, Liam Girdwood wrote:

> I'll change the naming so it's set_bclk() and the params to keep it in
> line with snd_soc_dai_set_sysclk().

bclk_ratio()?  Otherwise I bet people will just pass the absolute BCLK
rate in (though perhaps that's actually easier for them...).  We could
also just create a standard define for set_sysclk() if we were going to
do a straight rate.

--i3jrZykDBmppcQRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSNuYPAAoJELSic+t+oim9mzYQAJa44qYa/Omzjo1DUZ2Xx34l
m1HlNYAYvY1D2WycQ06AiIzdB6/bka/ZLysDLE8vL4VEmJK1TsgOVWnjJCDM36In
OxAkGbmBhB/ZjOg4ZC8VSSSclyaFGao1UGOqfUHczLoPrjiaw2MqC+KnwF6yJ11Y
GLWhY3VRToDnwGSVWNhEjarglEP3nF0DIXdWy5g619GXJu9PE/zsOvswuLYtqm8q
iwesLhiXKxblLAIPA3l5pYyTSBOJuzeufN7yiVkIdSQPuEUmkKeDPD8xbXxjlNA7
tPHTRUTuuu9WN1GGsxcolXVMbhiETeelvglLV9JIDTyleXgF3yfIWzbRYwUq+41R
48bNx5Zbgvxlec+Xjts8WCZSrYE8TZ4u3Kz0cjEDDPBcbQyuIl3YoGV/5SYNibmG
9ljBBTM1LaGdimYiw0j3XFTml3u+JnRQMW0quLy1go+NZNp35ViQkxdSvl9keYkv
iWdeemUH7gzC8HpUNF4YJdDFV7c594WXFe7iJZIjskn1kkihWOJ0MPm+wDyj6Wyl
d0z622M6hajNeHaikiP/soPlNsp4Rx2MLEd4BpMszRvyscSxgWb5LRpS16P9enpU
8lO9Afob7rVIabZ1ZAjJwsykbrnPVZIH/3qGMEGq/vQVBCABzCv3/q0E0sa3xmAG
+NM3+/NjUBmFEesdamEd
=k4or
-----END PGP SIGNATURE-----

--i3jrZykDBmppcQRK--

--===============3652509866824386831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3652509866824386831==--
