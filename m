From: Simon McVittie <smcv@debian.org>
Subject: Re: [PATCH 2/2] configure.in: don't rely on test -a,
 not all shells support it
Date: Fri, 8 Oct 2010 09:31:53 +0100
Message-ID: <20101008083153.GA30622@reptile.pseudorandom.co.uk>
References: <20101008080658.GA11099@reptile.pseudorandom.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8258244156556823875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from figment.pseudorandom.co.uk (figment.pseudorandom.co.uk
	[195.10.223.171])
	by alsa0.perex.cz (Postfix) with ESMTP id D7D66245B5
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 10:31:54 +0200 (CEST)
In-Reply-To: <20101008080658.GA11099@reptile.pseudorandom.co.uk>
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


--===============8258244156556823875==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, 08 Oct 2010 at 09:06:58 +0100, Simon McVittie wrote:
> Notably, /bin/sh in Debian and Ubuntu is dash, which doesn't.

Sorry, I'd misinterpreted the error produced when grep fails (fixed by patch
1/2). Recent dash versions do support test -a, so patch 2/2 turns out to be
unnecessary on current Debian, although it might conceivably be useful for
backports to older Ubuntu versions.

    S

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQIVAwUBTK7W+U3o/ypjx8yQAQg7Sw/9HQ7ZUyM/Jq5vbwUxYgmFPzxoEkBzoLws
+ZzHyYKRULb4T0UoaMJ9ZrveVAs4JGvNFPoKgXax5VpAUFeVdkwm6QYMTu30IyJN
SPZ2oHjKyg8YZKdjFWGrzslqF7IysmeBekKdoxE2DBudt6cy6/pY7AS73Xkz6Isu
p/kyDJlgKzyi5+VH/NxqwU65rIbJIFFEzz4g1beh3x/DQjyYXHN15pgzm1pT9p3w
/6mS8UYU/UT/V3g9m6hWc5ze0YoosN6mmCVqeIgUXUTsNF72lRApYxA1w02eZRqE
iD3OZW/7GXpJcyaMH1O6nFI6PRIZsbrwEv78YEaaVle9Ne9ty6B8bC/LKeolypih
iNcp66qdUoDBdDK8l5xwTqG3/qq1xWWlxeDRVSqKi9Uj63detBWubKA7UI0EvCxX
9BWSeiAnzWSQdlDgC8EndsRQePjOIvKhqQoYafm1cRR7Rpb+Zwr0jw09yBuAMF8L
AHXCbFUR2SQskA8mmb5BhmAykoH2LJYYP+MUyby+E3EiF1PTv4auA/Uz7cGkyaTY
6THGm9yK6UIjttTRI17YuIqMFb3aWSIJU1lpc8D7PwEnAzWT0X9v87vIMBE2u34m
u2jYkCYDVGpCB5aKNKISeO19it/Cfz2FSLTK2PuKPUqhUCVzn6Wi2SXJAb4jRKpR
Ok5tneKB4AM=
=cwkC
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============8258244156556823875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8258244156556823875==--
