From: Mike Frysinger <vapier@gentoo.org>
Subject: Re:
 =?iso-8859-1?q?1=2E0=2E13rc3=3A_relocation_error=3A_?=
 =?iso-8859-1?q?mocp=3A_symbol=09snd=5Fpcm=5Fhw=5Fparams=5Fget=5Fchannels?=
 =?iso-8859-1?q?=5Fmin_=2E=2E?=
Date: Thu, 28 Sep 2006 14:16:40 -0400
Message-ID: <200609281416.41419.vapier@gentoo.org>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<s5h1wpwpa49.wl%tiwai@suse.de>
	<20060928180207.GA2855@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113860412=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060928180207.GA2855@samweis.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: Takashi Iwai <tiwai@suse.de>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

--===============0113860412==
Content-Type: multipart/signed; boundary="nextPart1543040.s7JQVnQS1y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1543040.s7JQVnQS1y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 28 September 2006 14:02, Elimar Riesebieter wrote:
> # readelf -W -s /usr/lib/libasound.so.2 | ...
> __snd_pcm_hw_params_get_channels_min@@ALSA_0.9
> snd_pcm_hw_params_get_channels_min@@ALSA_0.9

so the question is where did your 0.9.0rc4 go ... unpacked 1.0.12 and=20
1.0.13rc3 and both give me the same list with the rc4 in it ...

what version binutils ?  can you capture the entire configure & make output=
=20
into a log file and compress it and post it ?
=2Dmike

--nextPart1543040.s7JQVnQS1y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRwRiUFjO5/oN/WBAQLcBw//UABg1pIojKgr5v39s6vwpzKQjjxrKRrS
+aQAQy6Sbl9y4jzSB/9HODSLleiAQWTlUDADyA8ilYVG+Sb1xpqZtzk62bVa9TWn
tdws7wFAwIKQ0x8/6vbiB37Pi7YLsR3i+5aOGZV54UXBGAu3MJZ78WOx9JdHdNOW
1DxqJ+aB18uWUc4Bz66yfBJy15mqTwGzrFyynmrzJJnDOKMT1xMEtxLCJvcidP5U
HEXTP2JVhvkZWekInkkHxzOv2+oGuHlaB5+wFJ2CaOj5ILoaNHR9I21YZoAsJlXS
UnP6hGroW/PfYMrjM4NRHBTcL+BYZMysX/3CSXT4B54LlG286bA+0Ve9dhqTgVHF
R7vvnd0ZhJJI+6kVYyRzZBVu1j1LJOzobzQ1lHPMZit7c55BaFz94HPX24W01H5G
ZBS8Al46VcMXB6JsHQmQnZq1QTc5JyMKxKwN/X/qbfTHmiLjaE1gelF5WMljSjH0
/IWLN4qiyLmcUi6cU7NIML3wd6JgcZWXUnqhSRx/2hLw10742crt53HoP4j5yw0J
lTH4Be1+/v4cWpf3eOHnO+nuF/8wg/9bP5heSwhj3q5n3zuSn5P2OBc1b1wmyc8a
yq39cKFlLiGpGE5wPWPnSLEb9QRe1T/tdVw0ad8Yzr6XY5TiYygItnN/tx31CXWj
JZMJTJsTYxU=
=lktj
-----END PGP SIGNATURE-----

--nextPart1543040.s7JQVnQS1y--


--===============0113860412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0113860412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0113860412==--
