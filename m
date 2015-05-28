From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: ts3a227e: use device property api
Date: Thu, 28 May 2015 10:29:44 +0100
Message-ID: <20150528092944.GS21577@sirena.org.uk>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
 <1432684686-14460-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7580511209247360145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A32232604A7
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 11:29:49 +0200 (CEST)
In-Reply-To: <1432684686-14460-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============7580511209247360145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ZWebnVuwrdgwVag"
Content-Disposition: inline


--0ZWebnVuwrdgwVag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 04:58:05PM -0700, yang.a.fang@intel.com wrote:

> -static int ts3a227e_parse_dt(struct ts3a227e *ts3a227e, struct device_node *np)
> +static int ts3a227e_parse_dt(struct ts3a227e *ts3a227e, struct device *dev)

You should rename the function - it's not just parsing DT, it's also
parsing ACPI (and any other firmware interface that comes along) now.

--0ZWebnVuwrdgwVag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZuAHAAoJECTWi3JdVIfQ4aUH/i0iRPzpd1JTn4NpsxMgRYBz
wA8VwcKTvL9nQxxW22grfWgRbr1QTkX4F8fXU2O/D+/onGUGIjXeZakBsTYUNZcA
TTchDlT0TzxcOLj66FMiqRccL2cPN8rju1w+SA0bS3caedzi6djZjqDf8Ou3g6Ge
8tjCgm65EW6eRLU3nuL+UCZCiVjUdc1RPY4O/GyeVjDdIMO5Es2GOWekkg52q7lx
vrIroz6xE0WpSDhFAJkVCXnwYTqCp9/z+oh9ficENrmSR6llqwBNodRkvX/HW5ci
6L+27VJbOQRG1RSZOze/P9MXU8laQDd9q62v4FTTkWi/fGodYJKosJKtx69FRi0=
=t3PO
-----END PGP SIGNATURE-----

--0ZWebnVuwrdgwVag--

--===============7580511209247360145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7580511209247360145==--
