From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/20] ASoC: rsnd: add Synchronous SRC and
 U/O error salvage support
Date: Tue, 24 Feb 2015 23:56:50 +0900
Message-ID: <20150224145650.GQ6236@finisterre.sirena.org.uk>
References: <87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>
 <20141230171032.GQ17800@sirena.org.uk>
 <874ms6rraj.wl%kuninori.morimoto.gx@renesas.com>
 <20150106183319.GS2634@sirena.org.uk>
 <87a91vp6s8.wl%kuninori.morimoto.gx@renesas.com>
 <54AEC20C.90706@linux.intel.com>
 <20150110113216.GC4160@sirena.org.uk>
 <87vbkap3n2.wl%kuninori.morimoto.gx@renesas.com>
 <20150119204921.GJ2809@sirena.org.uk>
 <87oapub3rf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6092351769177067411=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFD9E2604BB
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 15:57:49 +0100 (CET)
In-Reply-To: <87oapub3rf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Tim Cussins <timcussins@eml.cc>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6092351769177067411==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrPCcEe+QcWQl/Hn"
Content-Disposition: inline


--yrPCcEe+QcWQl/Hn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2015 at 02:10:11AM +0000, Kuninori Morimoto wrote:

> > This really would be better done with DPCM with the userspace control
> > being provided by the driver for the tuner or the machine driver and
> > passed through to set the rate of the back end.  Do you think that's
> > achieveable (even if it's just a mostly dummy DAI here)?  That way if
> > this is used in a system with a CODEC with a real driver on the end of
> > the link things should just work.

> Can I confirm about this ? This means, we can..

>  - add "sampling rate convert" support on DPCM
>    (= our "static" sampling rate convert can use it)
>  - add "sampling rate convert interface" support for userland on DPCM
>    (= our "dynamic" sampling rate convert can use it)

> I think this is achieveable.

Yes.

> My concern about this is card driver with DT.
> I and Mark talked about it in LinuxCon before, and adding DPCM support with DT
> on simple-card is very difficult (= simple-card is not "simple" today...)
> So, I will create new sound card driver which includes DPCM DT support for this purpose.
> Then, should I create "renesas-sound-card" under sound/soc/sh ?
> or can I create "multi-card" (I don't know this is good naming...) under sound/soc/generic ?
> If we can select later choice, it will have very limited feature, but simple DPCM support

A Renesas card (well, a SoC specific name is probably better) seems OK,
though as I said elsewhere collaborating on the generic graph work
*might* be a good way forwards too.  That definitely shouldn't be a
requirement for getting things done though.

--yrPCcEe+QcWQl/Hn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7JExAAoJECTWi3JdVIfQx9sH/jNFqXw+nbZn8MjVeP1rcU29
3No7lmQUvsRsjo9s6YSMjivBLnhZ/BQfahN/Hdjm6oq5qW2ri5LQzXJzyELcBUod
HPjTQynwWtVb+zAD7+lbYkkdyfQmgMWtdrQaZ/xFHAdmEiSOYqUdC/1Qbjx7sszm
nTmFRjNwlmh4oSwdsnAXQACpAM5oibcFHa1es0RDBq8JAr2FgYhJdkCZPcc1OrYl
LMdLEFfiqIC/hcm2kWEOj00gh10Mjchf5t7LXl++W4ZFWPODR2WG2ACcZy6l/diA
Hf7qufgT8jQCnenCSM1zBnA7FA2XhkRUiqST/Wp479yMxHRUFbOAaBpB6amrTKI=
=yMTo
-----END PGP SIGNATURE-----

--yrPCcEe+QcWQl/Hn--

--===============6092351769177067411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6092351769177067411==--
