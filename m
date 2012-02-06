From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DAPM - Export
 mixer|mux_update_power() to public API.
Date: Mon, 6 Feb 2012 13:40:25 +0000
Message-ID: <20120206134025.GI3070@opensource.wolfsonmicro.com>
References: <1328535135-8765-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7597845990219692831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21CBD103AE9
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 14:40:28 +0100 (CET)
In-Reply-To: <1328535135-8765-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7597845990219692831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 01:32:15PM +0000, Liam Girdwood wrote:

> +int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
> +				 struct snd_kcontrol *kcontrol, int change,
> +				 int mux, struct soc_enum *e);

We should get rid of the change parameter before exporting this, we've
already got all the conditionals in the callers so it never gets called
without change being set and any users should be doing the same thing.

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL9hCAAoJEBus8iNuMP3dJSMP/jXsnxiXefnK55iwPLKseL5f
V+v3VX3MYhO1oui6KsS78OQu3mBtdhpnCo0DYA+acCpI8K3umTc4wCc9XyV88X9L
sa78oU0N/px72cISDqL45pRfbBPjxxpU2bBhW9+DIHHPsdjKb3knb5kdGh24TIcN
Z929pOyb72KDKZFFV+Uz9wXd1hgLmUcknEwam5ZrC6E96m/DULv5jek0shvwNQi2
O036kCKut0D5eLNKX8MuMWFpM3vXhrrcIeHPlztFYq0lbIR0ODr/Hobmt3G2yI8Z
w0Mc5Ahp4vtlHICS/jwwxlGzBXtm0z6zDvXdiQ9ywYLK7rIwAVOV/nmQOrHsn1HJ
gYVObWwT0XevFX5WHRLO97SyUrLBGJtr1Hh80AZvYgC4XHwc1bdAnt4ezPluChT7
0XBj1tuF+lCqKgVH0EKh8GtJyRkgpsoCy444tMMAXbR7pMhfxdFRzAMMJ3BXiAeI
/jfdTxZdf9Rzj9JqV6LW7LtWbk27Q9rWSHKVhgOG1JUVO30vHWYTaLcqPh0uZrLv
6nFL+2baoM4obCthyqXyWC6QY232drwN3STRaUZdUmwjl05PE8Ue+RkeWXzfZtGT
aa6w7ee8vCae5d9idudNGitYaPSrKNwrpsa5mcHiUcUML8NkiH/yie5nMdCIvx4/
2CYa7ZuV7BLr+aO7n5yX
=7wUZ
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--

--===============7597845990219692831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7597845990219692831==--
