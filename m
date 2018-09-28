From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Fri, 28 Sep 2018 17:28:05 +0200
Message-ID: <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
Reply-To: sbahling@suse.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6971893102387207792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A7E83267738
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 17:28:07 +0200 (CEST)
In-Reply-To: <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org


--===============6971893102387207792==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-XqDXKRUBnJ+2cCiDoobI"


--=-XqDXKRUBnJ+2cCiDoobI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Fri, 2018-09-28 at 12:44 +0900, Takashi Sakamoto wrote:
> Hi Scott,
>=20
> On Sep 24 2018 18:32, Scott Bahling wrote:

> >=20
> > The kernel was unstable and the system hard locked frequently with the
> > patches enabled (with and without the GFP_KERNEL patch). But I was able
> > to map out all the controller functions to the bits in the first 16
> > quadlets. I will write up my findings and send them later.
>=20
> I'm sorry but I have applied wrong changes to the remote branch for
> kernel patch. It includes three issues:
>=20
> 1. call vfree() to memory object allocated by kmalloc()
> 2. bring kernel oops due to double free corruption of 'tscm->status'
> 3. invalid page mapping of 'tscm->status' to process' VMA
>=20
> I pushed additional three patches. Would you please test with them?
>=20
>   - 1777454 firewire-tascam: fix kernel oops to call vfree() to memory=
=20
> object allocated by kmalloc
>   - e11d941 firewire-tascam: fix double free corruption
>   - 5e7fef9 firewire-tascam: use one page for mmap(2)ed data
>=20
> Espeially, when allocating in kernel logical space instead of kernel
> virtual space, I should have kept one page for 'tscm->status' because
> kmalloc() allocates memory object unaligned to page boundary by kernel
> SLAB/SLOB/SLUB allocaters. This is a cause which you cannot see updated
> data. A page mapped to process' VMA doesn't include region of
> 'tscm->status' data correctly.
>=20
> Again, I'm sorry to lost your time due to this kind of my stupid
> codes...

No worries! It did not waste too much time at all. I assumed it's just
quick test code anyway. I was able to get the button press events and
control levels mapped to the quadlet bits which was my goal (I'm still
documenting my findings).

I will test your new patches this weekend and let you know if it works
better.

Are you still thinking to try to make mmap the solution to pass the
control data to userspace, or do we need to find another method in the
long run?

Regards,

Scott
>=20

--=-XqDXKRUBnJ+2cCiDoobI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAluuSIUACgkQAst8aI6U
pxKvAxAAncuhqqgcGRk8HPEPIArUdwOIsR+2Rd0D2axTGdI5q8kF8HIJBl8TCZrk
mMvKx7cEAs2FPyMyl15KjByjbZBpJkiMoKexLjWIU80pFQIa3FfyCEwYJUPd/hwQ
6xl4BN1qdz3Pl6Lngr/i7wXLw/GWDeV3EcH3ys3t54foFpc36EOYwmvDyHuIRTAG
485vSFOt+lrcdRez8M4afHb1Y/h8RA9Wm8GaX+q6Hl+BnFSU2xzq2sP9+UDsjVQH
VHSjDV1v728uY9Lxrn1YB81SV98p0AAWBPo+deG12RlcRuP4LgWEmN/B+kHpB6VC
yZDSJ8f0TlGa7wsdA3Z3wBPSPEnfiFvrgctNs+26QW+I2SDEJO0Yk/IoG9SDB1dQ
MUGbVNV0JhRpTlMpwXzmyiVDa0o+vihBJUm/2SZOf25so2Gw9b8nkfme7gaeToy2
NghFDNlBoYWP5eLww8AmJLmjytwjCFrsaPx3QpZlUG8tNS7WSZlaPE57AIH1RKOD
vZIvXLKdPxGzwd84Q2BIQ/7fMQfdV1WFM8Smne3JQKYikxJtzuJepyaXzqyFr93c
+CMuMkbSdeEX+ng9Meh8y0Pra/UuXe3MnpTpm5evEW8vGbZ5ExgeeeVjEh3bDDmn
aOMIYEerfkIuTufwXj/TG8khzDNIIyYw7cWWvaj8DHcNFAjAL0Y=
=7Jjn
-----END PGP SIGNATURE-----

--=-XqDXKRUBnJ+2cCiDoobI--


--===============6971893102387207792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6971893102387207792==--
