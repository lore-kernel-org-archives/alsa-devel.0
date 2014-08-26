From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: bug report for ssm2602
Date: Tue, 26 Aug 2014 07:56:25 +0100
Message-ID: <20140826065625.GU17528@sirena.org.uk>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
 <53F71195.5030502@metafoo.de>
 <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
 <20140826062846.GS17528@sirena.org.uk>
 <53FC2C82.1060802@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8764984918677939493=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95E932615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:56:33 +0200 (CEST)
In-Reply-To: <53FC2C82.1060802@metafoo.de>
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
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8764984918677939493==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7A+FRGrK0Jxe0sXJ"
Content-Disposition: inline


--7A+FRGrK0Jxe0sXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 08:43:14AM +0200, Lars-Peter Clausen wrote:
> On 08/26/2014 08:28 AM, Mark Brown wrote:

> >If it is the above patch is the problem perhaps that the register map
> >isn't getting marked as dirty so the cache sync is being suppressed?

> The core should mark it as dirty after calling the suspend callback. But
> there might be bugs preventing this. Try to make sure that
> regmap_mark_dirty() gets called for this device and also try to check what
> goes wrong in regcache_sync() and why it does not sync the registers.

Indeed, I can't see any obvious breakage there and don't remember any
fixes though I've not checked the old code properly.

--7A+FRGrK0Jxe0sXJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/C+VAAoJELSic+t+oim9hgsP/A9a6XwjFTOctG8dKUU+0ufr
+BC0IGl8/Hk29eLIVvQilQtamIYJPMrBCHOcspXwgTYl7SxQ53GMIxfeoQL8QM6n
CP9fSZ+C6uqq/l6l/4pydeQFps7To9gUsQ0Yv2io266FiD6yWcQ0QSnYbGZWZoNt
z4XSpuHBPJrn2WjujJWCfgxQJ1G8QIYiuXV7Pm28qWap5pvzk+MovSku5pmqBNYa
FtQ00pUpHyYHnwlHXKb6FNw23Y5qX45os4uvjsVIp5bBnu1z/VGSeWfhNOwwsHT8
Opg0xgpk/VBsjlbjqIn531lCbJBCtrj+9oJiCU4R55aubZbMxkgdRpyqxMmP0lod
bHrkxp9rAO81WnzYmJaiSn1U/5HMHeJqpLfb6U6tBfZWZrbcizgxMQKY9DombqVH
HTk5fE0wUqXU50d/eu4wOhfVyTEDUcnbEUrYPWoS/mzHOgkvSsPSnStJTGB59s42
CnQxOeDqc84Zuemmoc/5LLV7QDiUwftu6C1WKT6EXvgSXqr7HseCKYDD7ryu9m/8
GHy8n47r6IeSxut4eq207h154I/Gbpj9MIXkgCahd15tIjIK3OmyespoQ9NPvZIh
xu5U2AS+niNVkZz5NneDlQ6o9NnOJWg7mLc8bkr1YKQ3WuyuF398erQP3uQ36kUb
871x3Aq8X+fZ13O8Dptl
=5fWF
-----END PGP SIGNATURE-----

--7A+FRGrK0Jxe0sXJ--

--===============8764984918677939493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8764984918677939493==--
