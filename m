From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] [PATCH] amixer and special
	'front...' channels
Date: Sun, 8 Jul 2007 00:19:25 +0200
Message-ID: <20070707221925.GA31973@frodo.home.lxtec.de>
References: <468FF5F5.1070402@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3962234597876910825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 1628F103851
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2007 00:19:30 +0200 (CEST)
In-Reply-To: <468FF5F5.1070402@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Decotigny <com.d2@free.fr>
Cc: Ubuntu Core Developers <ubuntu-devel-discuss@lists.ubuntu.com>, Debian ALSA Maintainers <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3962234597876910825==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This isn't Ubuntu/Debian specific and should be applied upstream?

On Sat, 07 Jul 2007 the mental interface of
David Decotigny told:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
>=20
> Hi,
>=20
> Imagine you have this kind of control:
>=20
> Simple mixer control 'Input Source',0
>   Capabilities: enum
>   Items: 'Mic' 'Front Mic' 'Line'
>   Item0: 'Mic'
>=20
> ... and you want to set it to 'Front Mic':
>=20
> shell> amixer sset 'Input Source' 'Front Mic'
> Simple mixer control 'Input Source',0
>   Capabilities: enum
>   Items: 'Mic' 'Front Mic' 'Line'
>   Item0: 'Mic'
>=20
> This does not work ! Because amixer will think that 'Front' is a
> modifier for 'Mic'.
>=20
> Attached is a patch against alsa-utils-1.0.13-1ubuntu5 that solves this.
> With this patch, one can bypass the modifier parsing: one simply escapes
> the parameter with one or more backslash(es), and that's all:
>=20
> shell> amixer sset 'Input Source' '\Front Mic'
> Simple mixer control 'Input Source',0
>   Capabilities: enum
>   Items: 'Mic' 'Front Mic' 'Line'
>   Item0: 'Front Mic'
>=20
> What this patch also does, is that it adds correct identification of
> items. With the original version, given the following enumeration:
>   foo foobar
> Then the parameter 'foobar' will be identified as 'foo', not 'foobar'.
> The patch should solve this potential problem (not tested though).
>=20
> Bye,
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>=20
> iD8DBQFGj/X0ld7vhusVrCERAjIZAJ9w9GLD+QBwDCaTs32hpW6i9nVMfgCfdS5w
> jhipZ2jm87fq4zx4f5Q9Vsc=3D
> =3DM2KP
> -----END PGP SIGNATURE-----

> diff -ru alsa-utils-1.0.13/amixer/amixer.1 alsa-utils-1.0.13-mine/amixer/=
amixer.1
> --- alsa-utils-1.0.13/amixer/amixer.1	2006-09-29 04:53:26.000000000 -0700
> +++ alsa-utils-1.0.13-mine/amixer/amixer.1	2007-07-07 13:09:04.000000000 =
-0700
> @@ -44,11 +44,14 @@
>  The parameters \fIcap, nocap, mute, unmute, toggle\fP are used to
>  change capture (recording) and muting for the group specified.
> =20
> -The optional modifiers can be put as extra parameters to specify
> -the stream direction or channels to apply.
> -The modifiers \fIplayback\fP and \fIcapture\fP specify the stream,
> -and the modifiers \fIfront, rear, center, woofer\fP are used to specify
> -channels to be changed.=20
> +The optional modifiers can be put as extra parameters to specify the
> +stream direction or channels to apply.  The modifiers \fIplayback\fP
> +and \fIcapture\fP specify the stream, and the modifiers \fIfront,
> +rear, center, woofer\fP are used to specify channels to be changed. If
> +there is a confusion between the parameter and these modifiers, then
> +any character in the parameter may be escaped with a backslash to
> +disambiguate: '\\Front Mic' will be understood as "parameter 'Front
> +Mic'", and not as "modifier 'Front' applied to 'Mic' parameter".
> =20
>  A simple mixer control must be specified. Only one device can be control=
led
>  at a time.
> diff -ru alsa-utils-1.0.13/amixer/amixer.c alsa-utils-1.0.13-mine/amixer/=
amixer.c
> --- alsa-utils-1.0.13/amixer/amixer.c	2007-07-07 13:03:39.000000000 -0700
> +++ alsa-utils-1.0.13-mine/amixer/amixer.c	2007-07-07 12:59:19.000000000 =
-0700
> @@ -1333,6 +1333,16 @@
>  	return def;
>  }
> =20
> +/** Transform '\a\b c \de' into 'ab c de' */
> +static void unescape(char * arg)
> +{
> +  char * c;
> +  for (c =3D arg ; arg && *arg ; arg ++)
> +    if (*arg !=3D '\\')
> +      *(c++) =3D *arg;
> +  *c =3D '\0';
> +}
> +
>  static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
>  {
>  	char *ptr =3D *ptrp;
> @@ -1347,7 +1357,7 @@
>  		if (snd_mixer_selem_get_enum_item_name(elem, i, sizeof(name)-1, name) =
< 0)
>  			continue;
>  		len =3D strlen(name);
> -		if (! strncmp(name, ptr, len)) {
> +		if (!strncmp(name, ptr, len) && (ptr[len] =3D=3D '\0')) {
>  			if (! ptr[len] || ptr[len] =3D=3D ',' || ptr[len] =3D=3D '\n') {
>  				ptr +=3D len;
>  				*ptrp =3D ptr;
> @@ -1428,6 +1438,7 @@
>  		dir =3D dir_mask(&ptr, dir);
>  		if (*ptr =3D=3D '\0')
>  			continue;
> +		unescape(ptr);
>  		multi =3D (strchr(ptr, ',') !=3D NULL);
>  		optr =3D ptr;
>  		for (chn =3D 0; chn <=3D SND_MIXER_SCHN_LAST; chn++) {

> _______________________________________________
> Pkg-alsa-devel mailing list
> Pkg-alsa-devel@lists.alioth.debian.org
> http://lists.alioth.debian.org/mailman/listinfo/pkg-alsa-devel

--=20
  "Talking much about oneself can also=20
   be a means to conceal oneself."
         -Friedrich Nietzsche

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkBFs3Ig8bsVPf7ARAiwIAKC6j6tL8UMwANFVCmNG7NPX0C3JzACeMj9J
Uxnd1oxVRJXwdyZxhVQf3Is=
=ML9r
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--===============3962234597876910825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3962234597876910825==--
