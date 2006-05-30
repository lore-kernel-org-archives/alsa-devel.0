From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 5/7] snd-aoa: add layout-id fabric
Date: Tue, 30 May 2006 14:37:55 +0200
Message-ID: <1148992675.3102.2.camel@johannes>
References: <20060528190026.754474000@johannes.berg>
	<20060528190129.503400000@johannes.berg> <s5h64jp9ge4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0243733340=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD45E14F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 14:38:07 +0200 (MEST)
In-Reply-To: <s5h64jp9ge4.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0243733340==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8WXs2ordTxhsmS7HleAU"


--=-8WXs2ordTxhsmS7HleAU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-29 at 14:14 +0200, Takashi Iwai wrote:

> Just from curiosity:  Does this work properly?
> I remember that there was a deadlock when you call request_module()
> during module probe.

Yes, it works, but I don't think this is actually done during module
probe (would have to check though)

johannes

--=-8WXs2ordTxhsmS7HleAU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHw8oKVg1VMiehFYAQIAZxAAxYEeGPjqDPEVb80eF/qjcv6mUrpPdQAy
27QIxHTarXSDOiSQ62TCrIBClosaxS7tBnPKL/Fo6XX6UjCjSY2Eks+JkFnvsb5X
JuzoxXb59KykKDfse8GRVqUQM4NYrCd0fLqcMWgk2o8gkChpfxtBnuak5LKDLMXp
ojiOBURYksY6h1odWQOBi+AzaocWKa3Xq0jzBpQL3/MbySe8ah6xKrH8fGV7V2Ee
e3fouWVo6hNLCcGZVJCCbZ1pMwwUYYWeiZzjWB925+S8naoVnqZ6XS+14MuzTbgJ
f8NGynhRrhi/UY9PI/TJJjmhukEMrfOujTLSbsHG4NabHAb1OjEjuXvqD1N4JvfB
9LlbbqzJPJUbeKOi9X2XkBL9o9Hd3rYjBTrQ91OqBnKSWpn/nRS7gAeEgr6bL5pI
H8Gbdy4vQqZlK7FIV0kVR9QW8avnkj7Q4mmLy+f/4Zf4hXmDXrOorz07ymouybcR
FCABsqgIEVMqYj5JdqBoIzoSUWQW0l8gRXAP691kjKFaME9SnhMMt3iLJkIstbMs
8Z96gRy+Wkpur2R1go5Eg3rBRkHRJ/XSkchqNm9G2iy5QIPwDmrM4n8sz0ZM7Ho3
G2CfzeFgUtLBgHQ0cC+el4B/ircucDdZShaFZGdRFS2xULRIhMqb/JmaHd7K5Wf4
pPl7VTBS8Rc=
=XWrP
-----END PGP SIGNATURE-----

--=-8WXs2ordTxhsmS7HleAU--



--===============0243733340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0243733340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0243733340==--
