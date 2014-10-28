From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: always cancel any pending
 delayed stream shutdown
Date: Tue, 28 Oct 2014 15:14:29 +0000
Message-ID: <20141028151429.GW18557@sirena.org.uk>
References: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
 <20141022162802.GB2344@sirena.org.uk>
 <52F917CEA1B9C64C94833D53889D478C044B9B@dor-sms-xch01.digi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6960680880353254601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F19D7260320
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 16:14:54 +0100 (CET)
In-Reply-To: <52F917CEA1B9C64C94833D53889D478C044B9B@dor-sms-xch01.digi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Palacios, Hector" <Hector.Palacios@digi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6960680880353254601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYrjhH26xX5Rz9aF"
Content-Disposition: inline


--oYrjhH26xX5Rz9aF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2014 at 05:25:11PM +0000, Palacios, Hector wrote:

Fix your mailer to word wrap within paragraphs.

> On Wed, 22 Oct 2014 18:28, Mark Brown wrote:
> > On Wed, Oct 22, 2014 at 04:14:53PM +0200, Hector Palacios wrote:
> >> After playback a shutdown is scheduled to happen within 5 seconds.
> >> If another playback takes place before the scheduled work times out,=
=20
> >> the work is cancelled, but if a recording takes place, the work will=
=20
> >> shutdown in the middle of the recording, causing problems.

> > You're not saying what the problems are, just that they might be caused.

> Sorry, your right. When I do a recording 2 seconds after a previous
> playback, and later play the recorded sound I hear 3 seconds of
> correct audio and then I continue to hear good audio but mixed with
> noise and at a higher volume, as if the codec had reseted certain
> parameters to some default values.

That definitely sounds like a driver bug.

> > Starting or stopping a playback should have no impact on a running=20
> > capture stream, users could always start and stop streams manually=20
> > anyway.  It sounds like you're working around some problem in drivers.

> I see. I tested this with Freescale SGTL5000 on an i.MX6 platform. The
> shutdown of the playback is eventually calling the set_bias_level()
> hook of the codec to SND_SOC_BIAS_PREPARE and then again to
> SND_SOC_BIAS_STANDBY which may eventually turn off the regulators.
> Anyway the problem doesn't seem to be on this codec hook because I set
> it to NULL and the problem was reproducible. I thought it was the
> dapm->bias_level being set to STANDBY on snd_soc_dapm_set_bias_level()
> in the middle of the capture that did something to the workflow of the
> capture stream, but I'm no expert on the architecture of the sound
> layer and didn't see any other call to the codec functions that could
> be causing the issue.=20

Check for any interactions with the CODEC register map, and make sure
that you're using the latest version of the driver since it's had quite
a few problems.  If it is something interacting with the device you
should be able to see it if you log all interactions with the device.

--oYrjhH26xX5Rz9aF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT7LVAAoJECTWi3JdVIfQndsH/iMJ7VyuQJoJdn1bME2k51PT
ya54vOBDKi0IkFgGCWePwyiXpnbPzi/O/Y/BOI6wcPSk1Lq/NNSEjN2wNxRKgGfy
Vl9Z5mDbYLc9L00p/kB6ZKtyLG+2JKxoz0kE32aPO3Wnv0GNM214H+QBshnknFoe
gFIiPm3KYofioCkSxhsvdbTuJDf+7PSOoYYYwgDofDgjfiZH7fh2MjzgZn7yKmN9
KcdzVDiuQVSV4GBw8gYT+WvvglX0t5FryvV6OpHSq4dkXNdToFNYGv9PxD/HWc3Q
UUwK4pH6yvlGtafsMSHxMONF0vIpa2S7Ut7fE3+kXmys775+ekADKdYMbpkSqYM=
=053A
-----END PGP SIGNATURE-----

--oYrjhH26xX5Rz9aF--

--===============6960680880353254601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6960680880353254601==--
