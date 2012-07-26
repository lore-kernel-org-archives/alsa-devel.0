From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver
 for Device Tree
Date: Thu, 26 Jul 2012 12:38:38 +0100
Message-ID: <20120726113838.GA3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4016151332703979899=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1DCA2265E67
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:38:38 +0200 (CEST)
In-Reply-To: <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============4016151332703979899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/T5g/TLNXpBPJeG6"
Content-Disposition: inline


--/T5g/TLNXpBPJeG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 11:28:50AM +0100, Lee Jones wrote:

> Here we pass platform registration from platform code over to Device
> Tree, when DT is enabled.

> -	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
> -	platform_device_register(&ux500_pcm);

This has the same issue as your last patch...  the way you're doing
things will break audio on all boards using this driver.

--/T5g/TLNXpBPJeG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQESw3AAoJEBus8iNuMP3dH0gP/0EicBBzeE2y0WoO++ktRh/R
A4YtfrcR2gU3ZBjVQvzWPQ15zhXT+ohoL9LsEhQuB4r7Emn5iEvzqn5aCOkyr5fh
RyGQecc5MS3IIg0VkafeLZfyyRVAsrOhkpL6WgbrK6JvnMVfFjkQfhg2NBs6/g6y
F+h3jwitvuRj7RbGtWXorqE6f2uEwMFjGCbYZz6kxWx+JKWgkgbEWXFhuCuVcxWd
RuBjE0ljAix8IyK+2BfKaO7tgD7/k5K872nAEwNMAGlueq+I9fNa7/Qym91ButR4
CcWhkbdh8SGsyf8maz17fsbHAf8jYEwDviDhcBKZ0VEsKRz9CFlF96el2aM7hfkO
vMr/j3nTUXhcrXMcngtA9UV8kV9VHJo5cQkdC44QR4cud1+M+tfC0bKqvQh1YpPW
d29TnxLRvL3OGxW3LcN7sQOH8C2uezQKYmHWuAg/7r4kWjJ/CR/mrUgYD9eZLDu/
MVCdERl4zT5SwjWqzX+OUlKMo1lsZl+JTv0gqO3B5N0m7xtxFgxps+X7tMljH/Ht
AH6ZoQMh6HTbtoTdW71g2Eq0EhGuDdXOErSQcyjPy1ix8WpFE4p/ltjB+JDcwkyM
jvrp2j2KMh+N/eKELN7okcghBnh/0viH+OqvGhW8aT9HjACKJIyvX6N3EpRHaMOy
FdPWrikaeb+JxRV+LmEY
=FWWm
-----END PGP SIGNATURE-----

--/T5g/TLNXpBPJeG6--

--===============4016151332703979899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4016151332703979899==--
