From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa: headphone detection wonky on PowerBook5, 4
Date: Mon, 26 Jun 2006 17:33:50 +0200
Message-ID: <1151336030.7608.149.camel@localhost>
References: <87lkrom70h.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1124580858=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2706F26F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:23:47 +0200 (MEST)
In-Reply-To: <87lkrom70h.fsf@briny.internal.ondioline.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Collins <paul@briny.ondioline.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1124580858==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UPaCblg4R4//oDt2xTFk"


--=-UPaCblg4R4//oDt2xTFk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 21:43 +1000, Paul Collins wrote:
> Where "wonky" means: only unplugging is detected, not plugging.  I'm
> not sure why I didn't spot this earlier.=20

Actually, come to think of it, I know why you didn't. You probably
loaded my drivers after having unloaded snd-powermac and the hw state
was still set to dual edge.

johannes

--=-UPaCblg4R4//oDt2xTFk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJ/+XKVg1VMiehFYAQJNiBAAqRxDyasnxJMnPJ0BjlY2gBNKY9hiVLCB
d+8gjJrCMAhC3NAq3a//jtpsVoStdqQu0JqAyUf/4zrNvybn0Xh+W83a4WB5EvCb
R625jgtZhUjnMDXgNzgScRTVDTMS+dQMQ8A75SKvELtrNl3DLnJJzFMYuZOT5gXV
pW52ORMCG+5R2H3X6KTvDKiCkfAVMy7zinnxPW87SWBcbKccwF28PdJuTt6Cm2M/
NCae5ockFTmPhp54ikdCli368YJ0Z55B/M8XI/N6GtlB3+FwrC0dL/0X8coZlXgS
H07AsQ8CEGZMrDoKbHzsfqyMyfcGKELatNrLMAcwBMTNEUR6dR466NnUYPh3ltT8
B+BUxFSIWnR5Z7gK/t3JxWWC0IKOLxzgVJMWoNQclhR3jq3xSx2Xva0tFtE/rGBi
kJyJ9fPzRmrFFwFgIaxtl5z7olGvY1Z+iS5tR31WODuZUzyAGwq2yKl1/VuzbBQt
TeGuG/0i5YVy5PhWEnOz+Vb2W0BXKIUsJUxAqeiLumhwUQKfdhpGPfLbhzoZbetn
KRBfgELj9wQDmXitaI6ffQLYaOPqtHEEYe157JTUtmKEpbVPbmOPLpxD8fDEda9v
oh05Y5Kha6oSBKiRYIuqG/nEGTsdg52GSYUuMrqox92qifCl0biuh3V361ROESFO
SNlCwTxwTj4=
=qCMo
-----END PGP SIGNATURE-----

--=-UPaCblg4R4//oDt2xTFk--



--===============1124580858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1124580858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1124580858==--
