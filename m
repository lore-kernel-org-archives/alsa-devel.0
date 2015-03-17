From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm2200: Drop unnecessary dapm
 bias_level initialization
Date: Tue, 17 Mar 2015 12:09:53 +0000
Message-ID: <20150317120953.GG28806@sirena.org.uk>
References: <1426520397-24263-1-git-send-email-lars@metafoo.de>
 <1426520397-24263-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8697371414852018844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA2DE261B35
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 13:10:00 +0100 (CET)
In-Reply-To: <1426520397-24263-2-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============8697371414852018844==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hzEylbkGUV43Aca1"
Content-Disposition: inline


--hzEylbkGUV43Aca1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2015 at 04:39:57PM +0100, Lars-Peter Clausen wrote:
> The default value for the bias_level is SND_SOC_BIAS_OFF when probe is being
> called, there is no need to initialize it explicitly.

Applied, thanks.

--hzEylbkGUV43Aca1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCBmQAAoJECTWi3JdVIfQOo4H/jBA9Ed6gRfhkCtL6ZQ7AZ5V
TxHfV6supPtIC85QgkYqcbRql+w32OLoUpojfK3RMv+5GIaqDSlc5EAjtHMoo6Az
vZKA2iNiTmwpjGezIZrhCbeVxG3XHwwlJ2/bCrB5y0nL2iv6oaoO0NNzgbKEOyy/
OHPrNW1+ymvKnXFrmtPB/tPLd4uU4tngXGHR1boYSt1XJuYSHI89TrfJA/RiVBQZ
hJ5XGVPVCq6OSoZFEUhzVT/KaFJGmISX6zP8RBb/jh6A7vr/bAlK46jBO66OWQ4l
/Sr8gX3UPsqpH5/aVLAb/QUTAlHJfoyW+5as11Z1cYMjxNWkfGKmul3lEqhnKts=
=AzXw
-----END PGP SIGNATURE-----

--hzEylbkGUV43Aca1--

--===============8697371414852018844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8697371414852018844==--
