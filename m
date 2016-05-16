From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4] ASoC: Intel: Skylake: Add DSP firmware
 manifest parsing
Date: Mon, 16 May 2016 15:46:27 +0530
Message-ID: <20160516101626.GO23734@localhost>
References: <1463140547-20895-1-git-send-email-vinod.koul@intel.com>
 <20160513121417.GL22038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8040427868965670274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CDEE2619BE
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 12:10:14 +0200 (CEST)
In-Reply-To: <20160513121417.GL22038@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8040427868965670274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 01:14:17PM +0100, Mark Brown wrote:
> On Fri, May 13, 2016 at 05:25:47PM +0530, Vinod Koul wrote:
>=20
> > +	/* Get the FW pointer to derive ADSP header */
> > +	buf =3D ctx->fw->data;
>=20
> > +	adsp_hdr =3D (struct adsp_fw_hdr *)(buf + SKL_ADSP_FW_BIN_HDR_OFFSET);
>=20
> > +	mod_entry =3D (struct adsp_module_entry *)
> > +		(buf + SKL_ADSP_FW_BIN_HDR_OFFSET + adsp_hdr->header_len);
>=20
> What if we somehow managed to end up with a zero length firmware (or
> something smaller than these headers)?

I recall that firmware core checks if file is zero sized. But then it won't
help us here if the size is less than SKL_ADSP_FW_BIN_HDR_OFFSET, so will
add proper checks in this case as well

>=20
> > +		/*
> > +		 * we check if current pointer is larger than file size from
> > +		 * base value to check excceding the file while parsing
> > +		 */
> > +		if ((const char *)mod_entry >=3D buf + ctx->fw->size) {
> > +			dev_err(ctx->dev,
> > +				"Exceeds file bound: Entry %d Ptr %p\n",
> > +				i, mod_entry);
> > +
> > +			return -EIO;
> > +		}
>=20
> This checks the start of the entry but it still lets us read beyond the
> end of the file.

Yup we need to check before incrementing, will fix that

Btw wanted to ask you on the update for this. Do you prefer that is sent
after merge window or anytime is fine by you :)

Thanks
--=20
~Vinod

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXOZ36AAoJEHwUBw8lI4NHuPcQALZ49/yYEPegiluPS5y6hMN4
qEwGh6enA6clfvNfCGS1KHlvb9KLVTdsfy45lJiSxYG1cnh/RcLttu11fcYTn2Gh
xiSurxlb2Dei4/uOrbO0h6uczHlK7gRDhyC/0YSsvBsLlaKsBde84B9XRIAlLIkn
v/N2bo/8nLqRhzRbaLiGJekyys6N4pJECKbdZtdCiUlb8vrd2+Xh4CcXl9xEbaka
egDQarwPOGHunWNHIcOv925OJp5P20vPRE1E9vl0El4EEWnQg7CfjiHy7K0U3O8g
6lV48jGzYF9bOx3YREMOkxbk77qqCvYZVSlxqSDafHJQmN/Ujs/ewde9MMlz/s84
ux0qzSinIl2AX0D3aG2TMbjSJUV8M7/MBpdzwEwCmrGzeFlbOpkt9Z/N4HrOzk6N
/LLZ1OCe9nVHVSfQaPkbVBYQ27CLL+n3id6GjnwfO2PuHBvqyjnBJd/g9Ug+hJDi
2gke9W5RXA6x+nCIYcb8UV6O8UfTzVB6mEF9fYb4X3yaNoCdqfeK/SOFltGBeqB3
p2K6fvb3DRXv8Sf0gqOYBWmIhhUOVA8R392PgRzogF/NNrzffLXe+f4tHaeF0xqt
ax6o3COkO+Al7bptR/3mBItvlWMD4pYVBKFJ0o3N6Mf7OdX+nkzQiWPEW+D6477f
zv2CiaPfAxC0evgzWscl
=JRd4
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============8040427868965670274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8040427868965670274==--
