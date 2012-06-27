From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Remove const attribute from
 lm49453's snd_soc_dai_driver
Date: Wed, 27 Jun 2012 12:44:59 +0100
Message-ID: <20120627114458.GH308@opensource.wolfsonmicro.com>
References: <1340782476-5626-1-git-send-email-zonque@gmail.com>
	<20120627101751.GA308@opensource.wolfsonmicro.com>
	<s5hwr2trqzd.wl%tiwai@suse.de>
	<20120627111120.GC308@opensource.wolfsonmicro.com>
	<s5hpq8lrnjr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7651600232279288486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A854103F9E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 13:45:00 +0200 (CEST)
In-Reply-To: <s5hpq8lrnjr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mr.swami.reddy@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7651600232279288486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2012 at 01:39:52PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It's fixed in -next, not in for-3.5.  I guess I'll pick the change over
> > at some point.

> Ideally, such a problem should have been fixed for 3.5 by just
> removing const, and add const again once after ASoC core is changed
> for 3.6.  But I've been ignoring this warning since it's certainly no
> big issue.

The fix in -next is to remove the const, it's not simply a case of
adding the const in the core as we currently fiddle with the ops structs
to add default ops (which we shouldn't do).

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6vIZAAoJEBus8iNuMP3d3IIP/imOvTsGeuUGK1roGhBrEZE2
SNYJ2q7GBKS+lWH58/CGFjRkGhEyAvu/vKofahiIwpQWJQ0oJe6I4jLBRu9+NCD7
S+kDsfUZsDujbY7Q+tySfnmbRcDuYfs2yI1PhrUS2PbAFeikRD64XtZWcBOPiKqg
gB9Dhxar1xKZcTlKuzyyPYDZ5AezhaRf9Pa7stZn3E/VN8Ybtrem3HKlqlwMzqK8
OZuRjLqA/S+G+EA76SzKK+eOR8yiq8I4iSwdhM1DtUJxjDkI/6Xm9KQEkTXD7RLq
N8RRJ/gwjmjzJwso/KdkLGb42yEKZr7Nph2Ftax5m7SXpcOA2sPujVKMwHixde4x
xPT86B5uc3g90Q8w7cP24PoewZUAwCFHUCNuvlPkuim4UqEeCcIhlnsIY7ZQW+YH
LXy5Ew4xyiuHIUcH42CVM3mpQamfSt1tmSQRYGiT6o9OueZXZfSSMPLiyQPHw1S4
D+jIt0s+4IBjeF8Y79OwXWhUW2XFjhQYsoNMb4w9oU4bdNLIyqa/LCgDN80I+XDR
Cx9BkEynkw0kuTQ6rMwaZ94sByw4TGeQTvoj5z45CsIyQY1U9ZssC9tY26fUIYNu
tJ0GDoW4JkyH0m6ItCQiQSUTz6qbrpe1F0y1yQvdKz4wyilhPB1le7l8S4BBcKQT
TDzr3haFFmnCcjG7rLDf
=B9wm
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--

--===============7651600232279288486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7651600232279288486==--
