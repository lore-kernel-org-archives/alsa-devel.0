From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] A question regarding open ioctl for user
 space in ASoC driver.
Date: Tue, 20 May 2014 01:18:34 +0100
Message-ID: <20140520001834.GJ12304@sirena.org.uk>
References: <20140516105939.GA2544@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1571254350533433116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC712615B6
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 02:18:51 +0200 (CEST)
In-Reply-To: <20140516105939.GA2544@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1571254350533433116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ja/I8q7MYCpKdcsP"
Content-Disposition: inline


--Ja/I8q7MYCpKdcsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 06:59:41PM +0800, Nicolin Chen wrote:

> I have an ASoC driver in my own branch and I'm going to get it upstream
> in the months ahead. The driver is designed for Freescale ASRC module,
> Asynchronous Sample Rate Converter. It has the capability to convert audio
> data without involving software conversion like SRC function in ALSA-lib.
> But before I try to revise and send the driver, I've a few questions here.

So, clearly custom ioctl() calls are not a good idea.

> 1) P2P, peripheral to peripheral, regards ASRC as a FE (front end link)
>    corresponding to a BE (back end link like ESAI<->CS42888). The P2P
>    function resolves a problem of unsupported sample rates for BE that
>    we can convert the unsupported audio format to a supported one before
>    we send the data into BE. It also has better quality and less CPU
>    loading comparing to ALSA-lib's SRC function.

>    * For this function, I don't see any critical problem here. But...

This is moderately common in mainline already.  You shouldn't need to
have any custom code - we should just be able to figure out that the SRC
is needed (and a quick glance at your out of tree code shows now ioctl()
so that's fine as you say).

> 2) M2M, memory to memory, can simply make ASRC as a sample rate converter
>    without playback via any BE sound card, just like using any software
>    to convert a WAV file in one sample rate to another WAV in a required
>    sample rate. The driver has its self-designed application to compelte
>    this function by sending the audio data from a wave file into a misc
>    device via non-generic ioctl:

I would expect this to be handled by just routing the audio between the
two front ends using DAPM/DPCM rather than by having a new kernel API.
DPCM is mostly Liam's area so I'll defer to him on exactly how DPCM
would figure that out - even with pure DAPM it's something we should do
better with than we do.  I don't know if there are examples in the Intel
code people could refer to?

If nothing else representing the ASRC block as a CODEC would do the
trick though that doesn't entirely play well with DPCM, it is kind of
doing the right thing though in that the ASRC block terminates two
digital paths.  I'm not loving the elegence there though.

--Ja/I8q7MYCpKdcsP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTep9XAAoJELSic+t+oim9Jg8P/R0DmaeryjShDrWG/eM4yvGm
H7ZGhCTrjwz9KQMmOlA/YGWpqDwsmRvt+7zxhINiFnRoiGbn58NjNZPdRgsHK8JC
SBtx8VU1ksHVY6PyeDIKRNyQY4DMCIB4S0ZAGEgeDiytVBsHxiFAXTtRLMZ3Epuj
suckniSq55KeifhiDyf9ns+sRTocawFmF5BM9Bt6Updfo6B3JAXPey2IRXZPJGMA
+lonyjaGIdGdUHH57iH3w3C7uhs3l2Sp4Xycrr/wWNYq7F0BRnW/40VhJc1Zommn
riZTpFQacYl6eeSu3SMA3Li84/d4nf8yBtx0bQO2U0FuHmSGm1Y6gBNTlPY1kWoG
qsnP4Y8yyMpsX8CdgBDfzUvRnG5xFwDfDBJc/shvRVqB9UGR72gEX0HMTPeif7c0
K+kAlKu28wPhlHDLn4qBny0sC0sdnDfxw3ymEHasK7szyVvfuoF9O5fFOPit+XMP
8+K+8MQ4WWav4DLFKICZlcmi+B6wgqavOcOjMVKEdpJFcHNkhl2uxxvuqxnTMtLD
01GhZbYSQe1NGG+gtGbDkniBsq7wfpcWTgKmE+kGLo1aJnuxUeLK9YH+5s8UVdPp
m9XeGH0qLPtFHhgxiHr+0ZjFpDmlQEu54qTntQIS91hQv/N5dPuTL6hKzHJCViMC
/4l629i+G2wrGvPT4Hg5
=igmE
-----END PGP SIGNATURE-----

--Ja/I8q7MYCpKdcsP--

--===============1571254350533433116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1571254350533433116==--
