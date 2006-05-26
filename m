From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [PATCH] Allow ioplugins to override snd_pcm_delay()
Date: Fri, 26 May 2006 14:46:16 +0200
Message-ID: <4476F898.3030202@cendio.se>
References: <4476CC83.8080103@cendio.se> <4476F794.7010306@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0775913146=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 414F9155
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 14:46:19 +0200 (MEST)
In-Reply-To: <4476F794.7010306@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0775913146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2E1B57DCEAA35EE2BC05C48A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E1B57DCEAA35EE2BC05C48A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

James Courtier-Dutton wrote:
> Pierre Ossman wrote:
>> Some io plug-ins might want to adjust the reported delay value and not=

>> strictly follow the current buffer usage (that's why we have two calls=

>> after all).
>>
>> Allow them to specify a delay() callback and use the previous behaviou=
r
>> if they don't.
>>
>> Signed-off-by: Pierre Ossman <ossman@cendio.se>
>>  =20
> Can you give an example of a plugin that would want to adjust the delay=

> value?
>=20

The polypaudio backend, which is why I submitted this patch.

The recently released padsp (esddsp-equivalent) has much better latency
reporting than the ALSA to polypaudio plug-in. And we just can't have
OSS applications outperforming ALSA ones. ;)

--=20
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


--------------enig2E1B57DCEAA35EE2BC05C48A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdviZ7b8eESbyJLgRAp3wAJ47jLrGWwp2Qo9DzZYzQ5CktPteVgCfaJI1
9SMWqldlsLMEqawXdnkm6dc=
=Us3+
-----END PGP SIGNATURE-----

--------------enig2E1B57DCEAA35EE2BC05C48A--


--===============0775913146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0775913146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0775913146==--
