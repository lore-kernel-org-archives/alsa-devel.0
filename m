From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Fri, 18 Sep 2015 14:54:27 +0100
Message-ID: <20150918135427.GI12027@sirena.org.uk>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7806585636337144218=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 134A5260415
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 15:54:38 +0200 (CEST)
In-Reply-To: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, albertchen@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============7806585636337144218==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1btP1oVgwiP6ltnh"
Content-Disposition: inline


--1btP1oVgwiP6ltnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 01:50:58PM -0700, Anatol Pomozov wrote:

> Per discussion at [1] currently there is no clear definition of what is FSYNC polarity.
> Different drivers use its own definition of what is "normal" and what is "inverted"
> fsync in different modes. This leads to compatibility problems between drivers.

Please keep changelogs wrapped at under 80 columns as is covered in
SubmittingPatches and please write free standing changelogs that don't
require reference to external discussions unless there is a strong
reason to do so.  This makes both the e-mails and the git changelogs
easier to read, ensuring that people don't need to go online to read
things and links don't go bad.

> + * For BCLK:
> + *  - "normal" polarity means signal sensing happens at rising edge of BCLK
> + *  - "inverted" polarity means signal sensing happens at falling edge of BCLK

This is OK, though it's more normal to say that data "is available" or
"is sampled" - the term "signal sensing" is a bit unusual.

> + * For FSYNC:
> + *  - "normal" polarity means frame starts at rising edge of FSYNC
> + *  - "inverted" polarity means frame starts at falling edge of FSYNC

This isn't true (or at least isn't clear) for I2S based modes, normally
the left channel is thought of as the first channel sent and the left
channel starts on the falling edge of LRCLK, not the rising edge (which
signals the start of the right frame).  It is true for DSP based modes.

It's probably going to be more sensible to define the modes and then
define inversion relative to the definition of the modes (which is
basically what the existing documentation is doing).  I think what we
really need here is an explicit definition of the DSP modes.

--1btP1oVgwiP6ltnh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/BeTAAoJECTWi3JdVIfQ8qEH/j4aGZ1xKk9+QDEEOgiN6mRT
XGppjCNkcxECrOj6khEdQvZLCKwmq1z7OcfAJFrHqV+WMPR3L8aM0XKF2Iwqb50+
F3ayMQmDOXch73Ec8emrOTcrfcEQl5FBjMCH1omTJcWWvvFuQo5Jj3Wlm15fdGOj
tnw3IQ3gqiHhx2h4P6cOwv2j39yhKHr/N8xGAkrth7tXJXr8MbuefWKdtdph0NgB
7/OMX3AL2dyjPFe6cFwYR/hFXa+u1BpwMKLSEDydo6MHhq2NzpBqSbymQrEWqmz6
E5gBs+s6p8rEaAiqS1DDyQrQwWMA4Z0UhfWrQzntKeWa0NA+8Uo2eGYpMxNFn5I=
=W57r
-----END PGP SIGNATURE-----

--1btP1oVgwiP6ltnh--

--===============7806585636337144218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7806585636337144218==--
