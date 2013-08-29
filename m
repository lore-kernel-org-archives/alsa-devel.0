From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: designware_i2s: Remove
 unnecessary dev_set_drvdata()
Date: Thu, 29 Aug 2013 13:18:44 +0100
Message-ID: <20130829121844.GA10783@sirena.org.uk>
References: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
 <1377519915-23998-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5390691080342615876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7790E26552F
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 14:18:46 +0200 (CEST)
In-Reply-To: <1377519915-23998-3-git-send-email-fabio.estevam@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5390691080342615876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L4gFVV/CladpyON8"
Content-Disposition: inline


--L4gFVV/CladpyON8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2013 at 09:25:15AM -0300, Fabio Estevam wrote:
> Driver core clears the driver data to NULL after device_release or on probe
> failure, so just remove it from here.

Applied, thanks.

--L4gFVV/CladpyON8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHzwhAAoJELSic+t+oim9lt4P/RJtDIZGJ0U07fs+1t1e9Tah
QEijRdr1A9HIP3YYLEeI9MX7aooucgfCfIkFKLd6dWCYjWwPAPZ1JCNxYEoI+HfC
8vsB8TGbEclH3CbdKPlpLvH3k6/aLg3j/rqgQUTuYuFizkn79jZGTsRFHHez/Rtu
1C37SSfwQR5221dQQXHhb0efPeHXO0uDXBQB2nS6KGnDwrRwqZVbx4oGQsQgpwM2
8HKrwFR2NCB/xaT1BCTMPzuRZJUFszCw0IeJtDJ2qQ4Sjy4eya6ZBRmQqgbLH7Yl
VnM1bm3xYvtYR992d6dfDnlBoBXGhU7nV8JitBTOjBdiG07s6pp1NR2LJQbgn3Is
49oYHlAHB+Yu0f/7n+YaIdvB1Ijd2nypDNbUAKH8zIk1PESXCTCR3BTtU58ulA2p
iW0fMXLO5J2BmQBoG57zf9bXdo1Vhf8j8iY4f3PZe9QcI2fLe8W0Kdc5pT4mSdQj
bnDzyhpiZEjGxSRiAA9RfuM9qTQNPFZjeex6W2dlbC7beOU3TL51FJccMpPH1mh4
aKbJjv3U7ZSaun3kZFxneuj4r/husblWgaOR7YMdTjUHLBW2pFC+VUFsB62/niAb
EBX0sv5cXlFheth0OsBWDcPNwyRUT7eME3xnr1UTF8F1dx+Ih5GkNFEhKtFowX5g
2Dkr9IFjzePcCKCzyyzd
=jLxo
-----END PGP SIGNATURE-----

--L4gFVV/CladpyON8--

--===============5390691080342615876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5390691080342615876==--
