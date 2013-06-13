From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [alsa-devel] usb-audio validation fixes [3.0, 3.2]
Date: Thu, 13 Jun 2013 02:30:39 +0100
Message-ID: <1371087039.10688.9.camel@deadeye.wl.decadent.org.uk>
References: <1369704469.3469.412.camel@deadeye.wl.decadent.org.uk>
	 <s5hobbv7h4p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0qc7DPcSaG9gogu/u7f0"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hobbv7h4p.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Xi Wang <xi.wang@gmail.com>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--=-0qc7DPcSaG9gogu/u7f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2013-05-28 at 08:28 +0200, Takashi Iwai wrote:
> At Tue, 28 May 2013 02:27:49 +0100,
> Ben Hutchings wrote:
> >=20
> > It looks these fixes are suitable for inclusion in the 3.0.y and 3.2.y
> > stable branches:
> >=20
> > commit 4fa0e81b83503900be277e6273a79651b375e288
> > Author: Xi Wang <xi.wang@gmail.com>
> > Date:   Sun Jan 8 09:02:52 2012 -0500
> >=20
> >     ALSA: usb-audio: fix possible hang and overflow in parse_uac2_sampl=
e_rate_range()
> >=20
> > commit 8866f405efd4171f9d9c91901d2dd02f01bacb60
> > Author: Xi Wang <xi.wang@gmail.com>
> > Date:   Tue Feb 14 05:18:48 2012 -0500
> >=20
> >     ALSA: usb-audio: avoid integer overflow in create_fixed_stream_quir=
k()
> >=20
> > Do you agree?
>=20
> If it's applicable to old kernels, yes, it's worth.
> I didn't mark it simply because the patch hasn't been tested with the
> actual hardware.

So no-one's tried fuzz-testing?  This is just based on code inspection
or static analysis?

> But the change itself is simple, and should be safe to apply.

Right, I've queued these up for 3.2.

Ben.

--=20
Ben Hutchings
friends: People who know you well, but like you anyway.

--=-0qc7DPcSaG9gogu/u7f0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUbkgv+e/yOyVhhEJAQpn+g//VCIAgEsRy6zfhcLQay1po4RYmnm9MU0x
O18O3A3Fy/EZUui7Y0wR6hM/CqE0qmiMVDV+xXyzNNOC7Ym886tGWiNl66mXNIC4
2MSbCoejajUGQBGna3jykfXEr+BqXgmC56838J0ynClVva7CgLIoB/tbeoTjJ0w7
0Uskmn/hbKlTaFiW/odIb9B3LuYyEvA+WukkrLlktPog6yGA9NzgJLdoRmcuk1/2
EpdzluS4dcppSOgZ0dvoNrw+cdEzMBL9AtAGdG35B59vgp6FDGQlQkTMiP6y6KfD
jHnfIXTBJ/ukCtZ2ErTlShbfudpaIINtQo5iA6af52D/Bs0E0u6DUY6YOPktHaO2
vCl9dEdbYXB2sMuCt6RGVj4a9znhBK6o9ENzqQgJgVY+iE8A/pSgd1F5/X3omA9T
lItWCacreDyJ/KuqdvBzVMHI+8Zlu+U8leDdJZN/g5ac3qGEPVnS8Ilrz+z2pj9E
Q0GDD1NYg7YLe8OWt+/HEHGvFEiGmIxhRlRrNiU7meVvCNUJbNuR8JGT+EzYARTu
q/5Ls6uz5Q3QKE/c3+2T0G1M4JeP0SmgmXLoUsZpTAokfWbYNUclG6uJY7iiu0VA
fjVDF+tFzkfkw5jbSEncrlstXlXCVzNaphytvYryOD7rQItE2ebrqj6EkoXUun82
07qRFKrWmaw=
=1OsQ
-----END PGP SIGNATURE-----

--=-0qc7DPcSaG9gogu/u7f0--
