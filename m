From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: use SNDRV_PCM_FMTBIT_* for
	format bitmask
Date: Tue, 26 May 2015 10:44:22 +0100
Message-ID: <20150526094422.GI21577@sirena.org.uk>
References: <5560AB9D.1010807@maciej.szmigiero.name>
 <s5h382j29ey.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5682221619159809832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 473DD2614A9
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 11:44:38 +0200 (CEST)
In-Reply-To: <s5h382j29ey.wl-tiwai@suse.de>
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Lars-Peter Clausen <lars@metafoo.de>, Matt Reimer <mreimer@sdgsystems.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============5682221619159809832==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="67L3nkltNbzPAvlZ"
Content-Disposition: inline


--67L3nkltNbzPAvlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 07:29:57AM +0200, Takashi Iwai wrote:
> Maciej S. Szmigiero wrote:

> > Found out by sparse on 0-day kernel tester.

> Wow, that made me wonder how these drivers could actually work.

AFAICT the bits were being set by being ored in from the sequential
values.

> BTW, how did you detect it?  Any static analyzer like sparse or
> smatch?  sparse didn't detect it at the last time I tried, IIRC...

Commit log says sparse.

--67L3nkltNbzPAvlZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZEB1AAoJECTWi3JdVIfQoYAH/R8qifIhxg3A7I0iS21tnnW6
lRp2JcWBHWY/2zF2cn9jl9ocVC2SGqA+VUXcA6NkduSSwUWuQzqK9frmaIG2I1Sk
hYh1faw1b4f2J1gDSWYxxRbVFy0HZTtUbQYwXkybhVpOjilg2PRMJSJ4bYQJbEe4
KvCH6t+WNwd2KYrtxfitJHNyrHG2xNEOcG/q05VceZmqCQYan652K6iROaRPzd+B
UbMwSIyWyISnAT0XBjDdXsPcnkCeWpREX0bSDSOsvRQLe3wuQXSpPHtKYxJp1KBM
jQbbCU9QN0oH963Om0rNGzKTjomb/jImX9KWejD/Y6KTvQ+xuK92fOnyxtYxMNg=
=vLCk
-----END PGP SIGNATURE-----

--67L3nkltNbzPAvlZ--

--===============5682221619159809832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5682221619159809832==--
