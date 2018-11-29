From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset
 for stable amp reset
Date: Thu, 29 Nov 2018 11:26:12 +0000
Message-ID: <20181129112612.GB10570@sirena.org.uk>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
 <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
 <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6168248086368912137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 138C6267B21
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 12:26:15 +0100 (CET)
In-Reply-To: <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Grundler <grundler@chromium.org>
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, RyanS.Lee@maximintegrated.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, Benson Leung <bleung@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============6168248086368912137==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2018 at 05:55:48PM -0800, Grant Grundler wrote:
> On Wed, Nov 28, 2018 at 9:07 AM Ryan Lee <RyanS.Lee@maximintegrated.com> wrote:

> > >Not seeing a changelog here like I asked for :(

> > Actually I added changelog as below. Do you mean this is not sufficient?

> The text is probably sufficient but not in a format that Mark can
> directly apply.
> Please take a quick look at Documentation/process/submitting-patches.rst.

> Mark wants the "commit message" to be before the '---' line. So move
> the "Changes:" text up to become the commit message and drop the
> "Changes" line. That should explain why this commit is needed and
> include the S-o-B line.

Right.  If you compare what's in git and what you're sending with other
commits and mails and make sure everything looks similar you're probably
on the right track.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv/zL8ACgkQJNaLcl1U
h9BeRQgAgAjGco/fX0T1ZBLAAW+icaDcGI7xh+x8uPXi7r+v6p8h3eIr2fYnunq9
9qFo5RF4YcQYJ8LecDnKQaaH7hqWUzhz2+I1A91LkCylSW2CesdurtGHUuKpsSaa
cX8+2P1oisBbkaz5JB/cUWp9mvmhK/IUv1nSK6FOw3QorC7kdz4lwBX+nP6d/7Vy
LAtyClMoffoP2INZj02SL/UTIR42QgKqgeZd1okNzOGy69CUAyDx3XBONyULTejY
unSa8STYd7SkpivuQ+XT1YDOI0YAWnNAschHq4eJhTFjaMohJIfuDe1bCuN/pXG6
UwW3ucG47FB4Af7bNvebS7PLaK0hMQ==
=vLKa
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

--===============6168248086368912137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6168248086368912137==--
