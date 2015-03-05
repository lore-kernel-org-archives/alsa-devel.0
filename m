From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Thu, 5 Mar 2015 11:38:46 +0000
Message-ID: <20150305113846.GI21293@sirena.org.uk>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303150742.GZ21293@sirena.org.uk> <54F6DA94.2000702@ti.com>
 <20150304113004.GJ21293@sirena.org.uk> <54F6ED24.9060907@ti.com>
 <20150304171357.GP21293@sirena.org.uk> <54F83516.7010603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6384180765500852007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50618260481
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 12:38:53 +0100 (CET)
In-Reply-To: <54F83516.7010603@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6384180765500852007==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pVwHbKIQz3zWQZSU"
Content-Disposition: inline


--pVwHbKIQz3zWQZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2015 at 12:51:02PM +0200, Peter Ujfalusi wrote:

> Yes, it is possible to add a bool for this, but I don't really see the point
> of duplicating the dai->active within the mcasp private data.

That's assuming that the runtime PM state maps completely onto the DAI
being active.  That may be true right now but it seems like it'd be more
robust to not make that assumption.

--pVwHbKIQz3zWQZSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+EBFAAoJECTWi3JdVIfQQ64H/iVIj9Y4gEaaAKFY8AiC6uB/
AQWCJlDg2jFxxLmjI6kYqVhhSQuF6QUCN0qrbiR0M5e168izgw8IJthk541u/gYo
G/awvCrvcsQRgiVya7W6aGtuYjPp/3r1cjtCyfrdqMc2c70c/p4w2LACvzgBR/fM
gp3mAhCLLBo2A59x/AzXstTryZW2uyvSrjsR3fc9NWQfD786VytSEiuBAszqzxzY
7Gma3+CKCa1G/J4SiIyYrQdz3UPYgTDDwYUIzk9iLWlspe8HCN4f/AvjkTW5XBle
eZ2jHz0zXwOEvpiDaVTYXcqkpsE3R4ZTVl5phq24/az4wSwMQn22IBwBjYjgzsM=
=GwPx
-----END PGP SIGNATURE-----

--pVwHbKIQz3zWQZSU--

--===============6384180765500852007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6384180765500852007==--
