From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dapm_widget_power_read_file() symmetry issue?
Date: Tue, 5 Jun 2012 17:46:04 +0100
Message-ID: <20120605164603.GB14958@opensource.wolfsonmicro.com>
References: <4FCD393D.3040205@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6656293561249635620=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A515410439A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 18:46:05 +0200 (CEST)
In-Reply-To: <4FCD393D.3040205@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6656293561249635620==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 04:39:57PM -0600, Stephen Warren wrote:

> > 	list_for_each_entry(p, &w->sinks, list_source) {
> > 		if (p->connected && !p->connected(w, p->sink))
> > 			continue;

> Should that last call to p->connected() be p->connected(p->source, w),
> since the function's parameters are (source, sink)?

Probably, yes.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzje0AAoJEBus8iNuMP3diXwP+wcmsyh63+4luGRxNylgZ8QG
7Nuwk+rpPwcTc4PrsVkedbTlDBh3L83tQx7UAa3HamIPg1drWk2zx2u4OXzrlZBW
yzP9ObneaXS5Mn7t29Zyitxi63M/bPingNPivmBLS087lSdQJhruZx80Pb+8ycpT
nF5trD8vlunksr4ulVwaDelQVsty7FzvU5J0bWbikPKG54YbDHy9eBwq2efwRQ/q
1El3FbsYu7277zbgnzSF47K/BG+ZWXWZvdGNtYVugCYFeSjYa91nTDIhfZeLfZ8B
Th9pK5BXxJcHm7rg9LyXLBQRZr5dTRVUb6J7VkwflyV5XpwdA+Nngm9jd1+HHf3g
f6NCQeMDIWn6dmRAi485AE/B4tp23L0B0riQkNvU4EF32Ww1rFqCQH07EiKLJCEs
pk/5QybvS3VXRIAp4/IPYNt4xRiIyjayE6B+sRg75xx9ONYYgAaAQ5GH8G0WNugM
Z2GHvttApVFRNwCpM69IpKjzisr1eRT9labZSZeeC4CQWxauqdAW8GsGgF3MuiCJ
4/2CL9wXeVkbYibPBbZabpZAyWo+Md7/9s14HJkzKEozRnaprbxCejN4sjN/2nLR
tOiARY/Z6bxeyDe4sbqtyPEBqJ5cXg6Htbz5ZeNvYw9H6g9ktW4a96p6hJcIQps5
3AVo+rRHuqLwBFj6rh2L
=ZzIO
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

--===============6656293561249635620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6656293561249635620==--
