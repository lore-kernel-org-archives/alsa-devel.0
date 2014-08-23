From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ac97-codec: Remove ASoC level IO
	support
Date: Sat, 23 Aug 2014 10:12:13 -0500
Message-ID: <20140823151213.GL24407@sirena.org.uk>
References: <1408784721-23501-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9191022440388278601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 323C82616F3
 for <alsa-devel@alsa-project.org>; Sat, 23 Aug 2014 17:12:33 +0200 (CEST)
In-Reply-To: <1408784721-23501-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9191022440388278601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2PFMayAIDoBVGKc"
Content-Disposition: inline


--J2PFMayAIDoBVGKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 23, 2014 at 11:05:21AM +0200, Lars-Peter Clausen wrote:
> This driver doesn't use any ASoC level IO nor does it register any controls
> or DAPM elements that require it. This means it can safely be removed.

Applied, thanks.

--J2PFMayAIDoBVGKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+K9KAAoJELSic+t+oim9ohEQAI81kl0CNGhbI12m609qqqqD
T3UhDvYuxVCqc43QM6pvckCAdvW/30NVqNbDDWXQ/Y7KpzcppNaVM1wwEC+aO1pS
TOA5d7V41g+tueVaf00dnwxYTa+33AMGH57gOqJHJakTuHRM3+MGNOxkmQbruW+l
cOKKa7s7yYZpPHwViHhIaYe47mijqhQWqsWh9fM8os2YyOdFE9dVKItOuoVmPevB
Zf4DJ0mEYZpfA9p16g4r64xWlWVUgzm29METcN3gwjGoum18qwrAPJFVeLFQm5lz
Cthh9qFrfrpaEXK7mL87iZ423dSQQJz60WxJ6m6GuENqHj6LfE7CTV1GyxWu4Afz
RxC1kJETYKfGsJD4D+Pa1Pot8OV5Vafik9JuZGGbyUkkcnDdt46hEUpR6+Ruhv4Z
/1wknKD7Z9FOdnXyDLlWcAjwcz20+yXOk5r7C+Z5YTC9JEco5JuyqXAJc5NXEIIu
sVfCf5J8xWfMhXpmgcPZZvhlF6y2mUnxWG1iGBRzuB5sC0wNB3YzlwaCLRU5ri5u
20PsODQZ3k4BRmdRG/pkeXs6WnUUETnjnuPDX2gb5Urs+JL0FpjzdStVn4bEasta
JhnasNX2l/1onFMx640B6pLI3w+1Q3PH7aq7BIQc5SlW+sforD9ZvCfIGwh3l5HS
YkXDP17Kld6zzerhqxs6
=J8o/
-----END PGP SIGNATURE-----

--J2PFMayAIDoBVGKc--

--===============9191022440388278601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9191022440388278601==--
