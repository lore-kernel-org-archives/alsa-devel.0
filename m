From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 28/32] ASoC: wm8995: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:41:26 +0000
Message-ID: <20141124184126.GV7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-28-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3364183189625962255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76CAD26536C
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:43:33 +0100 (CET)
In-Reply-To: <1416746269-4935-28-git-send-email-lars@metafoo.de>
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


--===============3364183189625962255==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DS29MnVNPmky9ZU5"
Content-Disposition: inline


--DS29MnVNPmky9ZU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:44PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.

Applied, thanks.

--DS29MnVNPmky9ZU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3vVAAoJECTWi3JdVIfQpR8H/3+7HS+qzc1CCCMGQiOZWwp+
ZRfGlWsbmyeGmkrDo8acyMb//fDgIAtA3uvigFcR58OXPnw8LJHKQyWATciiSZr5
x0+BPZcbbYcL1TDTia8YjPt8TFz9j489Nhr49cE++/Ennsw7NvVpLT6j8zay2zYq
wRVzkqwvKu5fTisUfiv9msQkeyQsIuQoSJUV4AVNeJsj4JidvrOcpAnwbPcr3hpe
i9dk3qzyheZxXxOe1yZxaqn1yVGuqFXA8FQccs2/DlWAQWbv0fyri+XVY5LJiMC2
nUSV+q2DqYLDy9GNzxNbrwKQOraPhM1xXWoEaGcty9+Imk9P8Nq82gs4EEgKsLw=
=ezRm
-----END PGP SIGNATURE-----

--DS29MnVNPmky9ZU5--

--===============3364183189625962255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3364183189625962255==--
