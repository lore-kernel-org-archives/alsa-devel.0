From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASOC: fix neo1973 wm8753 initialization
Date: Sun, 4 Mar 2012 14:33:55 +0000
Message-ID: <20120304143355.GJ3083@opensource.wolfsonmicro.com>
References: <1330280514-32232-1-git-send-email-GNUtoo@no-log.org>
	<1330280514-32232-2-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6804207429662955139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AACDC246F8
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 15:33:56 +0100 (CET)
In-Reply-To: <1330280514-32232-2-git-send-email-GNUtoo@no-log.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6804207429662955139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 26, 2012 at 07:21:54PM +0100, Denis 'GNUtoo' Carikli wrote:
> The neo1973 wm8753 driver had wrong codec name
>   which prevented the "sound card" from appearing.

Applied, thanks.

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU31CAAoJEBus8iNuMP3d5lIP/1jWmERzxMqi7rVfooHlvHza
2TGuCcdCBlVd+Ud9uEgKphVueQb15gIdDYCEx4BTrMQVRzo43o/ed/YMHOYuZcLE
IeIKFZ1K8fTSCoLaJiuAoimuWvm19Kla8aaBmhi5t/tMU4Ddh2aYYHkgLOiq91gl
oNQ/zQDIc6yTkpIgiPvlrRljWROHLBJPhjtbIhEM1tcIK2AMaomKaJqYBCjCcSxN
9o3kvZAlGAQLdj2pDnDDOVLtF/t3bQ4DCbHPqobkSz7000xFgSjHmHfOoZXKXXMx
meZa5VNrr2d1bDkB4LxU5r7TAKE/vEWFFdZ8/hp3IFLct0DjG/cv7bteu0DgoTP/
7AYW99udHTSFDNvrMCQeiW4q9b0jTur4UcGov/i+61jKQwByqoTR6L+1uieMbH6r
LlXsDW3VqUQc2B/yfXUkTnuE2XTrsa69VYoqf+1euuYCuG/jHaXTEdBxHgmn7Rqj
aRmXQ/jqyM8Eews/kMMtMeRNp/js0lRA8zZvEq5iL84ncqrD8mEykpCffzZxVJLk
SH73FkWDYEtRWkQUMnt3QaEy/+HBceqpMD2javY+9mbT73Z7ohOR1p2mMiG1S2EP
h509YeWSO2U+mx/fzk64e2LqeyXC73YjrDXJGRdkiBLTseVdYah7N4GNvdOOVss3
7kf8a2TNG9HOwejbwclI
=yS/O
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--

--===============6804207429662955139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6804207429662955139==--
