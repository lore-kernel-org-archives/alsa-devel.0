From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5677: add REGMAP_I2C and
 REGMAP_IRQ dependency
Date: Fri, 12 Dec 2014 13:25:32 +0000
Message-ID: <20141212132532.GJ11764@sirena.org.uk>
References: <1418271327-14710-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9072497483344336282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2AB3260692
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 14:25:37 +0100 (CET)
In-Reply-To: <1418271327-14710-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Albert Chen <albertchen@realtek.com>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============9072497483344336282==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dD1ndss832r/QIua"
Content-Disposition: inline


--dD1ndss832r/QIua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 10, 2014 at 08:15:25PM -0800, Ben Zhang wrote:
> The codec driver uses regmap to do i2c read/write.
> The codec driver started to use REGMAP_IRQ since:

Applied, thanks.

--dD1ndss832r/QIua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiuzLAAoJECTWi3JdVIfQl5YH/2Vf3rGrgUIyUh8Up83EQA9/
9W2BnAY77zE9SOiYFlDIisuExlH0HUkW9bzDP8/wAhzknLfmatg7s1HImf8iTdZS
sRfVcj+aVfwkDVnoV5KC+zBklPwdK295WNaWSDIiruaNPwNDB8e35iOnltto9quL
yjOAPT5XUzRpTFMGBZvghHXhJkMuMuhqIAziUDsVme4tPF9vIULNWkGzsyEX5vBO
oQoRhk+4w+Nb5f3cqYVJqHIGjAhxJikpCeyY0f1ssUInxKhE4rp2PQKvUY4NVfZv
+E32fD76noXAjInsX0hzJKxxOD/URYbgWv7rpINhYbY5mW4t4jdD/gmMakveAug=
=y3JX
-----END PGP SIGNATURE-----

--dD1ndss832r/QIua--

--===============9072497483344336282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9072497483344336282==--
