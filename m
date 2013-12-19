From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm5110: Add FSH for ISRCs
Date: Thu, 19 Dec 2013 10:20:23 +0000
Message-ID: <20131219102023.GQ31886@sirena.org.uk>
References: <1387445413-28475-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7690194072280412836=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D64FC261AA5
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 11:20:25 +0100 (CET)
In-Reply-To: <1387445413-28475-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7690194072280412836==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Content-Disposition: inline


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 09:30:12AM +0000, Charles Keepax wrote:
> Currently, the driver only supports configuration of the lower sample
> rate (FSL) on the ISRCs. With the higher rate being fixed a SYSCLK, this
> patch adds support for configuring the higher sample rate (FSH).

Applied both but you guys should really be doing some work to support
this within the framework and propagate rates through the devices.

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsshkAAoJELSic+t+oim90GgP/0xGADYnSHhwi7Mzq1sj2CYY
3BIYp63u+uVnjlU3+MSvNovHlLrp9sx7oi56nE0k/wSvGwRpYRVWWBx18n/JsiYB
nS4qvSAhiuthRL1AMQr8qG2YxjZhOsBqbZeUcivVH9nicNPj4fcMtOTcyflL8t5H
LLEw0euUrjXp3Hc0QCc99HJTFu9VAfw3BZqUbgPLQBE/h/Vxq5Tu3w+3lI76LyW6
QgIlZ+TYhgqfnvtlYNI0THR3D9WV87I+zVmanqxjx37yKNHGMSzQ64FvdJr197bt
NNL6XSaGTiEz2GpiLnlbB24OyIGqL8TJGJnBk89lQSvweP3A7VJm+iHlhqWjiu53
DP44EsyK4lrsyOyksLRvOu2kaDbge4yRK4VuFo0Cxg0VofhfDNjEaMwHWobOf2tZ
8vXKEgzGsprdu18OHTc5Qi2k7CeuqMZ66QNhnBH6xGxzsn1VDC+1b8FvWlFUv+6p
QyR6Zwlqgcbr1WlanIT0Pu/py8eMJod66rxCpiD+XGVo+DDvQy1IeKdy7r8PGoGs
FaApMvBs0Go44UIZHZtsZClGGObIg/sVbNnsNmqMokNJ1U6CTVaA1/s0Kh+djgAO
KVK0uARQw/1ZghgIUzoLGbJyY+JZO0lKvmCfwbKgUevnPeCnu2utNsqJ2rE1t6f5
1uMNPTLGqy/HBLSWAXML
=/qT7
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--

--===============7690194072280412836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7690194072280412836==--
