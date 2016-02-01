From: Mark Brown <broonie@kernel.org>
Subject: Re: sound: use-after-free in snd_seq_deliver_single_event
Date: Mon, 1 Feb 2016 12:20:18 +0000
Message-ID: <20160201122018.GC4455@sirena.org.uk>
References: <CACT4Y+Zd66+w12fNN85-425cVQT=K23kWbhnCEcMB8s3us-Frw@mail.gmail.com>
 <20160201111625.GB4455@sirena.org.uk>
 <CACT4Y+YXXYWUGSZ5y=ZHPJXVAKXeEXLn8vjkpm+xx98yfo4dxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+YXXYWUGSZ5y=ZHPJXVAKXeEXLn8vjkpm+xx98yfo4dxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 12:22:18PM +0100, Dmitry Vyukov wrote:
> On Mon, Feb 1, 2016 at 12:16 PM, Mark Brown <broonie@kernel.org> wrote:

> > I'm not sure how you're working out who to send these to but all these
> > reports you've been sending have been for ALSA core which I rarely look
> > at closely, I mostly look at ASoC.  Might be worth looking into so
> > people don't start zoning out things that look like misdirected stuff
> > (I just noticed myself doing that with this).

> I am using scripts/get_maintainer.pl -f  the involved files. If it
> produces wrong results, please update MAINTAINERS.

You should never rely on the output of get_maintainers without review,
it's prone to both false positives and false negatives.  Given that
Sakamoto-san does not seem to appear in MAINTAINERS at all and you've
not managed to find Liam who's a comaintainer for all the ASoC stuff I
suspect you're doing this with --git enabled which is especially prone
to false positives since it tends to identify people who are just doing
global cleanup work and aren't particularly interested in a given file.
As far as I can tell this is how I'm getting pulled in too rather than
MAINTAINERS.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr02CAAoJECTWi3JdVIfQ/HoH/0EQrTXcA9t39MQNC4DYesHR
bO1PqArAAyZg9pxMoc0MNSGFROp4PDOBuAUBJwc22JBYmX0C0IlyTJMoLa9x5xvc
c9vtYON1DGEI+ZmwZ0ExBnOzlEJoJe8iiO9bvzwHLLRV3LcdIVm781ijIpn58VsU
bLIO8zeyNXRSVvIyT6y68/kbbS8DIcG9iNmuFfrII7LUggzytsWi/lMWxgIh6Tf/
i4jBw5xLNZfsF5EhZd5puGjiLnwaygyQBXu9tF6fTCYK8la3X02wlFwdfT6yxy1u
s3BJVtZ4XZJe4+q3352SACQfgiemFE6nTB3Z4VJR+F1/9SgD2e9vdZfcBFOTR7c=
=/fYL
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
