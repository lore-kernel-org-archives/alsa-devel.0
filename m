From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: soc: fix invalid free of devm_
	allocated data
Date: Wed, 20 Mar 2013 11:06:34 +0100
Message-ID: <20130320100633.GI28775@opensource.wolfsonmicro.com>
References: <1363434334-5461-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7225328368140327321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8B2C2616E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 11:06:35 +0100 (CET)
In-Reply-To: <1363434334-5461-1-git-send-email-silviupopescu1990@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7225328368140327321==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 16, 2013 at 01:45:34PM +0200, Silviu-Mihai Popescu wrote:
> The objects allocated by devm_* APIs are managed by devres and are freed when
> the device is detached. Hence there is no need to use kfree() explicitly.

...but I applied this anyway since it's clearly an improvement and a
small leak is better than a crash.

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSYojAAoJELSic+t+oim9ZMwP/2tDSFrh3ESfDZn+INUM0gL8
a2PPj2FJJukrYkLaNVaa8Ibjf/UOxbvT9HMFHdPa/MitoETZ2tsqt39z8O+KBhHs
/dLgXf4X+zEwnE5FPtY2kBlLvo1D+vpaUVnV9jukfqMYnsl5ZcuiFX5MW6cNe3oq
HQxTwy5FJjvhBqDRuhGYP3eU6IRQmNNgyg9sCpq+MzV/JmmFJTkm1iYPJdQgKtZP
lPqxkIluFeaC7fRebJKlZA9QK+iemqveUactVeZDl3SMfjJXw+s20S+4tfE9m81A
bp42tmvIYT/P3GhQfAm6UpJrFJVXhvh453PMJwqmS+PgWPKsH0pq+bl9yvC8B91u
5+6mnvfAG/LkklMWwXv8uf0uJlRNXauP7cSj9DoJRTbyFojRxF8Fr/8lZIqGdbLy
i4HVdVLsikIBx4fg5GyziNnB89J/K1NfyM8kXJ5mpEAAoyLKC3HFHxOm03HW1LJP
LerQ7Hj5YhDkphAMxeUb7JoCUuX5sCjuRScvURArqyX5saCRgnjiz2bofQMXnw/r
1zTg2SwoObzryBPMPYNoF7LtsURQYYQ9PZBOj8RFfXGIPd1wl3cHNCE1QAZTZF9Y
0nAw5Bob4ityRcs9AXGjCdZZ4Tutq3LqN8nYAFGeOBooVtZ//+lzFoUfKSb1eFwl
aRSv7botvPfzVzPQHGwq
=eKjK
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--

--===============7225328368140327321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7225328368140327321==--
