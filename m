From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5668: add rt5668 codec driver
Date: Mon, 20 Jun 2016 17:21:30 +0100
Message-ID: <20160620162130.GZ26099@sirena.org.uk>
References: <1462791463-19264-1-git-send-email-john.lin@realtek.com>
 <20160513123641.GO22038@sirena.org.uk>
 <4CB77D0D55A17944BE73853962D000A56C3C7C@RTITMBSV07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4191773676813993512=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA70A2665AC
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 18:21:37 +0200 (CEST)
In-Reply-To: <4CB77D0D55A17944BE73853962D000A56C3C7C@RTITMBSV07.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jack Yu <jack.yu@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4191773676813993512==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f8lmXUvqnCdFQPaI"
Content-Disposition: inline


--f8lmXUvqnCdFQPaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2016 at 11:31:07AM +0000, Jack Yu wrote:

> [Mark] Given that the interrupt handler just schedules a work item there'=
s no
> need for it to be a threaded interrupt, it can just be a normal
> interrupt and save the bother of masking the hardware interrupt and
> running a thread.

> Do you mean that it's not appropriate to use " queue_delayed_work" here, =
we should=20
> use other method for handling work item ?=20

No, when I said it shouldn't be a threaded interrupt I meant that using
request_threaded_irq() doesn't seem appropriate.

--f8lmXUvqnCdFQPaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaBgJAAoJECTWi3JdVIfQTrAH/ir5oBaAftlUephL4HPuv84t
66dq2Z0grYh0f170hXjDdDF05uPl/QvibezV45XqpsAB6xDYJaymoJYKXGhGidTA
caP25uAHvR6+UuJgbsCxd/abi2lqvdVk2+JHyzkM/U2cQL9BwkufgwZHR53v8CZu
2lmwXdpZo0r5IoKbmSxJLCDNuT2AfPS1E3QWtduXf2kZrUCisGIDS6wYa80dcZjH
xbtvc7H86lJtkkbr8n1mvkvq8SgUaUuflYTFRohA8pNSXDZFiJfI3PBlY1BZzuAm
TTfAJQTE/Z2b0eaG7ulx+uOUk/m21UMF99KnRlPGp4FsBRioChB9Co8NCvAKAnw=
=g54o
-----END PGP SIGNATURE-----

--f8lmXUvqnCdFQPaI--

--===============4191773676813993512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4191773676813993512==--
