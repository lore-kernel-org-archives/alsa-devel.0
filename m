From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Wed, 12 Sep 2018 09:18:20 +0200
Message-ID: <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
Reply-To: sbahling@suse.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6317712683735022303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EED652676B0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 09:18:30 +0200 (CEST)
In-Reply-To: <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
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


--===============6317712683735022303==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ywU8T9E5xaNgtNd0EYDL"


--=-ywU8T9E5xaNgtNd0EYDL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, 2018-09-10 at 16:59 +0900, Takashi Sakamoto wrote:

<snip>

> As long as I know, the image consists of below information:
>   - pos  0-15: control messages from physical control surface
>   - pos 16-23: analog input level
>   - pos 24-31: digital ADAT input level
>   - pos 32-33: digital S/PDIF input level
>   - pos 34-35: (not cleared yet)
>   - pos 36-43: analog output level
>   - pos 44-64: (not cleared yet)
>=20
> When parsing the image, a parser should generate several types of
> events. I prefer to implementing this complicated work in user space
> instead of kernel space. Expecially for pos 16-23/24-31/32-33/36-43, the
> parser should always generate events to notify each of the levels.
>=20
> What we should do is to parsing the image and generate events with
> enough consideration of task scheduling and eventing dencity. The parser
> could be implemented as an application of ALSA sequencer.

Thanks for the details. I can work on deciphering the raw control messages.
My current idea is to set up a netlink socket and stream the control data t=
o
user space just for analysis. I will look into ALSA sequencer to see if I
can understand how that could be used.

I noticed that we are able to control the LEDs from the host via the
asynchronous link. Do you you think the faders are also controlled that way
or would that also go via isochronous packets to the FW-1884?

Regards,

Scott
--=-ywU8T9E5xaNgtNd0EYDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAluYvbwACgkQAst8aI6U
pxKEKg//ftyrJUe96lK+VtqO8CjMlHUnWtqWI7za6nxqtwdgXxyvDoR83b4xnQYa
8Fju+yK5+5iMdm14l20Q75wtDHe02tObUUGNKptXvnJnIwX5y+zljvILyZR/jN01
uCwHBt5cmzNEv4eqx2CBhagJIe+RNdsHJwOCoCe4QQG0dYqtP4WW+BSOs0vK4Qcb
ZDsuSoxj6aS94H2vs/WgVgdDIaeDpRv8PSJ9uXtbMVLUsCu8W3sLda4/jOPBkOun
rdtm96uNYjn8Pr2kzWZjURTXuvY0ij7Nx2T7VEU2r2/loI43oHYPE+Mr3YLhsb8h
5carHhD2Kbxki7PjQPP0jbEg+PxxcGOTfJj1Usl4FM0wRydN4nRi+M7SJzTqU6bF
+YWRRyrsxoRG1uxxmEyxlV9tp17L5i/U+IhpPGNVvnTi7yDS5zSfq3AG/lCWOF4c
QDuJLKZu7rjXHSicK59R1Tutlg8KSmgtVdlKLOjHTX1/lKor3lC+MbXINuU+D9xe
v36zXkfQM8RrhFlZdlgjQOnMRVymb6oXXAYDTzMS1EEkN9wuaeJOSX1WLADo2EfO
r6dwxDLRPFQBmdTrXFq/nPmic5qVC/bxONneVGDylDF8Arfu7ADR/PZlGq4CSbAR
JOdLyqAJZ72TjQxVGZfxk1za0HRJnILEyd0Z7srQ8nghADOILG0=
=9iUh
-----END PGP SIGNATURE-----

--=-ywU8T9E5xaNgtNd0EYDL--


--===============6317712683735022303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6317712683735022303==--
