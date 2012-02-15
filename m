From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add direct mapping
	between DAIs and DAPM
Date: Wed, 15 Feb 2012 08:24:13 -0800
Message-ID: <20120215162412.GG2996@opensource.wolfsonmicro.com>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7753587819672433738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1CF81039B9
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 17:24:17 +0100 (CET)
In-Reply-To: <1329321775-21082-1-git-send-email-lrg@ti.com>
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


--===============7753587819672433738==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2012 at 04:02:54PM +0000, Liam Girdwood wrote:
> Currently we map DAI streams to DAPM widgets based on a string stream name.
> This can lead to some limitations when working with lots of DAI links as there
> is a risk of naming collision with similar stream names.

> This patch creates a 1:N mapping between a DAI and it's DAPM widgets. It's
> still string based, but we now directly reference the widget names with
> the DAI and bind the DAI to the widget ptrs at initialisation. The binding
> also tales into consideration the parent codec or platform that the DAI and
> widget belong to so that we can easily support multiple components with
> the same widget names.

> This patch still works in conjunction with the stream based events, but it
> is intended to eventually replace the DAI stream name.

I was thinking about something close to this myself as part of the
CODEC<->CODEC automatic DAPM stuff I keep mentioning.  In order to make
that work what I was going to do was instead of mapping the widgets
directly onto the DAI was to add a DAPM widget that represented the
stream and link the DAI to that, probably created automatically from the
DAI definition.  We'd then have the DAIs sitting in the DAPM graph and
it gets much simpler to just connect the playback DAI on one device to
the capture device on another (and vice versa).

In terms of the API and end result it's pretty similar to what you've
got here except it'd probably end up with the DAI<->widget links
specified through the DAPM map.  What do you think?  I'd rather not
churn the API more often than we have to.

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9wlAAoJEBus8iNuMP3daYUP/i3Qy/EmWZHiMAGmcmS7okB/
b5io++Y4W4w+wD/7Gp7LsnIvrR+0ehAbdVM0KfIqw/xAKnY5AidHuTYqH70vA4xL
h/P3hKmkf7BJcSmsiIOGwCITai8h2SvbRQRXGtb3qHUaJ/aI3eKUzYiPsm+LlWus
P+jfnwhvuPxxeGSGwCG4V9Hyi8Wme0GIKI04rQnO7X8KMf7p1DTQISNK1gYx2kV6
BeDNeU4USnhicPBSokxx3tthXBlsILTYk5alwWen4uW6dhMMsThUUL/z/WOPysOs
Ri/u0sNqZohMldsv6CJ40tA/mGKuJz423qErZln7liKHgI7pkvRjeY6ZCpu7A67G
gglCjhSHcaRMwcbTd7Ov28pweIINPTHd3yZlQF1gxKFlKr1uauTKP7KK9djRmVBE
UfLDI0uIGc+00Dij7I9wl+dbDskDA7xq+VeQwgJZAOrBuLqnDSduCNOxZkpYu0c5
6YFtHuyMstfi237lDJm2VVg9V87JysfYNbDJLdcWyow1pveK4xX6qHU+JDg1RwXO
VscmqBsQvC16HAOXJaLEvr27xARveyBTImFbyfVcYmLWmufNNr1CGQIRtSaJzuAh
3vL4IAwL1MULZ4oRTyP8kviPiKP3TcGhevUBfOSsg8aehH97DjbsvjZ2ON3h7Hmv
9dCeZsToh0Om01nMQDLR
=6Kms
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--

--===============7753587819672433738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7753587819672433738==--
