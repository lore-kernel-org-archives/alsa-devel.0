From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/27]: ASoC: rsnd: add Renesas Gen2
 DMAEngine support
Date: Tue, 28 Jan 2014 12:37:43 +0000
Message-ID: <20140128123743.GM11841@sirena.org.uk>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <20140127194902.GU11841@sirena.org.uk>
 <87zjmh7xtd.wl%kuninori.morimoto.gx@gmail.com>
 <52E75DD5.6040605@metafoo.de>
 <20140128113429.GK11841@sirena.org.uk>
 <52E79D45.5090301@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0767405293072899751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D45B264EFA
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 13:37:56 +0100 (CET)
In-Reply-To: <52E79D45.5090301@metafoo.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0767405293072899751==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YXgUkCSfyvNdAU1Z"
Content-Disposition: inline


--YXgUkCSfyvNdAU1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2014 at 01:06:29PM +0100, Lars-Peter Clausen wrote:

> The virt_dma helper functions already take care of some of the cyclic
> specific details. And more can probably be added. E.g. what comes to mind is
> the tracking of whether a descriptor is cyclic and which segment of the
> descriptor to submit next. All users of virt_dma already implement these in
> almost the same fashion. So this would not only to allow to factor out the
> handling for the cyclic case, but also for the non cyclic case. And for all
> users of those helpers cyclic support would essentially be free.

OK, I had a brief look and that does seem like the way forwards - I had
been remembering the last time this was discussed when the DMA guys were
pretty uncomfortable with the idea of doing things there but it seems
things are different now.

--YXgUkCSfyvNdAU1Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS56SUAAoJELSic+t+oim9DvoQAI9VsHmRpXL9SdiHdbwHQLZe
1YeinEGxwKnWakreBorFZ25CtzX75WKrVm8MYTmdSNyni7nZ08ldoYZcURZ+Mxwc
3Rqv7hjRE27naW25C94/pP3HYKIx+XDjQYTOyg+2Clc11/5Jti8JoB8MSPAwjfB9
5tX9jX0tVatqmHWt2kG40W/nty9KAUGQDQ371W/LHCg7AbVJQNLfNXqZETyW+UOL
hdvQYYJyRMqpoBkkfx08a53kkW2/JGNkILgciT1mSog5MYHbM5p7y6uKDzFQxYeI
ygOKSYyygjDaUAAQNvE7c8unRaRy0+/r3+V8UrOEOhmZaZ+u1cV4n4rBnSixhX1Y
Wt1UttXa/Q59iZi2mVYnQTjf5wMBx9RenHYYiT/M7SVET/SLFBa36QyGRw8BOmPt
IXUUtBlVbmrs04rGDAUnaz2Nn95odVftCU3rPPYpm0ISyy4Bp/Y3Y9TcchtriA4L
xNawULAyR3GabcMINaaTc81WDP58rQpLBi+3U6v5RKnYWFq91qYo7ydrS9rs5FRW
6HpCixyAVLBjBYzqkr5+QCD8cpx90RXiFemxVvSbTbq6fcR0PvDJsjeK4AjgXQM/
YDvvawsm2TAJyrQZnqBeesWvPCDvYATGFmt54b1w4A/frGWYQSXvhYonOlRIqMjW
xrnzJofWDLJE9vYO974H
=JhDj
-----END PGP SIGNATURE-----

--YXgUkCSfyvNdAU1Z--

--===============0767405293072899751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0767405293072899751==--
