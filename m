From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/2] Convert davinci ASoC to genalloc
	SRAM
Date: Wed, 17 Oct 2012 22:51:17 +0900
Message-ID: <20121017135116.GU14199@opensource.wolfsonmicro.com>
References: <1349991229-32107-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1152682392137015894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C989265221
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 15:51:24 +0200 (CEST)
In-Reply-To: <1349991229-32107-1-git-send-email-mporter@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Porter <mporter@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Sekhar Nori <nsekhar@ti.com>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Gardiner <bengardiner@nanometrics.ca>, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1152682392137015894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ms5iOKSBOB9YS8zC"
Content-Disposition: inline


--Ms5iOKSBOB9YS8zC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2012 at 05:33:47PM -0400, Matt Porter wrote:

> This series converts davinci ASoC to use genalloc and enables
> that support on DA850. It applies to mainline on top of the
> uio_pruss/genalloc series [1] which allows DaVinci to provide
> a gen_pool via pdata for driver use.

I tried to apply these patches but patch 2 doesn't apply against
v3.7-rc1 I guess due to the series you mention.  What's the plan for
merging that series?  It'd also be good to get Daniel's patch squashed
in.

--Ms5iOKSBOB9YS8zC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfrfLAAoJELSic+t+oim92FcP/17QX/ZIEFJK/0suszbLVCpg
12RdtEJLqMYrLNW8FjfK0TtITc25zTMWnK1vFR2M7zOyEuTdJVJhj7dyj+pWufaG
VRwipItbAG5XmEDvZx23e3NxNjMrs53Rnuxw9Z05m3oOBumIDSRUmT3a8SMPZtHy
y+4txK27HXMPF1d5WOsDlNK4PxhauCSfUqx2twAMn4oMAgD0wuwKcoGsW7oUkJ2m
EwbzJR2Msrew/yU0exXMww1qd7vxpc2O7Ch7f7+fAu1RAqbhSviuGqnQOxptztbJ
aEWZLLPWzZ9d6JbIqeTOdhE6f5d/0i3ctiVyhYiHr7pAE/+7XKQfZAXOzgIPe55a
K/SkFw/Hb0G6r92Vbtu1B8B8fbnFytnqVJA8JOmEj+5o2LJCCBgXWf+YEv2DS/Ib
4SsCiCtX82nbqEW1RRlrTmEz4BeOHKkSidiVTRrKBvTPOKaWeRkGKqhzXLkRKYsg
gLZZQrFYIcxmpL/OZanvIXMH9MTeaw9dqaizHkAT4PA37PJ6zbP5LxH6Gn/bhLRE
vWwKBsRWvTpxE49GIRpw5zPTV7rVrAluuJ3yhYjQ3XTh0WvmVnwJvcMOTMJI6/UZ
qAmpnU9cETZlgdAZQj7nBl3rno5721uSEgI1K/182Sbh46+wLEKOhsAmvVj6peBt
YCi17tmDdPFd2/aRPpMe
=2OxW
-----END PGP SIGNATURE-----

--Ms5iOKSBOB9YS8zC--

--===============1152682392137015894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1152682392137015894==--
