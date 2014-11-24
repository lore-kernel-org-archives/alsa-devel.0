From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/32] ASoC: wm8903: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:27:18 +0000
Message-ID: <20141124182718.GH7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-14-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2589390600809125985=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 322BB2652EE
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:29:13 +0100 (CET)
In-Reply-To: <1416746269-4935-14-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2589390600809125985==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IPaxb0UBFekg84Ij"
Content-Disposition: inline


--IPaxb0UBFekg84Ij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:30PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--IPaxb0UBFekg84Ij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3iFAAoJECTWi3JdVIfQP1gH/AjMuiKRU/sF5cgYo3Wx2J+r
j4Z3pa/JcVQyxVV0pj/Vgwp5GNx5eplOrqwYAKzzKZFuh82IZGPiMyEkhAVpfFfJ
dc7CxzrOTAVXkvre1RvS9ySSs2PEtHlgsUsoojNsdisr5VCb4Aq0Fd64AvpoxqqZ
wpz0NyrB0nZrsyV7F980MMY2A8n1RITQqJJ8wORAE8snA4z4M5W9y18zIEaDXTsy
nu01oSoePlAXQMOkKok4LgjqXoJNCGpy39yGvwJB4Xi0va4AFxvTUzVH9p6P0fP1
uDJOiinh0y62wiC92C59hdXxCMwvhPiU68ManBrxdzPq31baT2CUSNXEOdEuTyc=
=5BBe
-----END PGP SIGNATURE-----

--IPaxb0UBFekg84Ij--

--===============2589390600809125985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2589390600809125985==--
