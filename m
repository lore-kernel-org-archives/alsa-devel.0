From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] aoa i2sbus: don't overwrite module
	parameter
Date: Thu, 23 Oct 2008 16:49:59 +0200
Message-ID: <1224773400.6002.37.camel@johannes.berg>
References: <1224763060.6569.3.camel@johannes.berg>
	<s5h63nj5ke0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9170070814204107646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 29AE5103912
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 16:50:58 +0200 (CEST)
In-Reply-To: <s5h63nj5ke0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============9170070814204107646==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9vu8yp7W0K67D4u99Mq/"


--=-9vu8yp7W0K67D4u99Mq/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-10-23 at 18:47 +0200, Takashi Iwai wrote:
> At Thu, 23 Oct 2008 13:57:39 +0200,
> Johannes Berg wrote:
> >=20
> > We shouldn't modify a global variable here.
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> Applied.  This seems a good thing to go to 2.6.28, so I'll put
> it to the next pull request.

Heh, well, it doesn't _really_ matter, it's just cleaner for reporting
to userspace via sysfs what the module parameters are. It's been that
way since I wrote it over two years ago, so ... up to you, I don't
really care.

Thanks for taking it.

johannes

--=-9vu8yp7W0K67D4u99Mq/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJAI8UAAoJEKVg1VMiehFYm+EP/0WXjXYnAbUAHGLxlCrcDW3e
3ojuF874M9iKArY6keoyC1FdJOXOfRyYBNS37L421C0a9ekl1Tx9ncUW9RkAouEC
gmTGl5i8D8eQ+M2zgDDNzo4T8mWzAwv6SxNVkyW66w23/lSCGpuZ9OPLsFKKX+ht
2u72/T+slI1KEeMIlBIO6vyqq7D5vQuNrJlCKn23Bod5l9q7z92oIXVF6Yi0p/qY
nLjZaHcfwPoupSqZJTtjhYcIfow7AWCa0BuH7jq05/aWwwrCwiyzV4mQmKnCmQjN
Q0fMthwqx+lHTPm7QOOBK9vaTka56SUQh1e6seYXga7oCVFrDtPDVzazyM8w/raG
2TWBhwNdcq5K6OgN+rAxwJEd24EtOppjb2rdjDSvkLypLZuH6IIzOM1sVi57j9mO
FuV/5W4bi3blaDL7eA/Z/MMxA5qViEDo60l/FySAWWyKkyoZ+fvgFGxfmtBO6P74
SgZNOWrdwz4eoovaVNFQHDistoMsayiYgYSA6ADAzBaS2u6ucBgYe65XeuO+D/Pa
v4DUXLubOP1wA7l/13zmcRpPbYRQ4UWoyl5Geg8jcDFqWcGmH4XuAJJqvacn6/PM
HaN+3OQ5i02/Z/puggc+VIqSyI8Zgi1i9QrJqwenjV01y9pHKb6kfCh9HufJ+G/o
MRo15Y3tntqwznD6cN1R
=tJII
-----END PGP SIGNATURE-----

--=-9vu8yp7W0K67D4u99Mq/--


--===============9170070814204107646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9170070814204107646==--
