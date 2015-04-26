From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 6/9] ASoC: hda: Add Code Loader DMA support
Date: Sun, 26 Apr 2015 19:58:22 +0530
Message-ID: <20150426142822.GU2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-7-git-send-email-vinod.koul@intel.com>
 <20150424171838.GV22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8362982592314946359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F28462606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:31:10 +0200 (CEST)
In-Reply-To: <20150424171838.GV22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8362982592314946359==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:18:38PM +0100, Mark Brown wrote:
> On Fri, Apr 17, 2015 at 06:46:04PM +0530, Vinod Koul wrote:
>=20
> > +void ssth_cldma_int_enable(struct ssth_lib *ctx)
> > +{
> > +	ssth_updatel_bits(ctx, HDA_ADSP_REG_ADSPIC,
> > +			ADSPIC_CL_DMA, 0x2);
> > +}
> > +void ssth_cldma_int_disable(struct ssth_lib *ctx)
> > +{
> > +	ssth_updatel_bits(ctx, HDA_ADSP_REG_ADSPIC,
> > +			ADSPIC_CL_DMA, 0);
> > +}
>=20
> Blank lines between functions.  Seems to be an Intel coding style thing?
> :P
sure seems, will fix

>=20
> > +/* Code loader helper APIs */
> > +static void ssth_skl_cl_setup_bdle(struct snd_dma_buffer *dmab_data,
> > +		u32 **bdlp, u32 count)
> > +{
> > +	u32 *bdl =3D *bdlp;
> > +	int i =3D 0;
> > +
> > +	for (i =3D 0; i < count; i++) {
> > +		phys_addr_t addr =3D virt_to_phys(dmab_data->area + i * PAGE_SIZE);
>=20
> So this we index by i and...
>=20
> > +
> > +		bdl[0] =3D cpu_to_le32(lower_32_bits(addr));
> > +		bdl[1] =3D cpu_to_le32(upper_32_bits(addr));
> > +		bdl[2] =3D cpu_to_le32(PAGE_SIZE);
> > +		bdl[3] =3D 0;
> > +		bdl +=3D 4;
> > +	}
>=20
> ...this we index by stepping through the array with increments in the
> body of the loop.  Consistency would be nice (and more obviously
> correct).
ok

> > +static void ssth_skl_cl_cleaup(struct ssth_lib  *ctx)
> > +{
>=20
> Can't we clean it up instead?
yes should have fixed earlier

>=20
> > +	if (ctx->cl_dev.bytes_left <=3D ctx->cl_dev.bufsize &&
> > +			ctx->cl_dev.bytes_left > ctx->cl_dev.period_size) {
> > +
> > +		dev_dbg(ctx->dev, "%s: size less than buffer size: %u\n",
> > +			       __func__, ctx->cl_dev.bytes_left);
> > +		ssth_cldma_int_disable(ctx);
> > +		ctx->cl_dev.curr_spib_pos =3D ctx->cl_dev.bytes_left;
> > +		ssth_cl_dma_fill_buffer(ctx, size, false, false, 0, false, true);
> > +		do {
> > +			mdelay(5);
> > +			link_pos =3D ssth_readl(ctx, CL_SD_LPIB);
> > +		} while (link_pos < size);
>=20
> Should time out in case the DMA got stuck somehow.
yes will add

>=20
> > +		goto cleanup;
> > +	}
>=20
> What if the buffer is just too big?  Looks like this would loop for
> ever.
DMA is started, so link_pos get updated and we keep reading it. Since its
DMA a big buffer will get done fairly soon.

Thanks
--=20
~Vinod

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPYGAAoJEHwUBw8lI4NHF/cP/RCmgKadmWhVHavjPzZCKzJe
Io2rCcpZ0gfxFsyUIjZj1isaIgTPXC4xfgPXGuPkEEDH0loAtPbWqy9ugng/7EX1
725PwVbwUzfhjGH4t61Yfjl3H6Xjv5lWnlLjwPErNRIotWIcQsM/qvo9aLrHK7Ho
E0RaQUvIZM6YKwOIU2JVBE1HZGVSCberPbmtGHnQZJgyRH6IyyLLa7OTHHYBXrMu
Es86D0Vs/mkHKCWG47wtXtU1gPzwxDWAUfTl5Meh7kEVZmEaGwBwyT3fFOfKOZcm
o8DCdzizyVsGOdR4ci29/FluOet7m0kB+GzMWdWbX42J1nV3dl4Y02MjrGxiwy3a
/YkUHQ2WPiGtEkLp0CsuyM+H0rPqXgFZLy3zOjyOJ0USPiwDXxlyqrDN7eOV/Ynp
KCGLP8j+lUC4fsmcJAn8dReeKaAw97fDrTNMTDOFqIw8uxFpVG2fy4dreaFc4/d5
PkTCfH5ZeHsSqdxZYAz+doalciP0XhxFeqWbOyF2q2AS0/0qqXMmGOUHKTXqfaz2
CqaOo4eE4Z2yEOqjk9zo0utz7f5rmAqw02cgHeGN/C4ULs3YQ4hJJ1Kc3T19Zah6
lklfWur+HXIKhBmzQnZ46JfgRCBNFGpHerbtiaTxfokynDBIQS9HrEjtb8NvMKZ+
F/avBP6eDKgvmQgo66BS
=dXZT
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--

--===============8362982592314946359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8362982592314946359==--
