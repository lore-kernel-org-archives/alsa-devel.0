From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Wed, 7 Mar 2012 10:54:27 +0000
Message-ID: <20120307105426.GA3107@opensource.wolfsonmicro.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<20120306200354.GB19635@opensource.wolfsonmicro.com>
	<1331115061.3829.11.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7522609165772073865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50CAB103D2D
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 11:54:32 +0100 (CET)
In-Reply-To: <1331115061.3829.11.camel@odin>
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


--===============7522609165772073865==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 10:11:01AM +0000, Liam Girdwood wrote:
> On Tue, 2012-03-06 at 20:03 +0000, Mark Brown wrote:

> > Actually for CODECs we don't need to hold the CODEC mutex for I/O if
> > we've pushed the cache down into regmap - regmap does all the locking
> > for us.  I'll send a followup patch.

> I know, but this patch did check for regmap usage in
> soc_widget_update_bits_locked(). With your fix we are doing the regmap
> test twice.

Yes, we are but it's a simple comparison with integer so not the end of
the world.  I'd much rather have the check in the locking code so it's
clear what's expected instead of split between one of the call sites and
the locking function where it might easily get missed if someone adds a
new user.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVz5XAAoJEBus8iNuMP3dW6IP/RkJ4ZPlkcmYohaHHn+2DHPa
3eYsKneBq9Q/EJK2vu91GGtjw/06fGcjt8XnngJ0JMvfBqDfnvZbYIxxL7syrELt
q4YSv113vz7oztvxrars/eVIc8SA7TlLKYBR7/+kk9tH3IaDX8ivJV1v1Uz1GDyI
YL6xaDOUAtL/UodeALM/7asjtWXEIksj3bgivbHFNYLQQASkeSGvrXA2BUrZJKvj
3XV+QMXGICn0Pvqzp4fURVGrP/FwAxLdtQhLr+39ywxvvx9jPCwh4qihHYTMrWzm
EVUzLKdD3fn0OeX+oVk88bb8o5pIHDgX69smL9VRZq5C6g8IOT2aDJ3ErFEUpOiX
oayhe+UvvIsOrhTdoiBtNq85zgXcEqVIK6LO2s50zK2stFZczqstHegQDykc0/FM
Vu4n1dyQEO1NzYT7jPczrAcUCu+hHc9Kj8Kgrv+kLbchaqQoOqyChSewIkxIdbRl
gb6I3zExm58FReyIt/fD+YNh1J3EdpxTPIp1hYhD18UAI0nKknT2tqPkviGzqTak
X8h5Ecw70UkMRBwVMP9rBl76oeg152C9OMXOrQDXWZztp+xWrutVn4dhCediTT3v
k5PHmE+06+H/DEAg+aL+jcdBoT4CNZ0CvLXQS07bE6hhrEz3f1Ta2jblro5ftYKe
ATuM0OmOynH6RCRySAuJ
=jqUw
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============7522609165772073865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7522609165772073865==--
