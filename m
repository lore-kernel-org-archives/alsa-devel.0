From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: OT: applying patches (was: [PATCH ALSA HDA 1/1] Fix
 alc662_dac_nid and change 6stack-dig to 5stack-dig)
Date: Fri, 08 Apr 2011 11:28:51 +0200
Message-ID: <1302254931.7217.8.camel@mattotaupa>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
	<BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2248138493487688356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 51997103A1D
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 11:28:56 +0200 (CEST)
Received: from f053045107.adsl.alicedsl.de ([78.53.45.107]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q87zu-0007sl-04
	for alsa-devel@alsa-project.org; Fri, 08 Apr 2011 09:28:59 +0000
In-Reply-To: <BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
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


--===============2248138493487688356==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-FByvzTmpewXR1RCwKO+U"


--=-FByvzTmpewXR1RCwKO+U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Valerio,


please adhere to the netiquette [1] and use interleaved style [2].


Am Freitag, den 08.04.2011, 10:38 +0200 schrieb Valerio tesei:

> I spent a little time reading sound documentation but doesn't find anythi=
ng
> about how to apply a patch to snd-hda-intel, but it is needed? there is n=
o
> an "patch auto detect"? i enable the patch option in HDA-Intel kernel
> config, this WE i will study more, Takashi could you please give me
> documentation about patch applying?

You have to apply the patch file using the following command.

	patch -p1 < /path/to/patch/file

I think Takashi put a diff in his message. Just copy those lines into a
file and apply it like above from the top source directory.

If you have a patch created using `git format-patch` you can simply
apply that using `git am /path/to/patch`.

[=E2=80=A6]


I hope that helps and I am sorry that I cannot answer the other
questions.


Thanks,

Paul


[1] http://en.opensuse.org/openSUSE:Mailing_list_netiquette
[2] https://secure.wikimedia.org/wikipedia/en/wiki/Posting_style#Interleave=
d_style

--=-FByvzTmpewXR1RCwKO+U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2e1UwACgkQPX1aK2wOHViItQCeIPg+3iBqXPgeN7SKTNROFXxD
ZNkAnAm5YH3vqQ10XBz1Yqywl/sLdPEp
=I4fr
-----END PGP SIGNATURE-----

--=-FByvzTmpewXR1RCwKO+U--


--===============2248138493487688356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2248138493487688356==--
