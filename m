From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: allow changing the
 playback/capture rates for symmetric links
Date: Thu, 28 Apr 2016 11:38:22 +0100
Message-ID: <20160428103822.GJ3217@sirena.org.uk>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
 <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6420363386805044750=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 08085265043
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 12:38:38 +0200 (CEST)
In-Reply-To: <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6420363386805044750==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hQZD+IfmO+MFVaX7"
Content-Disposition: inline


--hQZD+IfmO+MFVaX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2016 at 10:45:48PM +0200, Peter Rosin wrote:
> On 2016-04-27 18:15, Mark Brown wrote:

> > You've not articulated the problem you're trying to fix here, what in
> > concrete terms is the program trying to accomplish and why should it
> > succeed?

> It is opening an OSS fd, and setting some parameters, but changing
> the speed fails (in this case, since the codec dai has .symmetric_rates).
> As far as I know this is how you specify a specific speed when using
> OSS and it is simply not possibly when one of the involved dais is
> symmetric in any way. Which is silly since there is only one stream,
> so symmetry should not be an issue.

Lots of things just don't work with OSS, we stopped caring about it
years ago.  The configuration mechanism just doesn't play nicely with
dynamic constraints at all.

> >>     if ((fd = open("/dev/dsp", O_WRONLY, 0)) == -1) {
> >>             perror("open");
> >>             return 1;
> >>     }

> > This is using the OSS interfaces which really haven't ever been
> > especially supported for ASoC.

> Apparently, how should I know?

OSS in general had been deprecated for 5-10 years.

> I haven't looked really closely at the userspace side of this, but the
> big picture is that we're using a (closed source) library that in its
> documentation has an example where they open /dev/dsp like this and
> feeds the fd to the lib. We are simply replicating that in our code.
> I don't know if the library does anything OSSy with the fd, or if it
> would be equally happy with an ALSA fd.

If it's using OSS it's unlikely to work with ALSA, the two ABIs are
completely different.  You need to talk to your proprietary software
vendor about updating their software.  There are also some userspace
utilities that try to do the remapping by wrapping things there but I
can't remember the names off the top of my head, it's been a long time.

--hQZD+IfmO+MFVaX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIegdAAoJECTWi3JdVIfQVkYH/RegIvmnjSK301pvZzNev4Nl
UVvmdMYkJ32tdidkVCw0Ghl1EbNPiNs6eS8VqQs0/6sZ2A4G8AJaFBGvqsETiXAH
eQZBkJjz4pnJRJIB03G5rKK53loCurKPreb0CWk3170rTCd4Ulid1KX91KbEoHnt
QwK9oJasVK4exKgOdKVdu90SD/YeyEVyBiSr/HLZfp+HItGaeqRQxm4wJwJWcu0Y
AKtOma8BY1w0onlm+vykWgGqzFYWrRmbiorc1bwAtURQ7lP7AFrO4d3kRR6sspnI
qu4RziawnOl2eto73tXYN8ExFeKM2xPh1b5Y3AhOhyHWvFzObeeCvlm7rLnRZow=
=QnlW
-----END PGP SIGNATURE-----

--hQZD+IfmO+MFVaX7--

--===============6420363386805044750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6420363386805044750==--
