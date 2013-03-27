From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7] ASoC: soc-compress: Cancel delayed
 power down if needed
Date: Wed, 27 Mar 2013 23:10:55 +0000
Message-ID: <20130327231055.GC18316@opensource.wolfsonmicro.com>
References: <1364402341-6702-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0459151001120313439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B27026531B
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:10:57 +0100 (CET)
In-Reply-To: <1364402341-6702-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0459151001120313439==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KGRu7WxDW0E86NnQ"
Content-Disposition: inline


--KGRu7WxDW0E86NnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2013 at 04:39:01PM +0000, Charles Keepax wrote:
> When a new stream is being opened it is necessary to cancel any delayed
> power down of the audio.

Applied, thanks.

--KGRu7WxDW0E86NnQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRU3xqAAoJELSic+t+oim9wcQP/3U3xlI7d3kYkH+LNAcXzFNx
Qk3IbnJiM+0Ho8m5EqrrvRyfDDF1SpQZyag9R5cy+4EF+VuB3204PEoWUhavR38I
dfdXoo4XuQaWVFUonqmo7PAYxLk8dUHeodSqXuHwxFTw6zCmBnjITtlUGHCovhd8
a1JiymnMksrojchD3Q4TcQJta/vHli3ZmKz6ZCOq8pXi29QlfjKucpwliVXewqj5
XyQowxTVWYiEhrf4B4roL0zZQrK6cBgMyHUkTYGQ2rxoeOPwANCYAOUNg32nNgKZ
1Wl3MCkSwC8Zo/kCPtH9ay1bRYeUgYE+HDqW6mkWbTh8S1Iy5QoiM/k1XJ/tKEvE
r0kq+f4s8BtvqCvCAyJ6kxbaNsntaJsPJbqCu3S6A/FJ15ZmmkIC74bRG/bskH0v
EAyVwcUNuPe33kUjAQMXvJSVaYg4y1GvhJJApceBQ8xVNujPEl2hVpD7duqJ7eXb
gmQXnuTEEYKjCIgTEgzh53xZ8xdjTKKYrQ8kQGv5v7NjMJliuu1hABHzG4Xj5jTD
FjpcXvBbiCojthXqUkOseb/X6l40Ic9u+FaTBofDTO3VdmmNQQsIfFMpnwnUPK6+
HCvI8DvMhvkGA5oEgxXTUONDyFxtGNN16YSuQMwpU7DfSDPYkvgPL0Fi2U64XgH5
aOi/Zv4glKrDQsGkyTqT
=kO9j
-----END PGP SIGNATURE-----

--KGRu7WxDW0E86NnQ--

--===============0459151001120313439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0459151001120313439==--
