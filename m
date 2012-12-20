From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pcm: allow backend hardware to be
 freed in pause state
Date: Thu, 20 Dec 2012 16:00:16 +0000
Message-ID: <20121220160015.GE4985@opensource.wolfsonmicro.com>
References: <1355974562-21537-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2171828158196525582=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DB21261614
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 17:00:17 +0100 (CET)
In-Reply-To: <1355974562-21537-1-git-send-email-plai@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2171828158196525582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YLwdFo+Xu6B7B0Yp"
Content-Disposition: inline


--YLwdFo+Xu6B7B0Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2012 at 07:36:02PM -0800, Patrick Lai wrote:
> When front-end PCM session is in paused state, back-end
> PCM session will be put in paused state as well if given
> front-end PCM session is the only client of given back-end.
> Then, application closes front-end PCM session, DPCM
> framework will not allow back-end enters HW_FREE state
> so back-end will never get shutdown completely.

Applied, thanks.

--YLwdFo+Xu6B7B0Yp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0zYIAAoJELSic+t+oim91tIP/348Tx9e7EUv9T0NjD3MN9H6
alVfKdARJQ5c5gKo4idcUM7lDubR4kiA+cnNwJLpIWMRImGiIuSr6i3XDt5Naz70
kJ0A1V0P4O2pLP1UMg2aKYzQ6zCEagwum9MiJrPAvm1SB8omFPml002OXkE/EPlg
JqrGv+z5rKN2InO6woRTO5FZKisb3SMSWJFf6V3hdNCMBcNU6UOroq/ToIXt5bHw
XDa6F1PGCGdj4a6bvG115hruYkxvKLtSJZdrReT+gGWI90O62yOOXUDX6POB6Yku
Oe50v7lxuR3mP+ZeZPIMMm1XaYBP/FIv8+4Z1q271r/8yvyNNRb915gP7/DXdb9t
/r1NrCWh3OnvZ2fU1FemTHNY3Esr9oBJXatW1WLlykQ1E0MmuRKcAFwVzroBLRwX
yFbjzU97a18siMjtJY+d7CE1UHu8FOISkoWjooBNwLgT5G8Ju9u5KetEvpQNROiI
3joZPjIqcrlpnd9eGpz/tmVU2qYiPfWDAzn/EES7UILVa5++T4vq6yHhMXN4iOTY
9KTuRlbT+BbDJVCwsgjNIpMN7NwSPPUnGCh4hfhA08ykTTFO0gWmxhKev9m4YbZp
J0xGPaayImDwzAIiBlHrOmeuMn6tcj84sclKc+jH6T0NOJpObns3OlOetnjv9hb6
OIo6MI2Mnsis2lJlwmRC
=Jsx+
-----END PGP SIGNATURE-----

--YLwdFo+Xu6B7B0Yp--

--===============2171828158196525582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2171828158196525582==--
