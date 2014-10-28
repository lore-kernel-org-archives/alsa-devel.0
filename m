From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: kirkwood: get rid of
	armada-370-db driver
Date: Tue, 28 Oct 2014 23:07:40 +0000
Message-ID: <20141028230740.GQ18557@sirena.org.uk>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141028223521.GL18557@sirena.org.uk>
 <20141028235456.7d68d53e@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6499433932091014376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71AF5260454
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 00:08:07 +0100 (CET)
In-Reply-To: <20141028235456.7d68d53e@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6499433932091014376==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ubEh+iSFTuEFLNSo"
Content-Disposition: inline


--ubEh+iSFTuEFLNSo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 11:54:56PM +0100, Thomas Petazzoni wrote:
> On Tue, 28 Oct 2014 22:35:21 +0000, Mark Brown wrote:

> > This is just removing support for the old binding which is
> > incompatible...

> Hum, I'm not sure to follow you here. In a subsequent patch, I change
> the Armada 370 DB audio complex DT description to use the
> simple-audio-card DT binding, which makes the Armada 370 DB audio
> machine driver irrelevant.

> Of course, this means that if someone uses an old Armada 370 DB Device
> Tree with a new kernel, it will no longer. But I believe this is kind

Yes, this is the entire point of device tree as an ABI.  We also need to
care about out of tree users.

> of expected for this specific case: when we originally introduced the
> Armada 370 DB audio support, we knew a proper DT binding to describe
> sound complex was arriving, and therefore the Armada 370 DB audio
> machine driver was only a temporary solution until the pure DT solution
> was available.

No, that's not the case - these drivers predate DT IIRC and while it's
good to avoid adding new drivers there's nothing inherently bad about
having a machine driver or adaption layer into simple card (you could do
this just as platform data for simple card for many devices).

In this particular case I'm especially worried since we've got the whole
thing with not having a good story for supporting simulataneous use of
the S/PDIF and I2S links worked out yet on the controller side and on
the simple-card side it's pretty much just the most basic CPUs that are
supported.

> Therefore, with the agreement of the mvebu maintainers, I'd like to be
> allowed to break the DT backward compatibility here, and get rid of
> this audio machine driver which would otherwise have no users left.

...in mainline.  Doesn't this hardware tend to have lots of small
variants on the design floating around?

--ubEh+iSFTuEFLNSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUCG8AAoJECTWi3JdVIfQ7y4H/An0ORHdengppR2OpH3m1J/t
qV2XHBYbZgNH0MnyywBYJ/ggqdVQ9A+Zb6Ys/Md4iDb6mQT1kLK/O5XXm8oDUs33
rBYeSKRIo1TBgiCWzS0BUhoG5bofskq6xpVO7DE8oOfxu6kN26HQYHBQW/bSdYOj
SZiUTKmP3GEB7XP4bpbgNDf12L+FYIYLBks/EAVo+18tp56E1q3HbrqxlZSys5rC
ZkPicXWbtnohC+W7Odw3h82fcKmEbMHONS+97adN0F/QKmBvUf6NebDJVAKPJkDg
Ojd+MjDd38ynpQrdbUGDJUQXR6L6khRFmNbaIXVIxmL1kn/tlLlNdCKy2fIPHhY=
=Vukc
-----END PGP SIGNATURE-----

--ubEh+iSFTuEFLNSo--

--===============6499433932091014376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6499433932091014376==--
