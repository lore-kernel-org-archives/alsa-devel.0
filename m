From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 17:34:15 +0100
Message-ID: <20120821163414.GV7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <5033A0AD.2010403@canonical.com>
 <20120821150720.GS7995@opensource.wolfsonmicro.com>
 <5033AB74.8050201@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2065097264712835937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D45CB265FC8
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 18:34:15 +0200 (CEST)
In-Reply-To: <5033AB74.8050201@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============2065097264712835937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9o1Xi4ZMQ45MudWG"
Content-Disposition: inline


--9o1Xi4ZMQ45MudWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 05:38:28PM +0200, David Henningsson wrote:
> On 08/21/2012 05:07 PM, Mark Brown wrote:

> >Which of course is also replicated with the calls into the original
> >jack API.

> Actually, the phantom jacks are only in the ctljack API. I
> deliberately left them out of the old jack API, because it was
> deprecated (or at least so I thought).

Like I say it seems like the wrong way round to do things - we've got a
reasonable set of drivers using the jack API and a single driver using
the ctljack API, with the ctljack API being very much a subset of the
jack API (in that it only supports disconnected boolean values).  I
still don't understand why it was ever implemented as a separate API.

--9o1Xi4ZMQ45MudWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM7h/AAoJEFJkBDiqVpZ4vmcP/0cmNh7SmFuQTKfRYfShXKNF
XLs7O5IAfnCho7CKKvpXOFpA4SOoAAk+DE3AJCG0HykWvYoHHEkRU/j6oBma4bSv
b3OHhKgzG4h1WokM4st/NnwwB6SMpu/KDUUKtOgXLqW+LtIcz2oEtBDis7d92p+M
EiFVqTnw1zxI0CyJ1pCcWz7O54Grts9CM5Tw2cH363JcMjy1Mm88YvG6i3RtOYtR
gspm/BkLxh5Wcd+/Q56MLllZ87k++a5Baz/BMDjG8TjswcgYCseJ2MwiJNQDwar7
G1tCyCteaktuvn6fFBxlYyT/OFQ31+ud1OCecJNFE6ma2ZfnzR5qm9ErpNgyNETc
y7Pk1g25mgp1WGL0FktoHqmPs3s1jO+0mkPlOXYIE0oO6AjrNuLQpxzmtvl8lIU7
hJwxeZyacMxUgh2NzIamitNnnvHV6kKshHs/iDFCvU5LYQGvFGFZhX7JEJydREY/
qP39ahEQzMNf8j864Q3ds8VZMT+qzlC65vysHShfWSX1/eQu9N8LOia6qwIUUOl2
OGNuhOXXQQOJ8I+hsF+W52BYXIvNJrOZI7C/l7SCfj/1ZanxFcP52SJXOeyV8I1o
ZYjxL2Q2KINN5HTNIA00+MqJCqXbGbWuT5X7Owma/wm4zonBIi3eEwhWx2fn0tV6
Bn4fLCHdOBEuiwQ3eTmj
=aQX9
-----END PGP SIGNATURE-----

--9o1Xi4ZMQ45MudWG--

--===============2065097264712835937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2065097264712835937==--
