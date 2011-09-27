From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: In what branch is work for non-snooping mode? (was:
 `hda-intel: spurious response` several times in output of `dmesg`)
Date: Tue, 27 Sep 2011 22:44:44 +0200
Message-ID: <1317156295.3569.2.camel@mattotaupa>
References: <1314185760.3628.30.camel@mattotaupa>
	<1314284537.26121.6.camel@mattotaupa>
	<1314785943.3769.30.camel@mattotaupa>
	<CACTFLANPdSzg9KMhjdgn_=kuQZq+EnwA2cw0t+QT1RoWQ=nwCA@mail.gmail.com>
	<s5h8vpu85z9.wl%tiwai@suse.de> <1315951908.4138.13.camel@mattotaupa>
	<1316370484.7061.103.camel@mattotaupa> <s5h39fskhl4.wl%tiwai@suse.de>
	<1316436647.4171.4.camel@mattotaupa> <s5h62ko4qlb.wl%tiwai@suse.de>
	<1316457599.6128.12.camel@mattotaupa> <s5h39fif8q9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2390829081780064884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 694D62451E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 22:44:57 +0200 (CEST)
Received: from f053035062.adsl.alicedsl.de ([78.53.35.62]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1R8eWR-0004aq-BK
	for alsa-devel@alsa-project.org; Tue, 27 Sep 2011 20:44:59 +0000
In-Reply-To: <s5h39fif8q9.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org


--===============2390829081780064884==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-o5c4b+a5444lM9QacMgk"


--=-o5c4b+a5444lM9QacMgk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 27.09.2011, 14:52 +0200 schrieb Takashi Iwai:

[=E2=80=A6]

> BTW, I'm checking the non-snooping mode, and it might help in some
> corner cases like yours, too.  Could you test the patch below?
> It might be fuzzy to apply to 3.0, but should be trivial to edit by
> hand.

I would build it right from a branch in your repository/tree. In what
branch is that in? Searching for =C2=BBsnoop=C2=AB in branches `master` and
`for-next` did not show anything.


Thanks,

Paul

--=-o5c4b+a5444lM9QacMgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk6CNbwACgkQPX1aK2wOHVh6ugCfdKMgMlc3iAzS3zhO6XuAQGAA
MZkAn0FIoAnUuKcWNR1IbQlElXsCDTUv
=AknI
-----END PGP SIGNATURE-----

--=-o5c4b+a5444lM9QacMgk--


--===============2390829081780064884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2390829081780064884==--
