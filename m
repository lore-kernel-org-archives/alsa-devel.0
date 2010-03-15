From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: aconnect patch
Date: Mon, 15 Mar 2010 15:32:25 +0100
Message-ID: <1268663545.9635.10.camel@mattotaupa>
References: <4B9E306F.8070705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6039441628063206972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 58FC7103809
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 15:32:29 +0100 (CET)
Received: from f053034098.adsl.alicedsl.de ([78.53.34.98]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NrBLH-0004bv-51
	for alsa-devel@alsa-project.org; Mon, 15 Mar 2010 14:32:27 +0000
In-Reply-To: <4B9E306F.8070705@gmail.com>
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


--===============6039441628063206972==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Z3b0JCkzBWplN7Xrpjgx"


--=-Z3b0JCkzBWplN7Xrpjgx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear lieven,


Am Montag, den 15.03.2010, 14:04 +0100 schrieb lieven moors:

[=E2=80=A6]

> Please let me know what you think about this patch, and if you think my r=
easoning is sane...

thank you for your work. Unfortunately your MUA mangled the output.
Could you please resend without linebreaks.

It looks like you used `git format-patch` already. Great! You can also
use `git send-email` if you plan on submitting more patches [1].

Anyway, could you also add a `Signed-off-by` line (`git commit -s` or
`git format-patch -s`) and add a more descriptive summary as `aconnect
-x: Do not update index after removal of connection.`. (This is just
taken form your summary.)

Please make sure when resending to not this by =C2=BB[PATCH v2]=C2=AB in fr=
ont of
your subject line, e. g. `git format-patch --subject-prefix=3D"Patch v2"`
(see `git help format-patch`).


Thanks again and sorry for the long response,

Paul


[1] http://git.wiki.kernel.org/index.php/GitTips#Using_gmail_to_send_your_p=
atches
[2] http://elinux.org/Git_usage#Sending_with_Gmail


--=-Z3b0JCkzBWplN7Xrpjgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkueRPMACgkQPX1aK2wOHVhQ5QCeLmKgdSOu5jCb4QhkFUX90XLF
fhgAn2EfIMe8e/Wpd1twigRASoqDAVfc
=K8cN
-----END PGP SIGNATURE-----

--=-Z3b0JCkzBWplN7Xrpjgx--


--===============6039441628063206972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6039441628063206972==--
