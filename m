From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5-resend 2/7] ASoC: sirf: Add SiRF audio
 port driver is used by SiRF internal audio codec
Date: Fri, 7 Mar 2014 09:49:57 +0800
Message-ID: <20140307014957.GR13126@sirena.org.uk>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-3-git-send-email-rongjun.ying@csr.com>
 <20140306092007.GL13126@sirena.org.uk>
 <CAByv0RN0NBfaMA4TZgeB6f+MmTQ+CE6ztQ_DHXKZdTxQ7tkwQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7974811777120165695=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8438826590C
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 02:50:14 +0100 (CET)
In-Reply-To: <CAByv0RN0NBfaMA4TZgeB6f+MmTQ+CE6ztQ_DHXKZdTxQ7tkwQg@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============7974811777120165695==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l8HeubOa6/3yq29t"
Content-Disposition: inline


--l8HeubOa6/3yq29t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2014 at 05:51:43PM +0800, RongJun Ying wrote:
> 2014-03-06 17:20 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > ...use devm_ioremap_resource() instead, please send a followup patch
> > fixing this.

> The i2s, internal audio codec and audio port use same register physics address
> and size. So if one driver use the devm_ioremap_resource instead.
> The other driver will invoke devm_ioremap_resource failed.

That's buggy - there should only be one device for each register range,
you should have a core MFD driver which gets the hardware resource and
shares the regmap with the client drivers.

--l8HeubOa6/3yq29t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGSW9AAoJELSic+t+oim9Y9gP/38jv+j+3u+N8JewiVzhzHRz
akHPkVGXU4QzrnaSxn+4ej/CW843ATZlhvg7HAHMB/kbQ1NFa7xSzUUNsQHGXRPe
awHJV08w7IOCmkHfwzqOd5xZ3M6JNYr6ZD4zEute6QY/wK6RtV9dAKT3RqBcsDgF
8HZ5dlVbiMfm2v0Ov3ax9YmBqVheOy6SaGVwSQj9HWAnOdeJ5gd5zk4HQ7DjoeBs
7nBb4KG6yq14wnyPnM/psQGpWWlDQxwBNsvxUHq9bAnhW7GkevXPOTKBVqcIGAXx
30ZWMM4+GUyqrHq/m4K/tlzfGKB3SJ2KxHpI2jnOlP3U5hLLC/2amOKljy4V2A/9
IJlOeplIqCLoLew+HxKV2Mfj5AsAKqlc8fCjEyMX8qUZIzLQ6ivH3z5YuIjBrnbj
IJnUXetvvg9+oeKUq0GIoPBOJ6WczYvem2dI/HNNwa/DGiO//7UUc5wLFwUOqQPy
Yn+u9bUtlZQsh/1B4x8O8lVuwfRM0xcFlQZyR3AubuQNfU3HXmRpKwkpb/KfVrwB
CGwFhTTE57xzVrLS76sc/I2m5ankorVhg8YMHqGYJzGO6IfKwuthPhix/XE5yAVV
zB3DicjOj8C4UAgYZ/jz3ksIr2BY/hnxfpyYABtXlgr/GCIR/wWOyhFUmursxstj
VWTIi72GCS8s/T6nwvby
=Yh8S
-----END PGP SIGNATURE-----

--l8HeubOa6/3yq29t--

--===============7974811777120165695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7974811777120165695==--
