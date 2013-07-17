From: Mark Brown <broonie@kernel.org>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Wed, 17 Jul 2013 10:31:32 +0100
Message-ID: <20130717093132.GD22506@sirena.org.uk>
References: <51E55925.5080208@gmail.com> <20130716162043.GS22506@sirena.org.uk>
 <51E575E3.3040409@gmail.com> <20130716165708.GT22506@sirena.org.uk>
 <51E57DD5.5040307@gmail.com> <20130716174703.GW22506@sirena.org.uk>
 <51E660E6.4010902@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8335443088944432630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AD7226511C
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 11:31:35 +0200 (CEST)
In-Reply-To: <51E660E6.4010902@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8335443088944432630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gIORF5nGxIt+AP0s"
Content-Disposition: inline


--gIORF5nGxIt+AP0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2013 at 11:16:22AM +0200, Daniel Mack wrote:
> On 16.07.2013 19:47, Mark Brown wrote:

> > Half the point of soc-pcm is to decouple the streams seen by the
> > application layer from the DAIs that the driver sees so I'd expect us to
> > be able to map a single application layer/memory stream onto multiple
> > CODEC DAIs.  One front end connected to two back ends.

> You're talking about DPCM, right? Unfortunately, there is no active user
> of this in mainline, and no documentation either. I'll try and find out
> how this is supposed to work first ...

Yes, this is a constant complaint.  Hopefully the OMAP4 code will be
upstreamed at some point but as you will be aware there's issues there.

> Maybe Liam has some explanation ready?

The only thing I'm aware of is the out of tree OMAP4 and Qualcomm code
neither of which I'd hold my breath over.

> > May as well bite the bullet and do the refactoring, it should be
> > automatable.  There's also the fun of handling what happens when you
> > want to stream from one CODEC to another but I think that's second
> > stage...

> Looking deeper into this, I'm not sure whether each of those codec
> instances inside one snd_soc_dai_link should have it own runtime, of if
> they should rather share one. The latter isn't straight-forward, as
> current users simply access the codec from their callbacks as
> rtd->codec_dai. However, open-coding routines to access the correct
> codec from these callbacks is not nice at all either. Hmm.

Yes, it's not an easy refactoring.  But it's probably one that'll be
needed for Slimbus at some point.

--gIORF5nGxIt+AP0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5mRxAAoJELSic+t+oim9VLgP/RsZ6Fp3Jz8zV0YYtaZqjH2j
cUtzNT4VSILrEIw2LHOzSEPVRoLnrc/aWIwq/GJARR4MLB36/pysKbNWqcfPzSRP
oULgVmgsUq7SYWdcoJyYYKgBTT/DHhxODqDxQtHm5TI3T0TV6Z5ZhB0qoZNz/sU8
YI5OYJil70BAcCtoLBss21YYZhdYSgMGjr0PVqtClCAhx/1qBJtsukt2PmNkSDu8
1AemB8glklFzutqiMV/n9+LC+1gQKhX4DOqxPVbwQGQXR16sm0jPF/i10q3dVpzi
VwKrQu3GUYuDHVEbPA1yrzhv9EEPd6QDOcAQO2n0oewsjyySuZ39qdyXpbHNdxNV
Ic8nowPR5KhLGy22ZJoLf0GAdJMPEfQn5xK1sTkXkwUHIic/P/5qGAYzhhvVBjOb
+Euu0TTczkXSH67M7EENPXUsyhplgqcWwFOWnbLa2zpLctJwNAFL/0EElbFkqMUZ
gmkea6CDavliAOgsO6Wa0vwDtsnO4SGDjgWQy+y25yUvNutiZueAWCjdvLDaHQpw
tlH7EPlb/W3TT5XMT3Ve64xaeE8xUzXnpnWAsG4YbmYiLyMdC2stRf1+E08qWnP+
fAuU2gUkfqMAyBXxhaRKKExL+MKPTLLyIoN1cIOENlSHPRKVC07oOkVAmxiUadMQ
1Vz2snkBg6hjasJS4POH
=1gM3
-----END PGP SIGNATURE-----

--gIORF5nGxIt+AP0s--

--===============8335443088944432630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8335443088944432630==--
