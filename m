From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] cs42l52: use same init values for
 MASTERA_VOL/MASTERB_VOL.
Date: Wed, 22 May 2013 13:34:25 -0500
Message-ID: <20130522183425.GW1627@sirena.org.uk>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-2-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5668239476020503847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FB342608ED
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:34:42 +0200 (CEST)
In-Reply-To: <1369243167-28700-2-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


--===============5668239476020503847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7rOJgaucv5jay56"
Content-Disposition: inline


--w7rOJgaucv5jay56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 07:19:24PM +0200, Nicolas Schichan wrote:
>=20
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Why?

> -	{ CS42L52_MASTERB_VOL, 0x00 },	/* r21 Master B Volume */
> +	{ CS42L52_MASTERB_VOL, 0x88 },	/* r21 Master B Volume */

Note that the register defaults need to reflect the default value
for the registers.

--w7rOJgaucv5jay56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnQ+uAAoJELSic+t+oim9Q4kP/RShKTl7YNXrB3nproyjP9zN
6v0ssoVpg4w2eCnRj1u8nB6D9JpYN2PIPESb/+oKellWUdQN56wN9+MxR2Tf4coV
kogrOocbe1a2pg6v73H5RHzJyEo+EO/cbjgjevICSY7o62m6tzs0Bj7m9+flII+g
PkwatxW72DnlhLJ1W3n+yXF+fl5Xi3aXU/Zu8bLGdfpAfIwbmzdCq7csODKTUumz
VF9YXMyCOUZ6oNulNIm1zrtOqQ/mlfqrSu3UQE9roSXMuzzDnfWOL3VHu0LZbb/N
jF8S6DM+uB/cz2hreqHZhlKj+oxriKY3B0IDhu7riwUu1C/AyWp6SmukDuurqKCS
p/VFU7Uo47/IlpH7hC4rgXBlu4omUSN99prwW4Dr38iKK3qB+OiEzquUjLWypYWF
ro4wgpbnInEtbcJgGPEWiVwldLoJL54NUFBEpzWfnfOQ845cAxck8nWmUpUaDC48
xmOOLbkFyMz8KTK/Z+5U1rITylE7X9aZvRJUwcRvuqdp1E686Gqh7lnSkZrv7jV/
yJMRjdbaeREI6hqhZ5Z0tHpya9D4VkIIpqqeasdY71rtldfEC1e70hV0Iutr2MZR
ZS1GbZnnIeMeI7wBf1WXhTmvaiWlvARAJiCz/LKlITN1chyLcsxSrZWcVom9F2p3
hvTep0XL9lXlANl2L2bG
=6/k+
-----END PGP SIGNATURE-----

--w7rOJgaucv5jay56--

--===============5668239476020503847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5668239476020503847==--
