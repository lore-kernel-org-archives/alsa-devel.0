From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: pxa2xx-ac97: prepare and
	unprepare the clocks
Date: Mon, 9 Jun 2014 21:11:56 +0100
Message-ID: <20140609201156.GO5099@sirena.org.uk>
References: <1402343952-1287-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7580342473000542381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E590265173
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:12:17 +0200 (CEST)
In-Reply-To: <1402343952-1287-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7580342473000542381==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fW6jlebSFjIjuLDN"
Content-Disposition: inline


--fW6jlebSFjIjuLDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2014 at 09:59:12PM +0200, Robert Jarzmik wrote:
> Add the clock prepare and unprepare call to the driver initialization
> phase. This will remove a warning once the PXA architecture is migrated
> to the clock infrastructure.

Applied, please use subject lines matching the usual style for the
subsystem.

--fW6jlebSFjIjuLDN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhUJAAoJELSic+t+oim9q10P/2lsp428Q2bCOU2sKQp/90Jm
t4INGNJwgq9MzF3Gv6xuGakiK2WQ/X2triVLDW1phBZ6p/7kfKa2nT3HCtKmBktM
TCT2TdEoX3UzdexDODjT6H5NSxwcrZdkq10t9/xQ1sjYVNOzXVm5DtkOnDPkXyke
L4AejmJDA/WOgwprctNCGq5M19edkNVo7XxeEfJldhqWImkj+Y7didQeTJ/IN4Cc
2VY6+NPJtiul1O96/JBOcuaIZ45vYCDpGuoaPVSAxURMiOXIPtYNl73Os66vEpsl
gaThVxLvXx7fq4ITy//9XOph1dCNBikDYJf+Ad3I5nTS2G0Lh+ym9eJQk9UzVCUe
+f3+zz+KYLhYcFOGKvA94u5Hz+G7QuYaL9/5q3T1fELoTv5eiSQ0rY+t8+9tZT1h
2Ie5V6/kHjWZyO6rzk5HOKEJ9JMiSlWYW3L8yH0M/fME2JjTWFM8Ti+U4P8BoyyR
mAac9XE1PGAIH4zcvKbCw8IpfIMsOs4GhdfbJLaXj1h89h538htbJF5HC9cxVih+
Yjce6D3tGWHcmK5XX0zOqzzDAiM/W+y5BkllY+u65SWB60+YaOm6ZRpqZ1dtT8vH
ItMIIgZbTBclXoOC9YxaHA8EYawB0Lt0oRhLovtWa1d1BxJbeltUDzpTv3zNmaag
3p7/2O2cbsjfkpJTe/eb
=Geqb
-----END PGP SIGNATURE-----

--fW6jlebSFjIjuLDN--

--===============7580342473000542381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7580342473000542381==--
