From: Frank Becker <fb@alien8.de>
Subject: commit 7b2bfdb broke sound card detection on my Lenovo
	T400s
Date: Mon, 6 Sep 2010 19:04:21 +0200
Message-ID: <20100906170421.GA2957__7081.24615853212$1283934044$gmane$org@alien8.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698327439300656302=="
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0698327439300656302==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please always CC me since I'm not subscribed to the mailing lists.

I have a problem since commit id 7b2bfdb (about 2.6.35-rc2) up to the
latest HEAD on my Lenovo T400s laptop. Just found out while testing Ubuntu
10.10.

Problem is: Headphones don't work any more, internal Microphone doesn't
work any more. However, if I load snd-hda-intel with the option
model=3Dideapad the mic and the headphones work perfectly well again. For n=
ow
that is an acceptable work around. However, before the aforementioned
commit I didn't have to provide any module parameters.

Before rev 7b2bfdb I had:
=E2=94=94[a8@t4]-~=E2=86=92find /proc/asound/card* -type f | grep codec | x=
args grep \
    "^Codec\|^Vendor Id\|^Subsystem Id\|^Revision Id"
Codec: Conexant ID 5069
Vendor Id: 0x14f15069
Subsystem Id: 0x17aa2132
Revision Id: 0x100300

Starting with rev 7b2bfdb I get:
=E2=94=94[a8@t4]-~=E2=86=92find /proc/asound/card* -type f | grep codec | x=
args grep \
    "^Codec\|^Vendor Id\|^Subsystem Id\|^Revision Id"
Codec: Conexant CX20585
Vendor Id: 0x14f15069
Subsystem Id: 0x17aa2132
Revision Id: 0x100300

BTW, all the bisecting is done out of the linus.git tree.

Thank you for looking into that. I'm happy to provide more information or t=
est
patches.

Thanks,

    Frank


--=20
Frank Becker <fb@alien8.de> (jabber|mail) | http://twitter.com/41i3n8
GnuPG: 0xADC29ECD | F01B 5E9C 1D09 981B 5B40 50D3 C80F 7459 ADC2 9ECD
SILC-Net: a8 | Home: http://www.alien8.de | <<</>> http://www.c3d2.de
"> Freedom is just chaos, with better lighting. <"  Alan Dean  Foster

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyFHxEACgkQyA90Wa3Cns0h7ACggYWl5IadRhl+zAoA1EaxEn+u
RSAAniMc5MRCb9TXc1YrT084Hwm0Gepr
=HwLg
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============0698327439300656302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0698327439300656302==--
