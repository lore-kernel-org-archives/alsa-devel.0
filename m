From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 03/13] ASoC: avoid duplicated DAI routes
Date: Mon, 5 Aug 2013 17:18:39 +0100
Message-ID: <20130805161839.GQ9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63uN-0004lL-7q@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0486438258386324391=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8800E265020
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 18:18:43 +0200 (CEST)
In-Reply-To: <E1V63uN-0004lL-7q@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0486438258386324391==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bW5yMaABVFayrz/W"
Content-Disposition: inline


--bW5yMaABVFayrz/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:24:03PM +0100, Russell King wrote:
> ASoC automatically creates snd_soc_dapm_dai_in and snd_soc_dapm_dai_out
> widgets for DAI drivers, and adds them to the list.  Later on, ASoC
> creates automatic routes between these widgets and a widget with a
> stream name.

Applied, thanks.  It's possible to do this a bit more neatly for example
by checking the direction of the link but this works and fixes the
problem, we can always improve it further later.

--bW5yMaABVFayrz/W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9BcAAoJELSic+t+oim9rPoP/jg3RwfViQLQgu7v+1ntDLDN
2+VfrzC7GRaF8ImVdmrktqmIej9zGpK/nMz4jBJUi1CB0T+p4o0b4dKrUZTiroge
oHToscoZSVWfiZjgCnTtj+xglnnanqfw6hHHtczR3JG8DePjJxRUiwDklpqEZhGt
L3DK6b0XS+SqaGMx/NJVD7VO9hvNRndZ3Tw96V0bEz6gg8OvPU40+BGJeBhOKEkP
Dtsp9tAd4noer3HrHbRtaLg3HIUFSa17d/ris/1HN0Z1PDKyvcrFKaGLOhBU/8XK
sDLlmDrMO2sHR9xHhLEIEBQSUB7O/RbUduk2Ogz1bjaPhfFxAsfBtG+HKuVXF5W+
LKWcCMkpyy8DNBieKcxyC0DMSN6zdmvvrnLaV04OdbJ4zpYs/kAcgjjb4G7vUEH7
M1pV23l68F3mbIx9Q8K3alpL+KCyQOGk21cLjOEua4qWobqUG+iVjUpD6GLvlmSO
9fnjJalH1EpCktV+w2O0mhegorcaVdHnvG9duNJJ/cn3inxq1/8+57pmM0MqwLwi
fD6OWxNrnuW2DCdwnhAVeLU0b/1eQPvuhTJyvUoJP9oTY4YJg+38Jenxz9qsty70
6L5wTJBHGAxTD5dRaWpQ7RSNWtTvzkiwW3R0si3nVCZ0OhoSNfjofun9teT1uDnO
91XN7Q4KX8rVk1wDJ1h5
=yc2P
-----END PGP SIGNATURE-----

--bW5yMaABVFayrz/W--

--===============0486438258386324391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0486438258386324391==--
