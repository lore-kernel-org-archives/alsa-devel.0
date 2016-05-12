From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Thu, 12 May 2016 11:58:33 +0100
Message-ID: <20160512105833.GB6261@sirena.org.uk>
References: <20160502162715.GK6292@sirena.org.uk>
 <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk>
 <572C4AB6.9030106@nuvoton.com>
 <20160506181855.GZ6292@sirena.org.uk>
 <572FFCA7.8030604@nuvoton.com>
 <20160509163528.GD3458@sirena.org.uk>
 <573152EB.5090906@nuvoton.com>
 <20160511171506.GQ6261@sirena.org.uk>
 <5733FE8E.1040104@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6993141737840835762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F67C266A68
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 12:58:40 +0200 (CEST)
In-Reply-To: <5733FE8E.1040104@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6993141737840835762==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0B3PZ1+h5f4cFxHi"
Content-Disposition: inline


--0B3PZ1+h5f4cFxHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 11:54:54AM +0800, John Hsu wrote:
> On 5/12/2016 1:15 AM, Mark Brown wrote:

> > I'm afraid this still leaves me none the wiser, sorry.  If this
> > switching to the internal clock is essential to the device operation
> > then I'd expect it to be made transparent to callers so it should
> > happen transparently rather than appearing via set_sysclk().  If it's
> > not and it's just a performance optimisation then erroring out is
> > definitely excessive but if the optimisation can be implemented
> > transparently then it might be nice to do that.

> In the driver patch, the internal clock switching is transparently
> done by driver when the codec runs advanced jack detection. Our
> purpose is to prevent the machine turns on the internal clock by
> itself when no headset connected. That will not affect function
> work but make more power consumption. Maybe we can change to clock
> disabled quietly when the machine turns on the internal clock when
> no headset connected. Is it the right way?

Yes, that seems good.  Printing a warning is also fine because it does
increase power consumption but erroring out seems excessive.

--0B3PZ1+h5f4cFxHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNGHYAAoJECTWi3JdVIfQsQoH/1CYdoYW7O6/vmqC/TAZR5PG
uF3v7iXbiLwPpQYuBC7Yai3MagseSyFNdvTAm6hse5qPf0ZJgYtIYFd9264P24Fr
2m6u90MFMa4jGZgPcbehRCJ3JYOA/lu4Na/yFrFTSoUZNJx1g3UldmKF4uzoiw62
Phs0HjJMSJkRQ7QvRroCvnCNjeHjpo0BuVdoVK6Hh5KMzi6UpS7+pIBoQr5x+zsu
61zY4gvf4UazLqb8XAg/5gqnhYKRMZ72o9KEs3jRS0D3YFLhn1rUQ12A9N+bo8E4
stWNPHI1ma8iyYc6Qnb+ABqA8i5Uaj8blqV4mXDKXq+W5jdL9AMw0Txsq0ezqSY=
=3a4r
-----END PGP SIGNATURE-----

--0B3PZ1+h5f4cFxHi--

--===============6993141737840835762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6993141737840835762==--
