From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Add resource managed
 snd_dmaengine_pcm_register()
Date: Mon, 25 Nov 2013 18:23:44 +0000
Message-ID: <20131125182344.GS14725@sirena.org.uk>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
 <20131125171922.GO14725@sirena.org.uk>
 <52938C20.5030906@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1800163087062008339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C91B261B08
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 19:24:03 +0100 (CET)
In-Reply-To: <52938C20.5030906@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1800163087062008339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf878oECjVTnCF6M"
Content-Disposition: inline


--Qf878oECjVTnCF6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 06:42:56PM +0100, Lars-Peter Clausen wrote:

> I didn't put it there because it has a dependency on
> SND_SOC_GENERIC_DMAENGINE_PCM. Sothe options were to either add
> ifdefery to soc-devres.c or to put the managed function in
> soc-generic-dmaengine-pcm.c.

Hrm, OK though I'd probably have gone with the ifdefs on this one.  I'll
wait for more testing anyway.

--Qf878oECjVTnCF6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk5WtAAoJELSic+t+oim96+QQAJF4hhhOGDJb7qP5ZkMB5cKW
GV5zivn+cte61QLRKWqR9PCV9dukdLPjvO8FtFbOvEfc4/9MiSa9uqwPEV5HWUEn
D8kryWmvzQA/BII3vRZiaMl/ckMG87surXAttqdvN2jYSGSHjRr/s1hhMx/ZFoO8
Aq5+kj3iHk79/w+LZjds4AQvRnOipz+fWuunf/WdvnhPRF3wlLOMNRcA09I/Tq36
ascoLAdLJM/Sv9QLQSelvkuuM4On+W7Wi7IV4Aw9XJw7VHWztIAIBpiROR+/GjCr
HHBYQe2bqP5EdrnLYtsznytJ13mtOJ2ljieC2/peLP+/L70u540JMHzAZHMzzD8e
f723ItCskFX0fsdiH5/TYmuyG/YniPfxansFY1e5sf27ucH4suYVU9j0PDOzh8Y9
U6R3nR+xiyqTLq0ffXt2/GwXCt8aDD7E0MCClrh7X4grQM+oQM+t7Nqenc7mxtlW
ypqWAbg6vIJOLU4zqUzzVBb700bDeU48HFlIIMD95WL/BCZM/7OThEc0ERJAcnr2
GyMhW0WRfJo66rrpXH6d1q3+dcU84OfoC+8gjr65jeKEylY9m0MtfkacRXG6Tojq
lESwJ6xcWzju2q8kJYtcB7MB0s83alMr+GwZj3WjYO1FMsB/knxXydn9ChsCsaP7
jMBdebngWahK1IlQZ2a6
=xdEA
-----END PGP SIGNATURE-----

--Qf878oECjVTnCF6M--

--===============1800163087062008339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1800163087062008339==--
