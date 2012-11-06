From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: mxs-pcm: Fix fifo size
Date: Tue, 6 Nov 2012 10:07:06 +0100
Message-ID: <20121106090706.GJ5044@opensource.wolfsonmicro.com>
References: <1351703171-27855-1-git-send-email-festevam@gmail.com>
 <20121102150627.GE4413@opensource.wolfsonmicro.com>
 <CAP1dx+zSmfEeih4DP3=E-r5HZUYmEAf07WzTmgYypxP8DJ73RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0271089028195631627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13DCE26172D
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 10:07:08 +0100 (CET)
In-Reply-To: <CAP1dx+zSmfEeih4DP3=E-r5HZUYmEAf07WzTmgYypxP8DJ73RA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0271089028195631627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 03, 2012 at 04:04:02AM +0800, Dong Aisheng wrote:
> On 2 November 2012 23:06, Mark Brown
> > On Wed, Oct 31, 2012 at 03:06:11PM -0200, Fabio Estevam wrote:

> >> According to MX28 Reference Manual the SAIF FIFO contains four 32-bit entries.

> >> -     .fifo_size              = 32,
> >> +     .fifo_size              = 4,

> > fifo_size should be specified in bytes so the original code looks
> > correct?

> Then, probably it should be 16.

Yup.

> BTW, it seems this param is not used anymore:
> http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s05.html
> That may be the reason why i see some other platforms pcm code just
> set fifo_size to 0.

Hrm, right - that'll be why nobody noticed.  Guess it doesn't matter any
more.

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmNL3AAoJELSic+t+oim9BFMQAIl5c3TczTurvq39twNQ/iq4
Ce7tXYGtYjKX0FxRthtCj7+OoeS5FWVndZr6hKcUlJSCaFRl7yf32kqn00/NKlu5
4HgW8xP3KKSkNmNiky1hvuYLVXnbeBJj+5Rbu9d9jKk+EIBIh7kTVzk+5fJOGnZS
DUxEWMbgCKE1GeWheH732ZPfsCFZ3Bb7gstOS42WhKzH12ij428OHHRS52h/68Fs
S73/NZyGN4m4aAZc0Cv92j+//A/HSGKT4fDwN6REHkRf8WaiIAtUoHiqfoG+0SSN
aXfsHFw3D6g6ig+Xhj+B+RM6SrneYCJTqgsILFsT2pT7WNpJgsRG48jTRUw5cq62
du62NJNPkBNzuayXhJphCx5xjgODGjzun8LrJY3Et9re+9RQ2ZcS7O/sxBOAEOdb
hXVPbG0MC7VftFknyfqr9+h9UUsHcQMrPn8uhGBZXngwokXU0bn5OXlAkAoNsZ6q
oCD0jrBQHlPxbTrBKtM3L2sFTHK+wmardLKijxB+y2ZsooLVQLR5tEHzc4By4gDw
T+VvH1wgkPfY5pFpXuup0uV5//VHuqQ1l12+asVcNW3UefPUcE2KBcDWDlOcTXJ1
xklr7teCQvmViSmaRQi1cfS75rMDyKUwvYbQm8RnToBn5aVuL2xXou/fn2lI/6EM
z8f85UJSp+o+lZjmpeaV
=BWWs
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--

--===============0271089028195631627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0271089028195631627==--
