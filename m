From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Tue, 16 May 2006 16:55:15 +0200
Message-ID: <1147791315.983.21.camel__37318.0813774981$1147792300$gmane$org@johannes>
References: <1147780945.29795.110.camel@johannes>
	 <1147791186.13948.109.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ouoR/w+Ko5EVP3wp6JwD"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 95A28102
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 16:56:23 +0200 (MEST)
In-Reply-To: <1147791186.13948.109.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--=-ouoR/w+Ko5EVP3wp6JwD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-16 at 10:53 -0400, Lee Revell wrote:

> Ummm... what problem is this patch fixing?

The problems that
(a) kmix, gnome-alsamixer, gnome-volume-control and others can't
    properly use the playback volume control because it has a range
    that doesn't start at 0
and
(b) alsamixer can't properly control the capture volume control for
    apparently the same reason

johannes

--=-ouoR/w+Ko5EVP3wp6JwD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGnn0KVg1VMiehFYAQKRqQ/+IaFDH4aceQti8Y+Cz/4KgEx/LF/kbTq0
TBoCbo5uVMVuGKwzjAgPPnUtneek1SMT8scPKIQjiMyqcj9AXoofBPLwFhIpnDqJ
eiEiJsJorqlJUDSaCGtlCo+Jg5yTWoU8KQlomE3YgpxOcgEOzETRcggIFkToPlf0
jI5vSaFsMFcEZEzofe5dGwOQBFVlg4sJ4crbFg663q4PWJwrxmshueyBc84bI4d7
CqTyRpoX1fjCspfkKjX4eft/pvG+xgNqygQ4RuvjCE0DThI8aIrTRvv/nFuHIpJQ
F5mXEI9DL1YWXZ6bNuXSbdh3RW/AnESB5CdLk7bN/FOvBl3WFYfbhqDk4rXFTvVc
V1am7t1VFfzj0onZJyVM4NatS/ZMAsW3ZUA1r9jK80NwAIgufmJFVHCTTxMJd1om
W3LF2w2eXrDoudC+sgRIVEPkvOBvshWkPtc9BacdslYw6wSJGgPRWC5Hs8Eoa0Lo
OryBaA3U9NOCQNnIyr/rYKlPqCR1oa64JMFt+zN2hOvNwzFRPBYKcq1Qt7Q47Yc4
KbF0EvOJ9fh0yTR/675G7LVoCBqbZohMEZJ794xJnhRMfbaEm7iAx9SQ6Vo0QbCe
3Oab6C8VWpO3e28GK1MFV02QBHPgzA4zywYQZXNoQ5sweC+hmyBupYU7XVdJ2pyK
x6m+tWhMI6w=
=QplL
-----END PGP SIGNATURE-----

--=-ouoR/w+Ko5EVP3wp6JwD--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
