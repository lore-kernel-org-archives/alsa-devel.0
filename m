From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Fri, 1 Feb 2019 12:59:43 +0000
Message-ID: <20190201125943.GE20797@sirena.org.uk>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <s5hsgx9ckrf.wl-tiwai@suse.de>
 <20190131122624.GA20797@sirena.org.uk>
 <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
 <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
 <CACL=Q7y==PFTdknurbg-yZPoBjYh6n5Lduyy32Us1HepeVU-bg@mail.gmail.com>
 <CAEiLdJb-QLmtp0vWxvCj6Kb3rmkEx8dKndmBovHvx7hk93pt_Q@mail.gmail.com>
 <s5h36p8d0v8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4347163987503734931=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1087266FA5
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 13:59:46 +0100 (CET)
In-Reply-To: <s5h36p8d0v8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Phil Burk <philburk@google.com>, Zach Riggle =?utf-8?B?8J+Wlg==?= <riggle@google.com>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4347163987503734931==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 09:32:27PM +0100, Takashi Iwai wrote:
> On Thu, 31 Jan 2019 20:54:33 +0100,
> Zach Riggle =F0=9F=96=96 wrote:

> > (1) Can the buffer be mremap()ed with a different offset=C2=A0into the =
buffer?=C2=A0
> > This was a concern in the past and the reason for the anon_inode stuff =
at
> > all.=C2=A0 I believe that as long as the *size* of the mapping doesn't =
change,
> > Linux mm will gladly permit mremap() without informing the driver.

> Could you elaborate which perspective of mremap() can be a big
> problem?  The driver interface does nothing but a standard mmap for
> now.

I believe the issue was that if someone could remap the buffer to gain
access to memory outside the memory allocated for the PCM buffer that
would be a problem.  To be honest I'm surprised that this might be a
general issue with mmap().

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxUQrwACgkQJNaLcl1U
h9Axiwf/cLd0Yow3w+1fKvLx8+W4SAnaLVlyRI+lP8gHX/QGaJ908xrdqhEG4aQW
Qu/upgsA3/Z9caZLESMmUC0igRQPov0oVf+dXPQeZ2e3ZR16M2/l4MKlb/HWHRUq
AaZGtBGI/u3bZMhzarYn9/nk8NCo+LzlsHGygwI/ykxqRvuEmjcdYmHXqYtobEvO
A6ZNz7KOoOCOzlvLE0U4jo3Eis1wXFbs9IhYCurJM+JPayPNgIOsCcp3UVunTmB1
uQfT935c6pm5lXVYftaMSWVgjYii5GodzNAjnHRsMJfBf7hUvGYxYXOIQqx5Hoc9
LI/H28Q3E7Ea22mOeep2JKpaPHlbIw==
=6QJb
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

--===============4347163987503734931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4347163987503734931==--
