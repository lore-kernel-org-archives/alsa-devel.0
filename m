From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: DAPM - Use dev_warn for debugfs
	warning message.
Date: Wed, 7 Mar 2012 12:07:42 +0000
Message-ID: <20120307120741.GG3107@opensource.wolfsonmicro.com>
References: <1331057605-4542-1-git-send-email-lrg@ti.com>
	<20120306200810.GC19635@opensource.wolfsonmicro.com>
	<1331113730.3829.7.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7005536077559171787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A662B10B915
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 13:07:44 +0100 (CET)
In-Reply-To: <1331113730.3829.7.camel@odin>
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


--===============7005536077559171787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 09:48:50AM +0000, Liam Girdwood wrote:

> Historically since 2005 the ASoC patch subject prefix has never been in
> any fixed style. My personal preference is the same as Takashi's for

Yeah, it's mostly sprung up in the past year or so.

> HDA, but I've no problems changing a - to a :. Lets make it more
> official now and have :-

> ASoC: thing: change

OK.  I've not been bothering for people who were only using plain ASoC:,
I mostly just mentioned it because you'd picked a different standard for
your commits to what everyone else had chosen.

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV0+GAAoJEBus8iNuMP3dlJ4P/jo0iyEfA49S8ex64NjAOVAw
/I3WXTJ3rfach8LaRoGoQCLAYMPCtMJzQ6u9P/0hhheaqA/piWr7ZDZp8dGIVGml
4Y7me5/6gqW2ZpRI0efjmAZwEv99YrZ133RYV8lXnZiYZ9CYZwqK+979qJ3f92Ek
ZYYxgwgeUHkTyc0p6ewYGHOZ6CVGcmTteRQOx3oDOaq2yxRUSsc1nT5NiyTG48d3
6ByopisGTSFPktTabj0oddJRAx+a/ZGrq4swizQWZeGMXgiSGFJhDMb6XHs0x+lo
srWEGWNZfrgml3cKD/f1jhx7nxb8dce+GYOUY698vf0Gs54mwCKi8qGzuf20TBBH
8XRzov64p+f9xANsPtOy4lOr/1976AixJGarydkYJga+Xg8Yb0FLnMHzbx8dTIhy
qJUXJKrL0zkHCjfqSZDI59xQ839WPaMdrPC+H/5grTI2lEQypULHOb9YJwFIdIIt
V4xRtaJ0Le8LOSrBekqPMiOShalfr2KHwBtJKRGW09FxXcOzKy1/fnbQHzjDpQbM
0Y5qSv9pq8BGqmwXM1eTCbN9POU+wppDnxL4/gQ5S66PaxDZH14KgEtxioKut69k
7rGyNC7G6FTi8alZJApnABk3LZJwbNut5rK9SD8lXnVk875CJ85PZQhuzdK5Qf1Q
driyVv0VrLSGjh3PwUjw
=oeqC
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--

--===============7005536077559171787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7005536077559171787==--
