From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: use samples to set silence
Date: Thu, 17 Jul 2014 12:27:54 +0100
Message-ID: <20140717112754.GT17528@sirena.org.uk>
References: <1405671297-17792-1-git-send-email-scott.jiang.linux@gmail.com>
 <1405671297-17792-2-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5928976111812363383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 632D42654E9
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 13:28:03 +0200 (CEST)
In-Reply-To: <1405671297-17792-2-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============5928976111812363383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pndui+VhQ7yNUqd0"
Content-Disposition: inline


--pndui+VhQ7yNUqd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2014 at 04:14:57PM +0800, Scott Jiang wrote:
> The third parameter for snd_pcm_format_set_silence needs the number
> of samples instead of sample bytes.

Applied, thanks.

--pndui+VhQ7yNUqd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx7M3AAoJELSic+t+oim9DnYP/ieSy43lkaXtaF6B8t0i9TBS
ODn8eLqL8+0aasGYW3GrDNIqVnTnNfxnX/FTOu4kxI8rUclgb6jWehUqCQ27f8UC
WOcIslZPZzsBZKHGcXAqKT/4Fm70xbRPvChMaUsX09255LfkzIhcD8sOJutpupGC
Q26rFo5BbM9HEZYF65CKBP52JpssGQjFEIPJbWFHpjdNsjlvwxB/z03JTrpOS66Y
99MCdvurNh8kkB6pqF2dUQ+dPECyBTe+ntlAadBX/9WdAjpCoqQ0Bs0AqYzZYoPx
ArnuS8eMmwX1QLJdhKQtnapfsRFAmCXkB0mJSd3WjD1kiqBafBQWICqqjXV0+eJj
zP5vqPnHMKVMFhDHrwfAR561Z6A1sS2v6haCsUdE/Z8jgoG3UoUxOzaC4MskMDh5
CMZ0SXWCM9Jcgxu5lFxgTXi31TcWZvRaiXST/+3kK1+xWIixeOvHIbeaLpoTjUTv
/d+SHHDvYf+N1m22aCUpqcPrEE1IkyJUMGx9ilbblvg7xRGVso5ehxN/LiLvsPwU
rSl87FlLp0rOZP2Op0WnR2KHYpqud0NdNAMjWlHJb8FJt62e6RqjordheEKzPhLv
wA3BG+YPX1TutLdluBIO2iAuIktzD1fy7O9y6zJftKmp/Tjlm0xb2UNUMGWILB8z
puue0IuzjaIk2iQ2HjmI
=Uqwx
-----END PGP SIGNATURE-----

--pndui+VhQ7yNUqd0--

--===============5928976111812363383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5928976111812363383==--
