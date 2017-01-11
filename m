From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 18:06:58 +0000
Message-ID: <20170111180658.2yivagcwo4kgsp4e@sirena.org.uk>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
 <20170111145926.22jkebrb7ojemyhq@sirena.org.uk>
 <20170111150645.GB16045@osadl.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ee54mmdjcmuu4x7k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170111150645.GB16045@osadl.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ee54mmdjcmuu4x7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2017 at 03:06:45PM +0000, Nicholas Mc Guire wrote:
> On Wed, Jan 11, 2017 at 02:59:26PM +0000, Mark Brown wrote:

> > If you're doing conversions like this I'd expect us to be picking the
> > lower number rather than the higher number - people are saying "wait for
> > at least X and at most Y" and msleep() is "wait for at least X" so we
> > should be picking X.

> useleep_range() sets the timer to max and only if there happens to be a
> timer between min and max uses that - so the mean of runs is generally
> a bit above max. E.g.

Yes, but as fairly recently discussed somewhere on the lists (and IIRC
actually fixed) approximately no users expect or want that behaviour -
it's a really confusing interface given that sleep functions almost
always have a "delay up until X" interface and interfaces that can wake
things up earlier than the expected delay generally flag that condition.
The applications for the "delay for X but it's OK to wake me up this
much earlier" are really quite limited.  If you look at the conversions
that were done to usleep_range() you'll notice that most of them follow
this pattern and had their delays extended in the process.

--ee54mmdjcmuu4x7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh2dEEACgkQJNaLcl1U
h9BLGAf/efBfdCl6TcAGByMByEP7A7P4xJN7LRCVbAIZH7stU377kl5RxEXxZ6FJ
aKdYlwYgK9LN9ChKIhFzcJqyAHbcxkviUMvzw/aUtr/Vj0FbOwG610I0yR2Nzcjw
kEMV7VnMCyrMbpzsNMJ35wLWM1yAtepVCCohEmO5/4BRzz+UujXaOkGxMKFMAct1
BZebYET9PzbRpqJ9l8tU843wnjcbJfiJx7c6zB5UTQgo+Ea7gGo3+nwIXeycH0/C
oMx+p8e0407L93nV3ll+ujEoXFZ5/jpU4SortFd0rFUgd7cKnnGFWt9e4p9SxYkF
ivSd9u9t6fMbzRlLM7iAiHSHaX4OtQ==
=0x3B
-----END PGP SIGNATURE-----

--ee54mmdjcmuu4x7k--
