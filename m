From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/12] ASoC: dapm: Only mark paths dirty
 when the connection status changed
Date: Wed, 22 Oct 2014 16:29:35 +0100
Message-ID: <20141022152935.GY2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-4-git-send-email-lars@metafoo.de>
 <20141022110012.GQ2344@sirena.org.uk> <54479EB5.2060102@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6610836497999267778=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AD922651EE
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 17:29:51 +0200 (CEST)
In-Reply-To: <54479EB5.2060102@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6610836497999267778==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXo2lOxbfudqq8ta"
Content-Disposition: inline


--AXo2lOxbfudqq8ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2014 at 02:10:29PM +0200, Lars-Peter Clausen wrote:
> On 10/22/2014 01:00 PM, Mark Brown wrote:

> >Why is this returning a value which is then ignored?

> I was initially using it to not schedule the dapm_power_widgets(), but th=
ere
> is potential for problems when the DAPM graph and the hardware state are
> out-of-sync, in which case we still want to apply the register update. Th=
ere
> are some corner cases where this can happen and which need to be fixed
> first.

> I can drop the return type for now.

Probably best, I was looking for a user and didn't find one.  Seems like
a bit of a microoptimisation either way.

If it was just returning an error code and we were ignoring that I'd not
have worried! =20

--AXo2lOxbfudqq8ta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR81aAAoJECTWi3JdVIfQB48H/36oot/6fCg5AauI/OlVCw29
uHaHrkqBhiuyOZ11GSHN2hNQbNENR9D+QUzY27M97cp5uUN8Wx1OaXVl1F2tDPkX
vF/5lCGwq6jJ3ezXKLw8Z33sFvayz3yFAIlW/lNgBrfnOyffy/iuYlSfNi4f9gb8
4sEnyEK/M1jhWBWUSOUNh7s17NKzaq6cXhFaXpagy2JtViBMKCNTPUPcozSWW7yo
PIwzmLOZA+LKt+5Nb5AqZCsdYz9ruLbxzX6RX9p4j7kBFoOo01/5EdshIqv+Dpwd
DH0oCK7Ds1lqJU0Aw41W2vClPQ+mIQMh7lallk8erb6uq7T0OyP0RMb7w+BIJTw=
=3JFj
-----END PGP SIGNATURE-----

--AXo2lOxbfudqq8ta--

--===============6610836497999267778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6610836497999267778==--
