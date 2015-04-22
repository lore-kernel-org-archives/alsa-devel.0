From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 1/9] ASoC: hda: Add helper to read/write to
	dsp mmio space
Date: Wed, 22 Apr 2015 09:20:14 +0530
Message-ID: <20150422035014.GD2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
 <20150420214638.GX14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0042091061978517331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6840226047F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 05:52:53 +0200 (CEST)
In-Reply-To: <20150420214638.GX14892@sirena.org.uk>
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


--===============0042091061978517331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 10:46:38PM +0100, Mark Brown wrote:
> On Fri, Apr 17, 2015 at 06:45:59PM +0530, Vinod Koul wrote:
>=20
> > +u8 ssth_readb_traced(struct ssth_lib *dsp, u32 offset)
> > +{
> > +	u8 val;
> > +
> > +	val =3D readb((dsp)->mmio_base + offset);
> > +	dev_dbg(dsp->dev, "readb offset=3D%#x val=3D%#x\n", offset, val);
> > +
> > +	return val;
> > +}
>=20
> Much of this looks like a MMIO regmap, there's the memcpy() bits too
> which aren't but otherwise...
Yes they are. memcpy bits are to copy the IPC mailbox payload data to aDSP
RAM which can range from few bytes to couple of KBs

Thanks
--=20
~Vinod

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVNxp2AAoJEHwUBw8lI4NHKKQP/1xD5kK5NBNCBPVlVTcWoXfr
xwh12ogGFaRKEN2OUGoe6NrZ1oJSHf0H1BjP65JaFWx17HzSrTK95Jf52GF3xoOV
O2HR1KVcV1ELl/wZohyzZbgpslwpfuMkpJJXTgIoyWyI8agVJYf0CedCho9gXlhS
/jpWPCkocHafJq8oFvBZRJCBqiSgqpeOgKpSdUwGFmhHVtEY3E7hCAyQrSKhWmyO
AND9So8jRHGGUZ22oW7H42gkNGOQkj/4RUmhBXxaAcHTuW8z/kIFBIO8cDS/CNJl
+r3e+udTljkvcB3MdMGrNDTqsw4WTNYwVIeFDak3utYPH0Qfpmbk76tXh77igVOk
nuWL5AgcpAbbouKaNUtUU3evA3gC06G31AtL/pxGY8yk0axxU0uFLWtx3gq572w4
3iJc5Megu+6ojpeza1+W6k5SMjf/yByUeW1mWF2WRBu2UQCNxO4Jjc/HwhLFBcnk
RFTv9TNFzYexSKU2XQM7MqBJ8VK6822CbxMc180oGZL1MDlHwJVy6BmwwEhXRy7t
6T3dMOLAml4e05rzqW0qUK4G9mIgFLRfEoOTgHjNGwvepOD6y50h9klI7RjiwAr0
yew10+mIyE+vhHtWZ28we7oAIqY106D/O+CZXD9eFp2dUF/skVnMVET0ochNEi98
UG1f/Es5W4AscVPBQIid
=MlCY
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

--===============0042091061978517331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0042091061978517331==--
