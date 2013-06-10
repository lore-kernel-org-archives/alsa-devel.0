From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: Use devm_clk_get()
Date: Mon, 10 Jun 2013 18:00:08 +0100
Message-ID: <20130610170007.GL1403@sirena.org.uk>
References: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4411436168403416214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E32F2616FA
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 19:00:12 +0200 (CEST)
In-Reply-To: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4411436168403416214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2013 at 01:26:05PM -0300, Fabio Estevam wrote:
> Commit 9e13f345 (ASoC: sgtl5000: Let the codec acquire its clock) removed=
 the=20
> clk_put calls.

Applied, thanks.

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtgYUAAoJELSic+t+oim948cQAJdrqCA3JGDXpndy3wKUM6Zh
HAYu85uRYffQgjb2M0MizYGSn6YwHiFm7lPIjbGDgrCFvosHTDhdQsPuNe+DmJGk
gFomNBpvRH87ELv/tyPiQxaYdu441nN0lRCiNYBoHsXYey3nIyK+sESLz1palg7f
WZ3X7PS6JMmLEtNHJu6+YzhzQ4p0A0hgJdrWhSvIbnepjvs5KqbBKOpXb7re+caS
pLrP7T16AtA0FssGeSLnqhAHK2jU9Cf3mT6NEO4vvw+sm0XqkjFDJCxYuo/X98CZ
/0qO0fw+O+u4HItzmKZHfz8LVhLFYuiFw77BaPfQl8CEI6rUg5Byav7jMczS/suH
8fAC2tH1NjUzsqWIlsVNXhi4gmXLdMxij3aO1ExEJr8rHY6tGQ7euQzBEzXUSJMN
rL5Lrb/1rtKtaIOsTq8tKKvse3QNtk3g/vm2t5XT84SZH6dk3Y0k61or0/78ey2l
iiDDyd7LEvCcNLculKnV3sVxIjr09u/AG+cO5oe/FwHady/XROvu/5sQC8X6KfpT
S+x3SB2nl07ntrbjIgT6nGH9AlcW2a8lvLQrSsZOl+HQz0pQgVGV93ScqB6SZVOj
K7P+YjDNKlB+Wm2xv548cuF+2h3X22B2s3UaRxM02qYryE5ScJMIoXpYy0HfSkW/
eLs3Z5RGo+SdydUDxWrj
=cY8I
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--

--===============4411436168403416214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4411436168403416214==--
