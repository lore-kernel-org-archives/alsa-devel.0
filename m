From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dpcm: Fixup debugFS for DPCM state.
Date: Fri, 27 Apr 2012 18:39:34 +0100
Message-ID: <20120427173934.GL18260@opensource.wolfsonmicro.com>
References: <1335522826-22272-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7765051586086984237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A0372455E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 19:39:37 +0200 (CEST)
In-Reply-To: <1335522826-22272-1-git-send-email-lrg@ti.com>
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


--===============7765051586086984237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 11:33:46AM +0100, Liam Girdwood wrote:
> Remove writable debugFS permission, use simple_open() and
> fix indentation.

Applied, thanks.

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmtmuAAoJEBus8iNuMP3djPQP/0+mEvLyZZ/v77KTmxgy1gfZ
H6KXWgVL+aVl9VD78E8PUdttMERJfzwIjjNu6i3yw7ST+XMzdnwVbDwb4e6d8HRt
KI/aSv9w1Q6pXMt3Jvtj8v1Dwi8nD1RpX9Bg5AeMCSKkcTMLJl1gYmDby1gJQneq
RZdF/681XgTRlQP5dddVa5F9n5zY7yFkUG41Yzt/wTO3WjUAPBH0sBTTSbC4YeXE
QYOY9yeHwNOWrSlnF7yzXSQVdXSn0IN6lH3sz0SBlegSWQJ350bH7FlzgP4j/5bX
7t6RUGX17cOYgfz3HSW5xYEK1nyb0xk31Q0DdGl328mTwVnNiYXhr+mTwhVl5Cni
nDvGIE84NjzmkJ5afV2dRvamcoIMGIbufovN+y0hK3WyCaUwl/rscS+/YE4eDsb6
MBZVZxXKA7qAaHuefVzYq39cQj6MemL2BkPcy48OXuZlCxBtqMVUrKVt7RKbSomU
sMRxJ5JyJ9OVHg340BykvZ9y2ipKH3vy+qnvxBYs9+aTlBN71cgygrqP0I1NlSsZ
8NRRYAetAP7OaKjQny4n9sSv+MZMkESIqpFYkAzT7cj6K5yPaLK4SSApCYw1tJ7T
tFLwkjyir8Kg0hnwXWMmnk3mZG8uhaL/acH0gVGtSSvSa9OATTmP5DYhhdxz+OHc
FEZz+Z9rVIE6hlakxKkq
=MAkW
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--

--===============7765051586086984237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7765051586086984237==--
