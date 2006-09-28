From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: 1.0.13rc3: relocation error: mocp: symbol
	snd_pcm_hw_params_get_channels_min ..
Date: Thu, 28 Sep 2006 06:23:10 -0400
Message-ID: <200609280623.12846.vapier@gentoo.org>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1467191175=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
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
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

--===============1467191175==
Content-Type: multipart/signed; boundary="nextPart5955193.iXqqNAmCA9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5955193.iXqqNAmCA9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 September 2006 02:41, Jaroslav Kysela wrote:
> What is output from commands 'nm /usr/lib/libasound.so.2 | grep
> snd_pcm_hw_params_get_channels_min' and 'nm mocp | grep
> snd_pcm_hw_params_get_channels_min'?

`readelf -W -s` is nicer i think
-mike

--nextPart5955193.iXqqNAmCA9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRuikEFjO5/oN/WBAQJB3BAAi8BVUMznW/FkzQQUhRvR1Z6CX88XjrM0
/fCM5kfbkmdaeYwUTwpCNkR+JP9BabdQvt/CsSxxP6rQiQlWrzG2g+9+/t1Kdk3V
xNZOEo4z8pJ4kNrBDz4AgOZR5Un1fHeTtNxva/osQnPFyWuZOXWaoL+5yaaIfhWW
2p9ZWP2vgp1MdDgc+8nHxpxujZtb6DG8BeScZ2enQOrqOxJ277pmMAA+yhpH+IlX
6V0FqRnN2MhKaHG639btidJ5FMLG71snoLT5RxcdWFKrVQBSSqilmKSnbdkEIdXv
pFCxqI+4qCgzjqqi644jZOptxWdGUkFBfV1/+yeS1FK0MtYcfHwAmOqMWosH++lS
XzV5/k6NkCFnb7aSIcIldrFTvKb31Duq4d+vwd3xerPd+VMuFK9waY3Y1/ufcpEr
3i/hI6jtoJTl0R5Fx008RjjhcwsDw9nNb/T7zVFoba2/tknj9cpV0e64DNcuyU6A
/29MjF257Jri/H9CKB5aji6aAuWS6SbbWyw5z2xswpMZZPHh/U+00MnjE7DxBCvk
Q1AvNnWtHYYSU4p/sOcnfRkngKA4t5RblIHvVj7Hp8lUpdgvyn5sgzdz0urNiAA8
hNmhMz/PDpbfvSklFicXANWD2HHFufUJv3YA8RCmREa6Mb1Gex00MHvbgHHn2Ao9
tqDvjnYpNSY=
=JyTa
-----END PGP SIGNATURE-----

--nextPart5955193.iXqqNAmCA9--


--===============1467191175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1467191175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1467191175==--
