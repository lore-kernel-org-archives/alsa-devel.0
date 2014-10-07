From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: mc13783: Fix of_node_put() call
 with uninitialized object
Date: Tue, 7 Oct 2014 18:09:38 +0100
Message-ID: <20141007170938.GM4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5592098026086655752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AFEB26059E
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 19:09:52 +0200 (CEST)
In-Reply-To: <1412698794-25536-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5592098026086655752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="np3HfElajyDBpWGr"
Content-Disposition: inline


--np3HfElajyDBpWGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 06:19:51PM +0200, Takashi Iwai wrote:

> -	struct device_node *np;
> +	struct device_node *np = NULL;

No, unconditional initialisations like this are worse than the problem
they're trying to fix.

--np3HfElajyDBpWGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNB5RAAoJECTWi3JdVIfQyaQH/2cdxi7wGOEC4TnDB6gVTPMf
tmY9d7voV6AD90x6yf+B/LyNlUZsX3vU8hIRvTmQTyf4T4lZRf8OOmM8eEXChHUu
PytjLB1l/04WkU6pQntN7joBjP9wWiov0S8WdiMdBrDK5wkPolpdskGVwKzTAJm4
pS6vvgyCBl4mVUpPoYWc8V41yFrxeLiRoMvMhUq5gXkf1BuDhiFkp/OrqdpzhUrW
CkJ2N12augWTI1E+CfM1pUp2lHL3fajd/GgRri15n+UQptMmbBaP8uiCbABZGmId
RTvCMkeCMN0XBedcC7AlFvFx2xMNQHlEo3z7khelY4JI+J9F3o+exlGebYYCfpE=
=in7f
-----END PGP SIGNATURE-----

--np3HfElajyDBpWGr--

--===============5592098026086655752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5592098026086655752==--
