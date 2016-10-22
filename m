From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio miniconference at LPC/KS confirmed-
Date: Sun, 23 Oct 2016 00:30:55 +0100
Message-ID: <20161022233055.GS10208@sirena.org.uk>
References: <20160701155438.GU6247@sirena.org.uk>
 <20160825153940.GF6635@sirena.org.uk>
 <4788d7ff-0fd7-9d62-be74-72c5a143c999@sakamocchi.jp>
 <20161020141138.GM10208@sirena.org.uk>
 <6cfff6e4-5aaa-d4e6-8d78-18207788ef9c@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1004028334629468843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D42B2668F1
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2016 01:31:07 +0200 (CEST)
In-Reply-To: <6cfff6e4-5aaa-d4e6-8d78-18207788ef9c@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1004028334629468843==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zsAhXfiBV62A5hVr"
Content-Disposition: inline


--zsAhXfiBV62A5hVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 22, 2016 at 08:42:15AM +0900, Takashi Sakamoto wrote:

> 1. Add tracepoints to pcm parameter processing in ALSA PCM core
> In my memory of our previous mini audio conference, some issuers are
> addressed about pcm parameters. This is my WIP related to it. The aim is
> to monitor changes of pcm parameter refinement processing just after
> calling ioctl(HW_REFINE/HW_PARAMS). See my working branch:
> https://github.com/takaswie/sound/tree/trace-rules

Do we need to discuss this face to face - are there concerns people have
about adding tracepoints or something?  I think it's a good idea to do
the tracepoints, I'm just wondering if we're going to have much of a
discussion or if it'd be a very brief thing.

> 3. Dropping dice driver from ALSA firewire stack
> A fatal quirk apperard that the most of TCAT ASIC called as 'DICE'
> breaks the least significant protocol as a sound device[1][2]. The
> chipsets don't transfer PCM frames as the same as current sampling
> frequency (it's sampling transfer frequency in IEC 61883-6 word).
> This is my suggestion to drop dice driver from ALSA firewire stack.

I guess this is something that is mainly going to be discussed by a few
people?

--zsAhXfiBV62A5hVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYC/auAAoJECTWi3JdVIfQjAoH/2LCtPRlg3CmviJi/+fNIYZ4
yl6SeHxDIkcdVA+95uM/7swPZ1aipfgy0l2DXT8+LGRRQmx7GykHzwyy55eQmUvh
F9VIZl8Hh5+V/vgJpf+ikO+J1+Az1uyQ8H6q5k32sDpk3XXQZheelQf6k48OQR13
b3H8uJCWuMzt7UN+tp/40Q9JDk5vmW9yW6QCFS3nSgcFwic73PKgY3GTkSIS5QSu
gyJMyBSpTTIeyANeaKPJvvW42D0gcGwWFBtCy/b9T3t9v+9U2rHC/VuE9pRZBUas
c2kK8fseGj2bM+KUVvGf7SLmPPc2eDb2u/4OVrxJ94T9of/AnpT8wl3H5WauHOU=
=/yV2
-----END PGP SIGNATURE-----

--zsAhXfiBV62A5hVr--

--===============1004028334629468843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1004028334629468843==--
