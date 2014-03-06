From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5-resend 2/7] ASoC: sirf: Add SiRF audio
 port driver is used by SiRF internal audio codec
Date: Thu, 6 Mar 2014 17:20:07 +0800
Message-ID: <20140306092007.GL13126@sirena.org.uk>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-3-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3527658246877896138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76D7B2658DC
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 10:39:57 +0100 (CET)
In-Reply-To: <1394008480-29135-3-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============3527658246877896138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t6UvBN/bazwYNF7"
Content-Disposition: inline


--8t6UvBN/bazwYNF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 04:34:35PM +0800, RongJun Ying wrote:

Applied, but...

> +	base = devm_ioremap(&pdev->dev, mem_res->start,
> +			resource_size(mem_res));
> +	if (base == NULL)
> +		return -ENOMEM;

...use devm_ioremap_resource() instead, please send a followup patch
fixing this.

--8t6UvBN/bazwYNF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGD3EAAoJELSic+t+oim9/h8P/01KOsgja2T6NJQJcgYb8K1L
iWdoJxUq8/hGbG7X0gb5ZXioSKOMo5WYeMTnkZbGSvHm62yrbUwR8zAQ9I8v2/jp
cZGN6ijdPx4XWBqj0j3zHYd+rlhiGV4++65ATffuD9sLsa436Pfn8HMLv3HtWGwk
XNIjbXa6OAu70tfTcyXZe1wGRG9d++M/goiKAaUh32bSrG2Ysy4Im/VwQyuL1ufM
lVdEge0qxvX9+LEdDmy7xNlZWRDJSvhY1fSIQ32LCt5/ez8umUH4sxxhez5ARSmb
BhOtMC3S/o9A9CeNJSiNbqt+jCfQKUTILItVQSElM+9vHjHRJ5PhGKOZdpU+rCsP
gzXkmaLyfhRPrAjV/Dr/BY8hokdvQo06uYA1tsTwv86eFZzY6xzVVhH8l6iqdGX1
rVyQ2mQTYNezbkZHtEZPNfwzH5De2fA0bloZPy3af2vGJdN+XdZYWVcM+MadK+9L
alx9B5v3Jloe+BclElx+IgXbDx+zpV6DdPodR8nVxO7noJcIsfuml8STw6LVwKNP
eGS7DE+Slim/J8ei4kKAJPZzSFV1/6Tz8CdCVvoGVKMuKzHjoCpbZoUZmBdsOb7m
C7chZzsltE8rk1nT3Za5oAfj7dKVNA10jlgEoMnohBwncqAGflE45OuX8edXrul6
ymj6wdiRZ1ONzKIJD/vI
=ekxG
-----END PGP SIGNATURE-----

--8t6UvBN/bazwYNF7--

--===============3527658246877896138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3527658246877896138==--
