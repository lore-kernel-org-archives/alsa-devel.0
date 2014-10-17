From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 2/7] ASoC: Intel: mrfld - Add DSP load
	and management
Date: Fri, 17 Oct 2014 14:48:16 +0530
Message-ID: <20141017091816.GP1638@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-3-git-send-email-vinod.koul@intel.com>
 <20141017094413.GF3771@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6993453221582478075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C83F2260667
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 11:54:28 +0200 (CEST)
In-Reply-To: <20141017094413.GF3771@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6993453221582478075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
Content-Disposition: inline


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 11:44:14AM +0200, Mark Brown wrote:
> On Thu, Oct 16, 2014 at 08:00:14PM +0530, Vinod Koul wrote:
>=20
> > +static void memcpy32_toio(void __iomem *dst, const void *src, int coun=
t)
> > +{
> > +	int i;
> > +	const u32 *src_32 =3D src;
> > +	u32 *dst_32 =3D dst;
> > +
> > +	for (i =3D 0; i < count/sizeof(u32); i++)
> > +		writel(*src_32++, dst_32++);
> > +}
>=20
> We also have a memcpy32_toio in atmel_nand.c which I pointed out before
> and now another in mxc_nand.c.  All of which use different writel
> variants.  This isn't awesome, we should at least try to clean this up
> rather than add another duplicate - by the time we're onto the third
> user there's a clear need for something generic.  Do you have any
> thoughts on dealing with this?
I dont mind moving this and other users to common handler. I can send a
patch to add that. I think Subranshu did send one but that needs to be
improved upon. Also this should be in BYT driver as well.

But creates dependency for us
>=20
> Otherwise the patch looks good.
Thanks, since the size is bit on higher size and no other issues, would it
be okay to merge this.

I will work on moving memcpy32_toio to core and move users as well :)


Thanks
--=20
~Vinod

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUQN7XAAoJEHwUBw8lI4NHMhwP/2QNjQqosx4c/D0iJ3Rp+swf
M0BnzgPLzIhUIGDb73MLKMvfFgObAFksegKi0H/+oxaJjS7qQIM7qQAn9363qfO4
/DGdC87Y2xA2zbWFoa2MvaGpRkEstgDA3WmBSbP6S/LWUQCFxxVY41tjxWu9Ci/v
K41fJBFupDljtJnLJbY2VrRjK3PEGFGj9vx8/PmpbYZkSbsKhuAsopsn9sykrOS8
eqYCNQj3P8E9+PI541BVwKmVM+VgsEEUO3toVdZ0ALSbRVasjekSmVIRYjdbfOpn
IzsvX2s4SkrDJRBi5WzvQ9UM9ZtWt5ZcGD4UEhHGUvKhXUMBZZaZ0+oBQ80Kf7lQ
GPbiH01lDLqLtAa9Yv2n79l/QEA8kap2Gg3ecIjzSNzYlXu8HuDGJtr5G5o0otNa
uzFU4eO3wuQCZj+Ziv7VK0CtotJtEEAcj4+ZRO1AKua1rdio7A3TvQ0sA7G7qCcH
FvaTKS1Cw3SWEhXf8T08UBvsbYw16uu8+dNocOLHXw/ErstJBoDTJQb5c6U5Qj8n
8VAIq+I0mqwpj7ql/YQYei8S3YK/9XtzcalyrQMT3ZUpv4X4iM1//zvlg17hM55Y
q5S/wVQ6iST71bEhTGE38PHfh4mjaBr7gXqVeJKU7FQXHmoN9MLxq0xSWY8Nzuuf
dIodOfD7eHiBIorCV+Oo
=xZOb
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--

--===============6993453221582478075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6993453221582478075==--
