From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 002/102] ASoC: twl4030: Clean up duplicated
	code
Date: Thu, 20 Feb 2014 10:45:25 +0900
Message-ID: <20140220014525.GQ2669@sirena.org.uk>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
 <1392722967-12472-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2428360342187362162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B6A2265708
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:50:17 +0100 (CET)
In-Reply-To: <1392722967-12472-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2428360342187362162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVQxcGJfgL0abYBJ"
Content-Disposition: inline


--kVQxcGJfgL0abYBJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:29:26PM +0100, Takashi Iwai wrote:
> Remove the open code in snd_soc_put_twl4030_opmode_enum_double() but
> just call snd_soc_put_enum_double() instead, which does the very same
> thing (even correctly with a lock).

Applied, thanks.

--kVQxcGJfgL0abYBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBV4yAAoJELSic+t+oim98E0P+we6wNwbWmS4f7UK0zf/FFAn
KWmzET+bvF5RRewzOLQ12+SmepUigkPmBIaoYnddCGrAXWcNY+9eMJulqaV02ygF
7bg836SOGoCEvriKnL7HyjtEMJYyr7W0K7kOqufxOBp1rAWf+sTPkFygdk5dw5L6
YBMD99kjQFVgFTHpt+zPwQNz/DGupvATA0fybWYp8YbE3yTAMlETxU7HE4BiBMwp
OD68oJnuakXaj9tMeUYmxeTEUvoRBpou517nHuL3vK5jWVzqQNmmVc4AEhBLNK7I
aZbVizo9smcopRBEOevMoc8Uznx6VvcdNZv1yfPRrg7ZkiwewmNdVrh07RHvk/T8
KaWculASsp1ihejhyrA0jagvHVpTwHrf9H6xmNNaNBp2W0J0Crp/x5syhzAqVP/H
KfZPl1ldcrXrfJpYRn5BAQrOSGuHSsfnoY+HEFi7jBQ4hQ0TKj33AzvZdYkreIsm
wmAT0V51lmtrHAm3nQHdiihNZ6zXCiGqnXcQ2O8kJC3HpPAuiVpvnpnpEumVKy3+
3iTxsZ728mh7kEziyRuaCGzMJtPsbCCvowFDVGTmUpvYaaEnKDS5SmoWDz02RFRK
yOKUDCT6ulpZyaSUR98ZULWU4Wk7TO+uyYST6Oy9IGIEgZWP4/Z/sVEUQpPcuzUo
af3msI5fWiS/Biggt3Ao
=uQmG
-----END PGP SIGNATURE-----

--kVQxcGJfgL0abYBJ--

--===============2428360342187362162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2428360342187362162==--
