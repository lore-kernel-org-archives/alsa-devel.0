From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Export
	devm_snd_soc_register_platform()
Date: Tue, 22 Apr 2014 22:00:59 +0100
Message-ID: <20140422210059.GJ12304@sirena.org.uk>
References: <1398200321-4299-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6296172404814583682=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0FE5264FBB
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 23:01:16 +0200 (CEST)
In-Reply-To: <1398200321-4299-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6296172404814583682==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oBsQ+RrLFfQDEUSR"
Content-Disposition: inline


--oBsQ+RrLFfQDEUSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:58:41PM +0200, Lars-Peter Clausen wrote:
> devm_snd_soc_register_platform() is used in drivers which can be build as
> modules, so it needs to be exported to avoid linkers errors like:

Applied, thanks.

--oBsQ+RrLFfQDEUSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVtiIAAoJELSic+t+oim9FEgP/1GIk7DB+LNDX0kJySIEktGw
cLO/LX972PJ7Ki0jt40QBptR1saPV0tU7Xo5rJSdi7KYy5JD8bCXVfR1v4tToLoL
gKjl+QtbRQYKy34zueZh15T5iOlEmCfF28Cyxksjfk9NquBXOi/14sL35fTPVvYC
VyzZZ9/9Wy4hH9YMKq634YwZZ80hAHB/OYm/198vy7UHcwhJjIywyZz5KpAJ0QBN
R3Zk7zI18GU0h10Gw4svns5A4iZpXRKtXlgxn9bgryWVg5Bz+iQYmCaaQ9Qv/Ur/
Oqlnptt/HEo6+i/VUMfNchyGpz0+nAgjxkaEs54Z4H3lDojj88X/wjFR5jSTk6vA
xHANJwK6BwwiVi0q1Hb1irHL4Fz2zJ76OE0m7YDg4fYAZ22bk6hBYIApJ5aNZWB5
uG/5fZU6n2nLUiNSFiI9y2X8b0Bty1aEglA3mtlLaBkowUNgBUcy82odke3vUmJU
y1ck8kcZkD4Bm6TTKqarA5aDbDv5gCPL00CoEdAfIprtVoT0tHGMHEZO5qy2AcMf
OEQ4rIf5fnhqFhNAZLzkU4inNjn21dwzff2SZc0SbSHz+Tt88DxWWDR4pyWoJYum
cP3EbUn3bveUUEcmyOGL7IklIGciFWncJCI74MqTjSxRwkk6Tt6qLqUkWgn0AWo8
wW7XZt9hZ+gD2fAwb7qL
=wCDe
-----END PGP SIGNATURE-----

--oBsQ+RrLFfQDEUSR--

--===============6296172404814583682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6296172404814583682==--
