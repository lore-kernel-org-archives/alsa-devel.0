From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with snd_soc_suspend
Date: Mon, 14 May 2012 09:34:31 +0100
Message-ID: <20120514083430.GG31985@opensource.wolfsonmicro.com>
References: <4FB0A685.3040408@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8125797958586943581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73FB42494E
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 10:34:45 +0200 (CEST)
In-Reply-To: <4FB0A685.3040408@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8125797958586943581==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 13, 2012 at 11:30:29PM -0700, Patrick Lai wrote:

> that as system attempts to enter suspend while DAILINK X is active,
> snd_soc_suspend() calls snd_soc_dapm_stream_event(
> SND_SOC_DAPM_STREAM_SUSPEND) on inactive DAILINK Y since DAILINK Y
> ignore flag is not set. Consequently, CODEC widgets get powered off
> even though they should remain powered for DAILINK X.

This sounds like expected behaviour, if the widgets aren't marked as
ignoring suspend then they will be suspended.

> 1. Should soc-core check if CODEC DAI is active beside checking
> ignore_suspend flag before calling snd_soc_dapm_stream_event()?
> I checked latest soc-core.c from kernel 3.4 RC7. The logic is the same
> as 3.0

No, the whole point here is to suspend.  If we did that we'd never
suspend any active streams.

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsMOOAAoJEBus8iNuMP3dF9cQAJvugGG13EtBKCXEspCHSvCr
k9WIA20dybtSuae+Rr/MFasRdQ82ikvAT54tpziBaYTDgZ4tjtnuiYGeIk+RF0A5
NO+GWhZH4mLoRi2fYSmnVaChlewIOcoeWpdlc9QBAVcT+6mNIinLLD2m/NcSLXyC
1Lt4Vrp1jiVnGVPgmxHtg9MYfTYUPdO1QOkIvvakQSKxAkRwKEkvRtk9cnWMJisT
sQV+ItcUCRGE+6ck1wTbYurjml5N4YFpmSRPTvpspvY01eF2Rn730JZDyabV+uwf
Zic7J3nsZqpWOtl8tfJJF8B5k8IhZfrhbogslaiT8BBOs0lhNwBxhFYEMvSZsIN5
jKUkEq/7h2fN+EWdy42NaXAleR01IcH+TNlYMH/jjX1Qd1feLYscR9gqXLLZXm5y
7umJM/90QT4aSamnNv+ItBIgJlwpQzhxYIMzFj8PupsLLHFUx/x1OFr9KfmuCiDs
efDHwAzRP10Pj/XsuGQ1YsgOzJ2CB5bvDwGmPATSzh9BnOBYVzHcCA13sRJis4I7
tSDIOuYSTC3wT+0ZGRTtSOV58tjLhlC7UednEC4Ejl7UnSYlnrdZslW76il6gg3f
raacx5o+33tZgep+qncEMHitEs6nCIUdTUokOBawLdPi9wptB6ECagdLmCzGKRph
hQwu+K8hEucP6TCNM2x/
=ADPR
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--

--===============8125797958586943581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8125797958586943581==--
