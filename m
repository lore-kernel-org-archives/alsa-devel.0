From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/5] ARM: AT91: DTS: sam9x5: add SSC DMA
	parameters
Date: Tue, 9 Jul 2013 10:32:54 +0100
Message-ID: <20130709093254.GP27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-3-git-send-email-richard.genoud@gmail.com>
 <20130708150756.GL27646@sirena.org.uk>
 <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1478998154780396803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D2EE2265535
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 11:33:25 +0200 (CEST)
In-Reply-To: <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1478998154780396803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EUDem5LXuWmN7o17"
Content-Disposition: inline


--EUDem5LXuWmN7o17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2013 at 10:27:53AM +0200, Richard Genoud wrote:

> The dma binding is documented here
> Documentation/devicetree/bindings/dma/atmel-dma.txt
> But you're right, I shoud update
> Documentation/devicetree/bindings/misc/atmel-ssc.txt.

No, you need to write a binding for this machine driver - the DMA and
SSC need to be documented as well but so too does the audio driver that
pulls them together with the CODEC.

--EUDem5LXuWmN7o17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR29jDAAoJELSic+t+oim9cmIP/RAxGp3/rYPkR+5ylPr5QwHx
37a41xfKZopAh6+tcoWmlta8CpZHs3nvSiTm2PwJeRTDQI8WHpPyxWsNRhc1jkb6
S/irWhNlDmg6VD+awTfdcob2dhYgKiuPpt0kgq7oGeKJABO2WPwmZzb4lpLUf6du
S0wMgJMYZkI9376s3a9jshe6xkPKIR1RLmQltJhxjiSu/PtiPHuDTTKrTcwLlwDH
MZURxMSwTGwVM5dJx9NlVRsf/vQ9bVt+8PndTr81eIa8z8pTz7ZmdbiIwOJRlIoH
aZONwTGH+YjKQi2hvGjIFPGA/RPxdEnOcHZyJ//MubAyIK7U1Ua1Ly3/3+CDG0Ac
rXvCgjkfx9KrMNLSKHJ+oF/kT1O0iF9NkTVP9EeYTeWXFYfrONekjFOUTt9F34e/
+regD085Z3h/JJxMOIF+IwWwGGux0hT8pOZ8ulqBXrHcU7RZWSGeHRNJsIzUBKE7
BL0ejsj52gSzSq5D3++Kjl1yooH3W15aP50wXYmws6a92L6EkdVdsRzMFgnD/8Wv
3Ylyttd88Pq/p8K9kwYZzO8M/Umj8xs6C5dwUC9dKb1aMoUbWHT+tR5/vLIZgMLz
E99bMsqJtEoWDJV6nJbthXGpKV+rLNz8iVLODG9ihL6Dt5rU3n19wfSQKDLxXczW
Gp8X2ihFKNB/C9I6GvwW
=0Zv1
-----END PGP SIGNATURE-----

--EUDem5LXuWmN7o17--

--===============1478998154780396803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1478998154780396803==--
