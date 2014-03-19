From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/13] ASoC: Move IO functions to soc-io.c
Date: Wed, 19 Mar 2014 11:53:47 +0000
Message-ID: <20140319115347.GB11706@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-5-git-send-email-lars@metafoo.de>
 <20140319111057.GA11706@sirena.org.uk>
 <532983EF.3060704@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9094089397681848614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CEDA265066
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 12:54:10 +0100 (CET)
In-Reply-To: <532983EF.3060704@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============9094089397681848614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mdLqcmrpJTAet9Lm"
Content-Disposition: inline


--mdLqcmrpJTAet9Lm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 12:47:59PM +0100, Lars-Peter Clausen wrote:
> On 03/19/2014 12:10 PM, Mark Brown wrote:

> >No, we're trying to make soc-io smaller!  Besides, if this stuff is
> >getting cleaned up then:

> We are trying to remove the ASoC level IO abstraction layer. In my opinion
> keeping everything related to this in one file, rather than hiding it among
> 5k lines of other code, makes it clear what is still left to do.

Like I've said before it is not obvious to me that removing the wrappers
is a win - yes, things can obtain their regmap but if enough things need
to do it then having a convenience wrapper which does the lookup at
least doesn't hurt.

--mdLqcmrpJTAet9Lm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKYVIAAoJELSic+t+oim93rgP/3yrrVfVrqDypm1qp/vCtSpK
pOY5QFGCaO7zaxbe59LUB/d5ySIDwhaC7LHyeF4k5bwzjswNzfFAjNvDm0ZFFFyF
CaRu7rUcgWYbCl/ezH/C1xDc5VWyOkuxm815WywOY2SjarH2vr3vJLjbqK9ePYJh
zmh0ZzTqdYkyAbWYz8WznpZg13HSmeTXzqDSJuERFEsdA3NWrErOwZC5TB2AwVLK
ryxF/iDHEr8PXJIw3/FL+Put2mxhJN42oibXS1rZUVe4QvOQGFCFTyrQJrMFeeGi
6pS633BLuCoRebsaSvxXxL7tOfLWeYrnJLM8UDnPqDyTNih4cXVOd9cnAoyLzFFV
NTMx5KVYg0Ad0msxeywSJSoTcfDh7mi3GEFFpnsBrlGmS9W+LuTDJxNks8Uo1Db1
T69VBy84xXQXUnCMPn4yQ2NN/u6VRx3RCB6k+KujdgldkwJUvn9R5uNkgfbQgH2E
3S0UwCGCfqzx4EdGB/uLVXnn/zKw9AH1wMk9LbbLSuYhG7Shu5Fn4M9kn9ViLqTY
7UZSj6BuVS4JukjynqovQRsyaylzSpB+dsvXB9LlHMd8tVEkkKUcM7+xO1l329Dj
xbYNFex734VEWRgqWOaMl7Y4JLhs2jGF9e2p4I7Rkkd/GmszHsOt0umzFnbdOd37
0F09dR+DgSSPo0tLNGDs
=UPfJ
-----END PGP SIGNATURE-----

--mdLqcmrpJTAet9Lm--

--===============9094089397681848614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9094089397681848614==--
