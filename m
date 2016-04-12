From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Add DSP firmware
	manifest parsing
Date: Tue, 12 Apr 2016 10:24:16 +0530
Message-ID: <20160412045416.GD2274@localhost>
References: <1459633754-20548-1-git-send-email-vinod.koul@intel.com>
 <20160412041207.GU3351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5446533028908567917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8981E265335
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 06:49:45 +0200 (CEST)
In-Reply-To: <20160412041207.GU3351@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5446533028908567917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 05:12:07AM +0100, Mark Brown wrote:
> On Sun, Apr 03, 2016 at 03:19:14AM +0530, Vinod Koul wrote:
>=20
> > +	for (i =3D 0; i < num; i++) {
> > +		if (!strcmp(uuid, tbl[i].uuid)) {
>=20
> Do we really want to be working with UUIDs in string format all the
> time?  It seems error prone and as far as I can see at least some of the
> time we get them in in binary format.

I agree that it would be saner to handle uuid in bin format and print to
strings when string are required.

> > +	sprintf(buf, "%08X", entry->uuid.id_1);
> > +	sprintf(buf+strlen(buf), "-");
>=20
> Coding style, spaces around +.  I'd also like to be a bit more confident
> that this can't result in a buffer overflow, sprintf() isn't reassuring
> especially in conjunction with buf being passed in from elsewhere with
> no length information.

Okay I think we cna remove this if don't use strings

> > +	adsp_hdr =3D (struct adsp_fw_hdr *)(buf + SKL_ADSP_FW_BIN_HDR_OFFSET);
> > +
> > +	mod_entry =3D (struct adsp_module_entry *)
> > +		(buf + SKL_ADSP_FW_BIN_HDR_OFFSET + adsp_hdr->header_len);
> > +
> > +	num_entry =3D adsp_hdr->num_module_entries;
>=20
> > +	for (i =3D 0; i < num_entry; i++, mod_entry++) {
> > +		get_canonical_uuid(uuid_str, mod_entry);
>=20
> We're not checking that we're not walking off the end of the file here.

Will fix

Thanks
--=20
~Vinod

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDH94AAoJEHwUBw8lI4NHa1kQANZD8MnpV58M9xNY6nshtSFS
isnMbcdIcQrvdJtgf1vpIB4zt4AGi33Yh7b7xjNNhM4RI+yDMo1ipCSuwePt2std
N3opa4fwAYT+LFNWYofbdEVN1Ys67n00Pj1pPC5ii6msFI85E1GW8TGRmbHMsB1+
GLSzoJIh50eH6ZiNYJ56NxLzdB202+BU90M+B80qk5qdT7mDFEkjYTjxu9UfTLZa
RMoIIGoR6Wo/8+39i902Wn358i+sRX1uLxSki4cP5JyF25mn/qiJJq34yfKNv8Ai
DKVrCwK4Rxr0s9Zrg4lsP6ZrSAub4Ly43e4c68xM+8HvHvsH8l8iWutLP7AHuakO
XIIFz5Skj/MWy4tOv2IIBCj+BMEq3B61qygHgvvJXTPLOlxayZeS/zsmflp7oTx9
FG2/J4Ct3UPFBl++qCHalohL5O0xRD5WxBEdIzIaYMVv7B8px0q1c0MGBU5cOwSW
K+3HUGl6hcZwMUAjP36em0xrbDq85QRvRIFz3dQkOc3vE8xcsi8u0ndjV19OO0AF
YNAFBQWTqQ0D/lpxenKp/8ZkcJM1p60RvLyxHOx51y8hJbm030gSgI6en/DuIDpR
ToycjWAWxTZ6W7Xoa2FPLNenzH8nZ7Trg1Mg+nZLQzKXHBRmo7NbPHXovbnAG2bq
9xmojwMyeLcCQ2s5JxtN
=75wy
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--===============5446533028908567917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5446533028908567917==--
