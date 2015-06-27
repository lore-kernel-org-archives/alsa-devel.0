From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [alsa-devel] [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Sat, 27 Jun 2015 07:59:58 +0200
Message-ID: <558E3BDE.5070708@web.de>
References: <53B51B63.8060809@canonical.com> <53B51CF3.8090102@web.de> <53B52146.9050300@canonical.com> <55603F22.8070103@web.de> <CAN8cciZYZ4setSj7dgPqQUVrBrr98tSvofLrD_0zvyQqkWfd2Q@mail.gmail.com> <5560A93E.7060607@web.de> <558A4216.8010401@web.de> <558A6E80.7010003@canonical.com> <558BDFD4.9060301@web.de> <558CB778.5020307@canonical.com> <20150626224946.GA11254@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TRuHMBPgMxiXphf39RSBaEvNH1Ucj05RC"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150626224946.GA11254@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Hui Wang <hui.wang@canonical.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alex.hung@canonical.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TRuHMBPgMxiXphf39RSBaEvNH1Ucj05RC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2015-06-27 00:49, Henrique de Moraes Holschuh wrote:
> On Fri, 26 Jun 2015, Hui Wang wrote:
>>> Again, I'm on a X121e, and that has only a single physical LED for
>>> signaling the power state. The mute button is behind key combination =
of
>>> the keyboard.
>>>
>>> Jan
>> There is no reason to change a power button to a reset button after
>> accessing the acpi device "SSMS", the "SSMS" is for the mute led inste=
ad of
>> the power management.
>>
>> I think it is better you login to the lenovo website and look for the =
latest
>> BIOS image, then upgrade the BIOS on your machine to see if it can sol=
ve the
>> problem or not.
>=20
> Hmm, I think I am missing something here.
>=20
> Please explain _in detail_ what you mean with "changing a power button =
to a
> reset button by acessing the SSMS ACPI method in a X121e".
>=20
> Are we trigering a bug somewhere that crashes the x121e and causes it t=
o
> reboot?

Well, there aren't much details to describe in this case: When this
patch is applied and I press the power button, the device performs a
hard reset. It doesn't reveal if the kernel crashes catastrophically,
causing a triple fault or so, or if the firmware decides to reset the
platform. Reverting the patch or preventing its effect via a quirk
filter like I posted [1] makes the issue go away.

Jan

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-June/078284.htm=
l


--TRuHMBPgMxiXphf39RSBaEvNH1Ucj05RC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlWOO94ACgkQitSsb3rl5xR4GwCg0JA9W2JB4wa7+qKo3wj9mdDO
i9UAnAk/GRC/65dts6cRwRRPDQDWzx7k
=xxrA
-----END PGP SIGNATURE-----

--TRuHMBPgMxiXphf39RSBaEvNH1Ucj05RC--
