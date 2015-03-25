From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] ALSA: hda/via - Add beep controls to VIA
	codecs
Date: Wed, 25 Mar 2015 00:03:41 -0700
Message-ID: <20150325070341.GA22982@odin.tremily.us>
References: <CAN8cciZn1ozWhSZkLCcf8V9fUtnKuqu4uDjjx165XD6J2rbCVw@mail.gmail.com>
 <492ac5c1f00a4e07b44835f87fd5f05e8c4e6253.1427266376.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2535617122125949876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-02v.sys.comcast.net (resqmta-po-02v.sys.comcast.net
 [96.114.154.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 096E32604C5
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:05:42 +0100 (CET)
In-Reply-To: <492ac5c1f00a4e07b44835f87fd5f05e8c4e6253.1427266376.git.wking@tremily.us>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2535617122125949876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 12:01:04AM -0700, W. Trevor King wrote:
>  sound/pci/hda/patch_via.c | 61 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> index 3de6d3d..e4919f8 100644
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c

Oh, this patch was based on v3.19, but I'm happy to rebase it if it
doesn't apply to whichever tip the ALSA development work is done in.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVEl3LAAoJEG8/JgBt8ol8u50P/1P+Ud+QxR4IxDYqNDB2ELMK
PPIPQVnoJFOLOEpJFccz+Psrqf1VpXMaSK0Do48i4aY487hP/r8/tSCCX4HY/rTs
7Qb/GLhCUhq/gFyWzTluLLfp62CSuaKObp89Vwfm1zsSAEQCrkK1uEMXS8KI8GRe
QGjOHqyQvxuKO2wo+066xS+zek5IrPHvNh8l7x4wg1s2DDreIpqTjxzzC0ImfdXS
CxLRKII3OVkUPuRFf/RX78vKAeazSkE6+RZwjF6U4yd4kimuff40yUn7sidy4pyR
Z0q1cd9xnxH1WF/r3S1wVjayVkEmqym3t+U/eo4KQKHiomjQJAPtL6Akte4C2sKr
eElAw8t0HgaDtEGwqz9yH7eb4F6Y7ZrH+A18uAjYNVL4O8fLxHVz+33bYOMcqtuO
GW4qJwDhWvrYIhLWpSL7KM8vSM1iBfVrfpIEAjmFDIb/Z+GJq1tpcgyO21K+kRl8
KFSzXD+Q1atocEfv07LD529n4n4+y9R4wDzoyWCTuf4fsi2fjGNP+GAOhSmLA8T5
BF6XtJ77/FmuhGIPMbBtXjYObpcOShtPi/L7BFn398pV38ZGDdIuKppKPdz5l9Qu
OmBcVe7U9TPuH20GPq1TF0XQoZvv7/0wDSXQaKsouz8W25ztQu1XJuSppE8Ep7pQ
19dear+l/ON7w1pZEpYg
=W7zb
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--===============2535617122125949876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2535617122125949876==--
