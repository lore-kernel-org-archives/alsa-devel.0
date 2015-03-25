From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] ALSA: hda/via - Add beep controls to
	VIA codecs
Date: Wed, 25 Mar 2015 01:10:03 -0700
Message-ID: <20150325081003.GC22982@odin.tremily.us>
References: <s5ha8z1h7iw.wl-tiwai@suse.de>
 <75dc1612e1a507e7f89549e70f83e303d78370dc.1427269200.git.wking@tremily.us>
 <s5h4mp9h5el.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626611508638907627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-01v.sys.comcast.net (resqmta-po-01v.sys.comcast.net
 [96.114.154.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 319DE261B0E
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 09:12:06 +0100 (CET)
In-Reply-To: <s5h4mp9h5el.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1626611508638907627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 09:01:38AM +0100, Takashi Iwai wrote:
> OK, I applied the patch with a slight modification.

4738465c looks good to me.  I should have thought to re-check
patch_conexant.c to see if the code I'd copied had changed.  I'm
looking forward to having this all factored out into a generic
location :).

Thanks,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVEm1aAAoJEG8/JgBt8ol8DeAQAMg7Kccpa8EK+opCCUDl66Sq
knkWPedXAIyF18H7LIJJ3MZvPNBpYaMxIzLcz0HjgoozL24udRaOB4x/MK1np3/l
kWrYagw3mA/o/Rg88BVv8o2dHeFtEEyHkaoYtYRz1PGjYbJ5Rb1NCOioqXVI4BSs
H71kzzcQOktQXG1/snZqGPCqOnrHo1r2KnjChRQv9GjjAFPRn2Y6TmKKdsTnQXYO
xA2N+gOxl/yByGnDO93sCCWFvvrGr4hWc1t7fRpNJg9S8gS5xPvDnmzC15aEwlPV
o8OE6UnKlOO/nMhxPXXrJKjTlmPlJjXnErqCkz547ic0JvoAjIfvjYoXsLdK8HQh
QQz2hFMpBvgsmJt8vXLLQT7k+GsrAojXYztuaI+q21vZpH+4A1XRUR6PvbrW88Jb
ZnM3eVuYe3U/eTcdAdtpMFYMoJB/ymTG7tNUKDofbqIb5XCr2iqQUjgi9+LX5SzH
C0mtSaxA7oOI3PkpJscadmTnTEDeWsJMr7zc5KFoHaxK2hZfAaejdwArCgkgFbhY
L6sXBFtnZKZMAO0UR+5/rT1meAKWXjwnVS2E5GbyTjNqHR2vBROStzX20X4tiTt/
z7Hp72Am1T6fpfjTTURgQq8vbWiK2JI/K0xFiAjLFqtNp1szCI7Gw5W/EiNch8t2
7j7dPjdyJB8V1rYIuwku
=QR23
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--

--===============1626611508638907627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1626611508638907627==--
