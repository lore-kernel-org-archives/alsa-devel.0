From: Mark Brown <broonie@kernel.org>
Subject: Re: Disable DAPM for click avoidance ?
Date: Tue, 27 Mar 2018 20:01:01 +0800
Message-ID: <20180327120101.GG29239@sirena.org.uk>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1803191641250.14045@lnxricardw1.se.axis.com>
 <20180321023432.GV2186@sirena.org.uk>
 <alpine.DEB.2.11.1803231708350.14045@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4281325430654969465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 34CE4267140
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 14:01:17 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1803231708350.14045@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4281325430654969465==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 05:23:23PM +0100, Ricard Wanderlof wrote:

> Yes, there is a bit for setting the output amplifier in power save mode,=
=20
> which is handled as a PM bit in the driver. The specs aren't that bad, th=
e=20
> worst case SNR is 80 dB, with 97 dB typical. The good thing about using=
=20
> this bit is that when the output amplifier is in power save mode, there i=
s=20
> actually a high impedance connection to VMID, so that as long as the=20
> device is powered on properly, the outputs take a while to reach VMID=20
> depending on the value of the DC blocking cap on the output, and the slow=
=20
> ramp also avoids clicks when powering on the device (and we don't start a=
n=20
> output stream until quite a while after powering on the system).

That feature sounds normal for such old devices, you should be using
that rather than ramping VMID from ground every time you want to start
and stop playback.  There's a number of very old drivers doing something
similar, grepping around will probably show something.

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6MnwACgkQJNaLcl1U
h9D5lwf+OcDQ0mHy1yONoXYWQ1Dsu2QnXsa/2S/3YHJ7k0TfrhGZO6DAVlrthtnx
tb4nNciPUgoc6hCI/rgwG2DXD/UQqAngTOpfQ+sP1LSdehhSK7hdD7jLhJ4wAyMb
IC54qR+CbFrPrGie42EAhxAxfeu/AHVyAcvbIqosnn91AEi2EtSJc8kzP0Tu00QU
VifEGWaXpjhlt009t7FWO7N+/jbQXdxpPGqpPHGQkzq7ga8Be8B7/vM3ICES0Lkn
9eBZpNVsYJxCWkbTOWYxW864bCV3/oCKrQKDnk4WnWjrKRl6y+rnBeuobryoC+7/
WMbLZrZ5pKMwy9fYhU06V9JhXKgTsA==
=s/MR
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--

--===============4281325430654969465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4281325430654969465==--
