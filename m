From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 20:12:09 +0200
Message-ID: <1145383929.4116.85.camel@localhost>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <s5hd5ffxc1r.wl%tiwai@suse.de> <1145382922.4116.81.camel@localhost>
	 <s5hodyyvjxr.wl%tiwai@suse.de> <1145383590.4116.83.camel@localhost>
	 <s5hmzeivjom.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FdWCmpwmOcJhR1eoJzkh"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (195.210.38.204.no-dns.no-wires.co.uk [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 670DD183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 20:12:16 +0200 (MEST)
In-Reply-To: <s5hmzeivjom.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-FdWCmpwmOcJhR1eoJzkh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 20:10 +0200, Takashi Iwai wrote:

> That's the point.  The resume is handled just like another type of
> xrun, which requires a recover.  So, the app needs to know what is
> going on.=20

Maybe I'm misunderstanding this, but it isn't an xrun is it? I thought
an xrun was when the app was too slow, but in our case the
'hardware/driver' is too slow, which doesn't really do anything.

johannes

--=-FdWCmpwmOcJhR1eoJzkh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAREUr96Vg1VMiehFYAQJxyQ//ShC8koHidcztOjAunvuUTqxgxpJwYTXl
YEj198LpXJVzmhubZTiiVMM8TKGHfS6m/d4jAGtoquC/1knLpGjRT5JTY1AQFDI5
yLPDvc2bMir9mbxT5EOKwTWsda3ot+UljFqSV9RsMPt2nmdwnEmPkboQq71Z6T/M
sCjxs97g2nzl25x078sz71k8mbFZt54w4rrBBQfAED1TxnLPgNJvygRCsRqTSaC8
fgola5Tcd8b8VRnEUVaTuYQhvzcWfmvGYzph47gbFMSJ8yu4koPs+WarFlNohUCx
+bvturS66zkfj87YtNqzZniQ3YZkIOrXn6FqmCxakp5GJDCrLiS4ceV0OdAFvSu8
kPLVA/vDww1SkA3B3PlMUkCutbNcW+65Ql7Dc7vvJFL5K3PYaYGc8aSO48FOmmqm
E+KvzFNjv111x4sy2rfDcsgSzY1PkyobFNdH4t8kMDeLWChxuv8JH2k3dHveKNg0
JMYCw9BKJcYZEEKaXQWHzOmZW3+oFYUaOVg34TWcveY3OXllknj0Ek3rFWkrf1hw
MNDvyLymj7fmKxZtph7V7u6QnIk0aprS3xGbseW8cq2yg9jrcVNSIctX8Lbp6L7Y
S0pAK7oBRGFhtV29/t+QAvwQkK1JWvafg0P9A4dnALXlRQdcJmJcTh5b5Byafg31
3I+8j5lV0qA=
=cp1P
-----END PGP SIGNATURE-----

--=-FdWCmpwmOcJhR1eoJzkh--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
