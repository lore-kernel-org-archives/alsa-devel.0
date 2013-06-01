From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8994: fix the codec state
	machine
Date: Sat, 1 Jun 2013 19:55:21 +0100
Message-ID: <20130601185521.GG16790@sirena.org.uk>
References: <1369930931-9635-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0672274553881891321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DA51261ACF
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 20:55:31 +0200 (CEST)
In-Reply-To: <1369930931-9635-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0672274553881891321==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2013 at 09:52:10PM +0530, Vinod Koul wrote:
> few places the mic_detecting is not updated correctly when state changes,
> causing jack detection to go wrong

This doesn't apply against current code.

> @@ -3696,6 +3697,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
>  	/* Since we only report deltas force an update, ensures we
>  	 * avoid bootstrapping issues with the core. */
>  	snd_soc_jack_report(wm8994->micdet[0].jack, 0, 0);
> +	wm8994->mic_detecting = true;

This doesn't look right, as the comment says the report there isn't a
real report it's just a kick to the core.  We only want to start looking
for a mic if something changed to make that a good idea or on init.

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqkOWAAoJELSic+t+oim92fgQAI0aM4TgpLzspzIWWZNNOq9m
EAbDKe5UNjPNVNkIey5hCtKDGWNseIPB1k2LuE4eiApZmIY4p4JEneInTvr0tgDX
j6wMgF7wU+GhqyNPwcRa9C5W2NF75PnN33h+lf5usJY7OLgOCEybxHu+bKyByzNi
fQ/m0QhnhHG+58Ww6lLVnlYNWoZgZqMAjK5lCymmilW8mKWSTLOuNeGqpMVTtulM
3IIlN85sJNo58qNb97LB1ctqzpaYsH8AlORn5jlfTxE8b2hDZ2LkvyMUa1SmuQSc
zUgXgkAiCNAqPLiBDw1NPEp/3WvRC957kqv/MdJam0bSHJCQ6o43lpNcJl0jGk1k
3jLAzp6zNLyxxc2yxMm4uE1PqJ5AybBykWEkNnxxvyhsa8A4tGjQr15B1A8HsyA3
lsbl9rXmMmeDgKO521WWrNFOkep09dEWPtYaApa9NU+4J12YmVGeIrGiZk/unYrG
hlsrLgbdXcz3laonb53GOLslQ5iGENlbyRTR2wMsfuRPDhnm0S1E9ZIuV3JVxeIh
EEDO7XDrXOQbXtza4AnIaHJj5EwkaDsAb/LgSmlzMLjbinXAX/U+iKEA5CnZohwr
G0u1bNJ4qu8jQy5cfs6an11eRiSrjNUawAzqFVtIG68FQ2fRPbMGlOXrJHPbiwb6
8m5Fo96c6MXEEr6TN3AB
=4ux9
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--

--===============0672274553881891321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0672274553881891321==--
