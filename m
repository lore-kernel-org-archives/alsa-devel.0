From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL
	pcm_{new, free}
Date: Tue, 14 Mar 2017 14:36:54 +0100
Message-ID: <20170314133654.w5neqkkaennht7lm@sirena.org.uk>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <20170309110918.getjla6iawgjpfrq@sirena.org.uk>
 <20170311002406.GA4586@google.com>
 <20170313125004.yrqranp3sxsfkmfx@sirena.org.uk>
 <20170313215256.GD4586@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7017219870631134762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CCBDE266E42
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 14:37:19 +0100 (CET)
In-Reply-To: <20170313215256.GD4586@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============7017219870631134762==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hqwo63np7ryzkuck"
Content-Disposition: inline


--hqwo63np7ryzkuck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2017 at 02:52:56PM -0700, Brian Norris wrote:

> Sure, I can understand frustration with essentially contentless "bug
> reports." And I got frustrated by a seemingly pat response that was
> (IMO) a bit mistargeted.

It *is* a pat response, it's one of the things I find I have to send
often enough that I've got a canned response for it - I find that if I
don't do things like that then after a while what gets sent becomes so
brief that unless you're really familiar with what's being said it can
be hard to understand the feedback.  It's tricky though because as you
say it's fairly obvious it's a form letter.

> BTW, I don't see the patch applied anywhere (and I have no reply -
> either manual or automated/patchwork - other than the above quote to say
> it was).

20170309102819.bx5paxtffvmvmuov@sirena.org.uk, fix/core  Didn't seem to
have made -next today, guess it'll hit tomorrow.

--hqwo63np7ryzkuck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljH8fUACgkQJNaLcl1U
h9DHnQf8Dp8TOITFj8fgGDolYRGo9V0Zq15Div9/IkTg9gItkzNzAafKTX7boUTk
sQ62PcxkP3NNK6Qy559LpcXIimbcmXPjVV/QtihndrU2zmwjSZt2nuuRS0CQwekT
8d7EGqYO+FL/QXiWog1u2gB6zxPQaymH86TUxPIrATM3U131OPHtdbnorf8hi6zQ
jXpz7bXsOlgPBwS0PB5hvVMZ1yFfyQAgec36erzHor5gZq/P+GZ6MPdMIT3H1uSz
EeF8cwahlA2hrPm+b8LP6qfeWKzRGUebcN8h3JPEEMaWZHJOWBcSdKJLSlHLu5FP
0qEEcbRv/dLl4Di/fJTI8+5m3l57WQ==
=dKFW
-----END PGP SIGNATURE-----

--hqwo63np7ryzkuck--

--===============7017219870631134762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7017219870631134762==--
