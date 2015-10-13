From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Tue, 13 Oct 2015 12:53:55 +0100
Message-ID: <20151013115355.GC14956@sirena.org.uk>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd> <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0354382379933705988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9AA2617C1
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 13:54:14 +0200 (CEST)
In-Reply-To: <20151012201137.GA7317@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============0354382379933705988==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 10:11:38PM +0200, Pavel Machek wrote:
> On Mon 2015-10-12 16:47:15, Mark Brown wrote:
> > On Mon, Oct 12, 2015 at 11:00:45AM +0200, Pavel Machek wrote:

> > >  static const struct regulator_desc arizona_ldo1_hc = {
> > > -	.name = "LDO1",

> > No, you definitely shouldn't be doing this - the regulator names should
> > reflect the names the device has in the datasheet to aid people in going
> > from software to the hardware and back again.  They shouldn't be
> > dynamically generated at runtime.  If you need to namespace by
> device

> They already are, see wm831x-ldo.c .

No, that's a different case where we actually have a repeatable IP we
can enumerate multiple instances of on a single piece of silicon which
has multiple variants available.  This is a single device with a single
regulator on it.

> > provide an interface which explicitly namespaces by device rather than
> > hacking it into another interface, the usual thing is to use the struct
> > device as the context.

> I'll need some more help here. I need to use it from ALSA, so I don't
> think I can influence that interface easily.

Sorry?  If this is going into the userspace ABI there's something
seriously wrong...

> What is currently in tree _does not work_, as there are two arizona
> chips, and two "LDO1" regulators. (Doable) suggestions how to fix that
> are welcome.

To repeat what I said above, provide an interface which namespaces by
device (as we normally do when we need to distinguish between multiple
instances of the same device).  Given that everything is part of the
same device it's very easy to discover which device so it's clearly no
problem when mapping the supplies.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHPDSAAoJECTWi3JdVIfQoLoH/A9QmE1iT2cyOCSvF1IIp5J3
jFNJZU0g5f4rPGGs6MurFZ4q/NBqx/tycfDEcfHOQ8j5zzmYtc8fxD/APwqpINHm
EaDfYiY6nvl+iJDITe46rgil238+GNYgun/3wfx8wGBOApmbVDSxRYgQYld8fDw0
tgnWZx+Z00R0nEziTOOW3qIXONaJ+JPz9QaGX75Yvh6uFlQOUHtrjvs2F9js37uu
i9cqYRjBjdI54kcv5Kd6iSFFj8poxmfCH9vUzmC/rJu0/7uFq0AFvESdFYhKvP/o
9b2nUIQcq8hyXiWESRdApcEJ/cC+l7X7AwW6AR4UxaagkMpXJ6zI6NuAagUXS2A=
=c20d
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

--===============0354382379933705988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0354382379933705988==--
