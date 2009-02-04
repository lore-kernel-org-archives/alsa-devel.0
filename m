From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: uda1380: split set_dai_fmt into
	_both, _playback and _capture variants
Date: Wed, 4 Feb 2009 09:19:26 +0200
Message-ID: <200902040919.32728.anarsoul@gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<20090203164132.GG23827@sirena.org.uk>
	<74d0deb30902030845h2320deafj7f66921b22f91069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0323633284430623675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f16.google.com (mail-ew0-f16.google.com
	[209.85.219.16]) by alsa0.perex.cz (Postfix) with ESMTP id E3A8F24432
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 08:20:02 +0100 (CET)
Received: by ewy9 with SMTP id 9so449432ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 23:20:02 -0800 (PST)
In-Reply-To: <74d0deb30902030845h2320deafj7f66921b22f91069@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--===============0323633284430623675==
Content-Type: multipart/signed;
  boundary="nextPart1481909.3vLaKPRf7W";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1481909.3vLaKPRf7W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 03 February 2009 18:45:10 pHilipp Zabel wrote:
> Not that I am aware of. Maybe Vasily can test this patch first.
> (I can only test the dual interface case.)
>
> regards
> Philipp

This patch breaks nothing for me, uda1380_set_dai_fmt_both was used in my=20
configuration.

Regards
Vasily

--nextPart1481909.3vLaKPRf7W
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmJQYQACgkQRM6pQpltKE4v6wCghxe1HehLr04ruVgcG7n1Ba5I
xxQAoIyJz41SjFZyiMKssQMNQP3qnUzr
=L9oJ
-----END PGP SIGNATURE-----

--nextPart1481909.3vLaKPRf7W--

--===============0323633284430623675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0323633284430623675==--
