From: Mike Frysinger <vapier@gentoo.org>
Subject: Re:
 =?iso-8859-6?q?1=2E0=2E13rc3=3A_relocation_error=3A_?=
 =?iso-8859-6?b?bW9jcDoJc3ltYm9sCXNuZF9wY21faHdfcGFyYW1zX2dldF9jaGFubmVs?=
 =?iso-8859-6?b?c19taW4gLi4=?=
Date: Thu, 28 Sep 2006 06:28:18 -0400
Message-ID: <200609280628.19332.vapier@gentoo.org>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<s5hd59hqygh.wl%tiwai@suse.de>
	<20060927181346.GB5202@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405391624=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060927181346.GB5202@aragorn.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

--===============0405391624==
Content-Type: multipart/signed; boundary="nextPart5692878.WB04Ibf7Gb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5692878.WB04Ibf7Gb
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 27 September 2006 14:13, Elimar Riesebieter wrote:
> The libs where build as follows:
>
> ../configure

i dont see how 1.0.13rc3 or older would work out of the box with this ... i=
t=20
doesnt include my build-out-of-tree patches

you'd see fun things like:
checking for aload* device file directory... /dev/
=2E./configure: line 20271: src/pcm/pcm_symbols_list.c: No such file or=20
directory
=2E./configure: line 20271: src/pcm/pcm_symbols_list.c: No such file or=20
directory
=2E./configure: line 20271: src/pcm/pcm_symbols_list.c: No such file or=20
directory
=2E./configure: line 20271: src/pcm/pcm_symbols_list.c: No such file or=20
directory
=2Dmike

--nextPart5692878.WB04Ibf7Gb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRujw0FjO5/oN/WBAQJ4zRAAnqUHTgU5RpmhENnmnS8X2Q3JiCYga5BF
Ddc91Q1mZh3suSynp44vGMaerAq8UAGxovU/ktB8x6LZfNNf2zLIJU8L9q/U6sgS
Flz8/qlSjpxuRu5GZaSsMm+h410IOevZo3+hxqzSHSAKVrbsFF0TcBGVuUCTyCTV
R/VkoCGQ/mBNY/sLYG0Aqqlgcs48x13bLXEsF6CPMp4vkvbKMUk0gIUPDJmomrrA
RMxv2er3fpLMRYc+OnDDJiCvQS/vqEoHOyikpwX4wLMN0ZVArmRUiRcabsDkh73p
LHks1/Y57rPOgvkTUC67kdh0ae4CfsOArQoKSTMVDBD0r/uRkCcRRMA9pE84QhbQ
JSUYSJhSD56l5dYuIP+pEmAaZzSXBekfDg+ZcaX9jVBoyKjdyFwZmutIykQp1Jwy
mYDa5Yd4s/BkliTyk/RmxYuFLaxMVzNpVmwPL2FwaPQvNHBR8siIulcn65FVZMaw
XKavi8jjAOpu9finu0nvTygNgsE3BgZU8n4ufoQ6NID2LnpCGnh530D1s009TEh/
tm5gBkRV1S3ZmWrN1YiuXw4KbIbHrIPV7Ud9HIu+Lg4sa5ItpiAy+UTehOOfHFdI
Us4g45og/UlyHziP3W3jskd1BFbS0p2iHtNAVmwG0JsVdX6RzpVwgLHN4wRykFA+
xYYG1CAbqS0=
=Lnqh
-----END PGP SIGNATURE-----

--nextPart5692878.WB04Ibf7Gb--


--===============0405391624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0405391624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0405391624==--
