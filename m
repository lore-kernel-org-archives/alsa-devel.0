From: Mark Brown <broonie@kernel.org>
Subject: Re: dsp after dmix
Date: Mon, 14 Oct 2013 21:33:09 +0100
Message-ID: <20131014203309.GR2443@sirena.org.uk>
References: <CAOf5uwmrS1AZrmKfbUYokU1Azdd2dZv2=Z=fGp+UQyy_mW1ijQ@mail.gmail.com>
 <525B985A.30409@ladisch.de>
 <CAOf5uwnFtN4mDqgfLThRXGUcHQpFJ6wkFFoZhBJdWc6FaBPapg@mail.gmail.com>
 <525BE047.9000501@ladisch.de>
 <CAOf5uwne9V3FgB_3rhTDr0Z08wJYKGAP8M1pR0VYhXxZ4rio-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4270268038861372074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CB20326163C
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 22:33:33 +0200 (CEST)
In-Reply-To: <CAOf5uwne9V3FgB_3rhTDr0Z08wJYKGAP8M1pR0VYhXxZ4rio-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============4270268038861372074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I30T0A8abtL/6dyk"
Content-Disposition: inline


--I30T0A8abtL/6dyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2013 at 02:18:27PM +0200, Michael Trimarchi wrote:

> > You would have to write an ALSA kernel driver for the DSP device.

> This is not a good approach of the general problem because a lot of
> dsp has userspace
> support and firmware and initialization is done by userspace library.
> Can I change
> the writei and readi of the dmix plugin and let use my dsp function?

I'm not sure that's generally common - memory to memory DSPs are a bit
unusual for audio since the latency requirements tend to be fairly
tight.  I can't think of many examples that don't need some exposure to
the kernel...

--I30T0A8abtL/6dyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXFUCAAoJELSic+t+oim95yAP/RkOSzWcTXG0qdEVtx2Th2Ak
EKQ9AgswIjNWKsGp+VDcO4duUwf1UxSZalGZiZ2ym8XUVFN0ux5UTGaIPTRvUhZb
/T3bNoFvZHiJ4NkPhWCWSmihfd6gpKKLV3oQgr78VadWVu21/1ZcWu/Om13M795i
hFZbrEHkye1901XAQylDurf9W2evZgmx0GmdxYrMWkuepI1UCl3n0J4gNBa+u85s
GnEJ2i61K8DaY9HDY5f2WtvuALuznSnjVvc33qz0cv9fxnXxyhmcrP6TnA67u/gg
chhe++8XKb5llRBa9qySWBaWaRfos6XlN75OaafH8S4Rj86D+pyBS/yEHr5iKAwH
yDh0Kc/INnR0PV86/Iv6ibq0N4lj3Jp06mPFp2S6Wxj3+vGkgKBYGzrdz+CTIEkS
b3oTfqLNB3edPW53KaB/1kQszUGF6cXQr0tOaGz2cLAb52QkT3jAsvQ3HbPvyErV
/cULgcE6SH1wyUOogUR1oKqTNeyEDt7hnhKEyXdJX+VoYipx6hzU2D6eka/6aXub
7mCZZnQxeg6topW314Kap8Tbfmpi/6SPoDJcLaBUgey2s3dMGirq7S7mcCUeEBe/
aQvdQq16YOcVBYBOhEQl96XOWhTRfEjPWBpCsgDoJ6PwJ3kdFFRbLx2jznrXJ48h
miXOXvsD38JuABD8OjQv
=RwuU
-----END PGP SIGNATURE-----

--I30T0A8abtL/6dyk--

--===============4270268038861372074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4270268038861372074==--
