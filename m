From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/7] ASoC: Intel: mrfld - Add DSP load
	and management
Date: Fri, 17 Oct 2014 11:44:14 +0200
Message-ID: <20141017094413.GF3771@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5141167204177458039=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 748EE261582
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 11:44:44 +0200 (CEST)
In-Reply-To: <1413469819-18775-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5141167204177458039==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 08:00:14PM +0530, Vinod Koul wrote:

> +static void memcpy32_toio(void __iomem *dst, const void *src, int count)
> +{
> +	int i;
> +	const u32 *src_32 = src;
> +	u32 *dst_32 = dst;
> +
> +	for (i = 0; i < count/sizeof(u32); i++)
> +		writel(*src_32++, dst_32++);
> +}

We also have a memcpy32_toio in atmel_nand.c which I pointed out before
and now another in mxc_nand.c.  All of which use different writel
variants.  This isn't awesome, we should at least try to clean this up
rather than add another duplicate - by the time we're onto the third
user there's a clear need for something generic.  Do you have any
thoughts on dealing with this?

Otherwise the patch looks good.

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQOTsAAoJECTWi3JdVIfQaWoH/Rm4BkOQL8kJ9fCNdswQ2cGe
4uP9ogY8lMzaqjuHdnekcXe93KjEM6B5Ww0j/SXTsqKFqvbIH5A1bZrng8yZHxVG
0BKxOByFBOHG/sVnk2gjuvyfkpDWA5M+wWqyKm1fWUmkp2Mrclo2JjDzrNmg6naK
jN1bzz23wJpFQim15jAyEL4jlNvsZiexbndMXBU2Jbg04sUEXjEPHlSwseNK21Yp
n/QeeiQlbq2BUwCBZ1qmp8AcwH2B1YnNcevQlvuJlWhXt2Y+ilv+db/HEZC6fkoL
Q866LiGKLfAloDEQIQ+JEgODlO1oAaZB5MY/bMo40W8bD+tQV72Cq67rmCDaMeE=
=OfX6
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--

--===============5141167204177458039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5141167204177458039==--
