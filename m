From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 15:18:00 +0100
Message-ID: <20120821141759.GO7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2288511996697755100=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23E6A265FCF
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:18:00 +0200 (CEST)
In-Reply-To: <503397A1.4000409@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============2288511996697755100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Content-Disposition: inline


--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 04:13:53PM +0200, David Henningsson wrote:

> It reminds me of the discussion we had about jack labelling (for HDA
> or everyone? I do not remember), where we ended up having

> 1) physical location (left side, internal, docking station)
> 2) type (headphone, speaker)
> 3) channel map (front, rear, c/lfe)

> Maybe that's where this discussion is heading as well? I like the
> idea of having the same TLV description for jacks, mixer controls
> and PCM channels, maybe that could work for all but the most exotic
> cases?

> (Where exotic means unusual hw on both the pro-audio and the embedded side)

Or perhaps what we want to do here is define the channel mapping in
terms of saying "I'm connecting to this input/output" and then use the
jack interface to describe all inputs and outputs rather than just jacks
(making sure it's easy to see which ones can change state)?

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM5iPAAoJEFJkBDiqVpZ46BEQALn7dZHeujsgaAt5xf5ZmAo8
JWgm6Bul9gQlFQLww2Qr7blC+QUnGL5Qv0Eax+CG4byLkfF/XYU2OXHdswArcMIm
HsDvt07jxKNEA5nE6awFS2hHyhx0r8BmvCiq1UdnVg9TBmh4KqZoyVIWAd5LErRb
LRHFIUXBFNDkIQwqjCMUhJ+uclGOLRi3mg6i28ulsLj2XHA2VQvBPNL5n8WUHL5S
MiZrNb7AfYMMRiu8mOblv1IiTbs8kLHzXDsuU0xSDnxxCb+nScfXvT3mBi4p3NWl
yhH1AXAevKDCK+z7lGiWiGLc78G1QIfiYKQSaZXF97sz9NJ96SgCyC6+k7QRICv9
+KqQpSWhp3zV9q6psX/v3YhcpH42yf574YjjtO1DjoYFXjwgZg+yE//lI0E5R+S7
txboH1+dYTGzDtWWe3JYGUXps4OgwPAFD7UQbjJjOFY3HGA83Xgb+kvgK4A2xt1C
8lQqZCxJQ6j13ft7DKZ6++LUhF0aZP75N/4j+j0sNraFX4gFY2T7Q9HwjZ+bTD6Z
QjM/XwTz9vn5BhdLXx7/DaCWmC3Gw6lYvjXu3wqoz9ebzViCZaVF0GXvYUg0Lmuz
R52ePu4SDysHVBqBgFinT+ZZd2kVWNLwPXjbY30U6LLdLpXuGudtJZOBbRkn+3zw
9NNKzbE6Wx1mmsVLYRlG
=hsqE
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--

--===============2288511996697755100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2288511996697755100==--
